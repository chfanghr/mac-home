{
  programs.ssh = {
    enable = true;
    controlMaster = "auto";
    includes = ["~/.orbstack/ssh/config"];
  };
}