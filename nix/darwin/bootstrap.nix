self:
{
    lib,
    pkgs,
    ...
}:

{
    nix.settings = {

        auto-optimise-store = false;
        experimental-features = [
            "nix-command"
            "flakes"
        ];

        extra-platforms = lib.mkIf (pkgs.system == "aarch64-darwin") [
            "x86_64-darwin"
            "aarch64-darwin"
        ];

        # Recommended when using `direnv` etc.
        keep-derivations = true;
        keep-outputs = true;
    };

    # Test if i still need this
    nix.channel.enable = false;

    environment.shells = with pkgs; [
        bashInteractive
        zsh
    ];

    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 6;


}