{ config, lib, ... }:
{
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
        "firefox"
        "google-chrome"
        "httpie"
        "malwarebytes"
        "viber"
        "visual-studio-code"
    ];

    homebrew.brews = [
    ];
}