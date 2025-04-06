{ pkgs, ... }:
{
    # Networking
    networking.dns = [
        "192.168.0.20" # pihole
        "1.1.1.1" # cloudflare
    ];

    # Fonts
    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];

    # Storage management
    nix.gc.automatic = true;
    nix.gc.interval.Hour = 3;
    nix.gc.options = "--delete-older-than 15d";
    nix.optimise.automatic = true;
    nix.optimise.interval.Hour = 4;
}