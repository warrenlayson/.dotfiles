{ config, lib, pkgs, ... }:
let 
    inherit (lib) attrValues mkIf elem;

    mkOpRunAliases = 
        cmds: lib.genAttrs cmds (cmd: mkIf (elem pkgs.${cmd} config.home.packages) "op run -- ${cmd}");
in
{

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    programs.zsh.enable = true;
    programs.zsh.dotDir = ".config/zsh";
    programs.zsh.history.path = "${config.xdg.stateHome}/zsh_history";
    programs.zsh.autosuggestion.enable = true;
    programs.zsh.syntaxHighlighting.enable = true;
    programs.zsh.enableCompletion = true;

    programs.tmux.enable = true;
    programs.lazygit.enable = true;



    home.packages = attrValues (
        {
            # Some basics
            inherit (pkgs)
                curl
                wget
                stow
                ripgrep # # better version of `grep`
                fd # fancy version of find
                ;

            # Dev stuff
            inherit (pkgs)
                go
                jq
                pnpm
                ;
        } 
        // lib.optionalAttrs pkgs.stdenv.isDarwin  {
            inherit (pkgs)
                cocoapods
                m-cli
            ;
        }
    );
}