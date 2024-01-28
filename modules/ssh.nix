{
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    controlPath = "~/.ssh/master-%r@%h:%p";
    includes = [
      "~/.orbstack/ssh/config"
    ];
    matchBlocks = {
      "demeter.vscode" = {
        hostname = "demeter";
        user = "fanghr";
      };
    };
  };
}
