{ pkgs, ... }:
{
    system.defaults.NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
    };

    system.defaults.dock = {
        autohide = true;
        persistent-apps = [
            "/System/Applications/Launchpad.app"
            "/Applications/Safari.app"
            "${pkgs.alacritty}/Applications/Alacritty.app"
        ];
    };

    system.defaults.finder = {
        FXPreferredViewStyle = "clmv";
        AppleShowAllFiles = true;
        ShowPathbar = true;
        NewWindowTarget = "Home";
    };

    # Login and lock screen
    system.defaults.loginwindow = {
        GuestEnabled = false;
        DisableConsoleAccess = true;
    };
}