{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;

    package = pkgs.gitAndTools.gitFull;

    lfs.enable = true;

    difftastic.enable = true;

    ignores = [
      "*~"
      ".DS_Store"
      ".envrc"
      ".direnv"
      ".vscode"
      ".idea"
      "dist-newstyle/"
      "clear\\ /"
    ];

    signing = {
      key = "0x8FCFC51056668A0F";
      signByDefault = true;
    };

    aliases = rec {
      lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
      lg = lg1;
    };

    extraConfig = {
      core.autocrlf = "input";
      init.defaultBranch = "main";
    };
  };
}
