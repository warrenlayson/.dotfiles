{
  description = "Zenful Darwin System flake";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-homebrew= {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
  };

  outputs = inputs@{ self, nix-darwin, home-manager,... }:
  let
    inherit (inputs.nixpkgs-unstable.lib)
        attrValues
        singleton
        optionalAttrs
        makeOverridable
        ;

    homeStateVersion = "24.11";
    nixpkgsConfig = {
        config = {allowUnfree = true;};
        overlays = attrValues self.overlays
            ++ singleton (
                final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
                    # inherit (final.pkgs-x86)
                })
            );
    };
    primaryUserDefaults = {
      fullName = "Warren Angelo H. Layson";
      email = "warrenlayson@gmail.com";
    };
  in
  {
    lib = inputs.nixpkgs-unstable.lib.extend (
      _: _: {
        mkDarwinSystem = import ./lib/mkDarwinSystem.nix inputs;
      }
    );

    # Overlays {{{

    overlays = {
        pkgs-unstable = _: prev: {
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
        apple-silicon = final: prev: optionalAttrs (prev.stdenv.system == "arch64-darwin") {
            pkgs-x86 = import inputs.nixpkgs-unstable {
                system = "x86_64-darwin";
                inherit (nixpkgsConfig) config;
            };
        };
    };

    # }}}

    # Modules {{{
    
    darwinModules = {
      bootstrap = import ./darwin/bootstrap.nix self;
      defaults = import ./darwin/defaults.nix;
      general = import ./darwin/general.nix;
      homebrew = import ./darwin/homebrew.nix;

      users-primaryUser = import ./modules/darwin/users.nix;
    };

    homeManagerModules = {
      alacritty = import ./home/alacritty.nix;
      git = import ./home/git.nix;
      starship = import ./home/starship.nix;
      packages = import ./home/packages.nix;

      home-user-info =
        { lib, ... }:
        {
          options.home.user-info =
            (self.darwinModules.users-primaryUser {
              inherit lib;
            }).options.users.primaryUser;
        };
    };

    # }}}

    # System Configuration {{{

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mbpro
    darwinConfigurations = {
        # Minimal macOS configuration to bootstrap systems
        bootstrap-x86 = makeOverridable nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [
            ./darwin/bootstrap.nix
            { nixpkgs = nixpkgsConfig; }
          ];
        };
        bootstrap-arm = self.darwinConfigurations.bootstrap-x86.override {
          system = "aarch64-darwin";
        };

        WarrenBookPro = makeOverridable self.lib.mkDarwinSystem (
          primaryUserDefaults
          // {
          username = "warren";
          nixConfigDirectory = "/Users/warren/.dotfiles/nix";
          modules =
            attrValues self.darwinModules
            ++ singleton {
              nixpkgs = nixpkgsConfig;
              networking.computerName = "Warren's 💻";
              networking.hostName = "WarrenBookPro";
              networking.knownNetworkServices = [
                  "Wi-Fi"
              ];
              nix.registry.my.flake = inputs.self;
            };
          inherit homeStateVersion;
          homeModules = attrValues self.homeManagerModules;
          }
        );

        WarrenMiniPro = makeOverridable self.lib.mkDarwinSystem (
          primaryUserDefaults
          // {
          username = "warrenlayson";
          nixConfigDirectory = "/Users/warrenlayson/.dotfiles/nix";
          modules =
            attrValues self.darwinModules
            ++ singleton {
              nixpkgs = nixpkgsConfig;
              networking.computerName = "Warren's Mini 💻";
              networking.hostName = "WarrenMiniPro";
              networking.knownNetworkServices = [
                  "Wi-Fi"
              ];
              nix.registry.my.flake = inputs.self;
            };
          inherit homeStateVersion;
          homeModules = attrValues self.homeManagerModules;
          }
        );
    };

    # }}}

  };
}
