{ config, ... }:
{
    # Git
    programs.git.enable = true;

    programs.git.extraConfig = {
        push.autoSetupRemote = true;
    };

    programs.git.ignores = [
        "*~"
        ".DS_Store"
    ];

    programs.git.userEmail = config.home.user-info.email;
    programs.git.userName = config.home.user-info.fullName;

}