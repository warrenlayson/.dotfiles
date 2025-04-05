{ pkgs, lib, ... }:
{
    programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
    };

    programs.starship.enable = true;
    programs.tmux.enable = true;
    programs.lazygit.enable = true;

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        oh-my-zsh.enable = false;

        shellAliases = {
            ll = "ls -l";
            update = "darwin-rebuild switch --flake ~/.dotfiles/nix#mbpro";
            sshconfig = "$EDITOR ~/.ssh/config";
            flakeconfig = "$EDITOR ~/.dotfiles/nix/darwin/flake.nix";
            zshsource = "source ~/.zshrc";
            colimaw = "colima -p wingaru";
        };
        history = {
            extended = true;
        };
    };

    home.packages = with pkgs; [
        stow
        neovim
        bitwarden-cli
        ollama
        go
    ] ++ lib.optionals stdenv.isDarwin [
        cocoapods
        m-cli
    ];
}