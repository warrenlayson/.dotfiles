{ self, pkgs, lib, ... }:
{
    environment.systemPackages = with pkgs; [
        bashInteractive
        zsh
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];



    # Storage management
    nix.gc.automatic = true;
    nix.gc.interval.Hour = 3;
    nix.gc.options = "--delete-older-than 15d";
    nix.optimise.automatic = true;
    nix.optimise.interval.Hour = 4;


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

    # Nix-darwin specific
    system.defaults.dock = {
        autohide = true;
    };

    system.defaults.finder = {
        FXPreferredViewStyle = "clmv";
        AppleShowAllFiles = true;
    };

    system.defaults.NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
    };

    networking.computerName = "Warren's 💻";
    networking.hostName = "WarrenBookPro";
    networking.knownNetworkServices = [
        "Wi-Fi"
    ];

    # Homebrew
    homebrew.enable = true;
    homebrew.onActivation.autoUpdate = true;
    homebrew.onActivation.cleanup = "zap";
    homebrew.global.brewfile = true;

    homebrew.masApps = {
        Bitwarden = 1352778147;
        Keynote = 409183694;
        Numbers = 409203825;
        Pages = 409201541;
        Messenger = 1480068668;
        Xcode = 497799835;
    };

    homebrew.casks = [
        "discord"
        "docker"
        "firefox"
        "google-chrome"
        "httpie"
        "malwarebytes"
        "viber"
        "visual-studio-code"
    ];

    homebrew.brews = [
        "docker-credential-helper"
    ];
}