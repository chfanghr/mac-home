{
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
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
