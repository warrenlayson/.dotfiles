{
  description = "Zenful Darwin System flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager.url = "github:nix-community/home-manager";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
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

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, home-manager,... }:
  let
    inherit (nixpkgs.lib)
        attrValues
        singleton
        optionalAttrs
        ;
    nixpkgsConfig = {
        config = {allowUnfree = true;};
        overlays = attrValues self.overlays
            ++ singleton (
                final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
                    # inherit (final.pkgs-x86)
                })
            );
    };
  in
  {

    # Overlays {{{

    overlays = {
        apple-silicon = final: prev: optionalAttrs (prev.stdenv.system == "arch64-darwin") {
            pkgs-x86 = import nixpkgs {
                system = "x86_64-darwin";
                inherit (nixpkgsConfig) config;
            };
        };
    };

    # }}}

    # System Configuration {{{

    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mbpro
    darwinConfigurations = {
        WarrenBookPro = nix-darwin.lib.darwinSystem {
            specialArgs = { inherit self; };
            system = "aarch64-darwin";
            modules = [
                ./configuration.nix
                home-manager.darwinModules.home-manager
                {
                    nixpkgs = nixpkgsConfig;
                    users.users.warren.home = "/Users/warren";
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.warren = {
                        imports = [
                            ./home.nix
                        ];
                	    home.stateVersion = "24.11";
                    };
                }
            	nix-homebrew.darwinModules.nix-homebrew
            	{
            	  nix-homebrew = {
            	    enable = true;

            	    enableRosetta = true;
            	    user = "warren";

            	    taps = {
            	      "homebrew/homebrew-core" = homebrew-core;
            	      "homebrew/homebrew-cask" = homebrew-cask;
            	      "homebrew/homebrew-bundle" = homebrew-bundle;
            	    };

            	    mutableTaps = false;
            	  };
            	}
            ];
        };
    };

    # }}}

  };
}
