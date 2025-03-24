{
  description = "Zenful Darwin System flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
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
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
          pkgs.vim
        ];

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
      ];

      system.defaults = {
        dock.autohide = true;
        dock.persistent-apps = [
            "${pkgs.alacritty}/Applications/Alacritty.app"
            "/System/Applications/Mail.app"
            "/Applications/Safari.app"
        ];
        finder.FXPreferredViewStyle = "clmv";
        finder.AppleShowAllFiles = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
      };

      homebrew = {
        enable = true;
	brews = [
	  "docker-credential-helper"
    "git-lfs"
	];
    casks = [
        "firefox"
        "httpie" 
        "messenger"
        "malwarebytes"
        ];
	onActivation.cleanup = "zap";
      };


      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mbpro
    darwinConfigurations."mbpro" = nix-darwin.lib.darwinSystem {
      modules = [ 
      	configuration 
	home-manager.darwinModules.home-manager
	{
	  users.users.warren = {
	    name = "warren";
	    home = "/Users/warren";
	  };
	  home-manager.users.warren = { pkgs, lib,...}: {
        nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
         "raycast"
        ];
	    home.packages = [ 
	      pkgs.stow
	      pkgs.neovim
	      pkgs.raycast
          pkgs.neofetch
          pkgs.bitwarden-cli
          pkgs.ollama
	    ];

	    home.sessionVariables = {
	      EDITOR = "vim";
	    };
        programs = {
            pyenv = {
                enable = true;
                enableZshIntegration = true;
            };
            tmux.enable = true;
            lazygit.enable = true;
            fd.enable = true;
            fzf.enable = true;
            ripgrep.enable = true;
            alacritty.enable = true;
            starship.enable = true;
            direnv = {
                enable = true;
                enableZshIntegration = true;
                nix-direnv.enable = true;
            };
            zsh = {
              enable = true;
              enableCompletion = true;
              autosuggestion.enable = true;
              syntaxHighlighting.enable = true;
              oh-my-zsh.enable = false;
              initExtra = ''
                neofetch
              '';

              shellAliases = {
                ll = "ls -l";
                update = "darwin-rebuild switch --flake ~/.dotfiles/nix/darwin#mbpro";
                sshconfig = "$EDITOR ~/.ssh/config";
                flakeconfig = "$EDITOR ~/.dotfiles/nix/darwin/flake.nix";
                zshsource = "source ~/.zshrc";
                colimaw = "colima -p wingaru";
              };
              history = {
                extended = true;
              };

            };
        };

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
}
