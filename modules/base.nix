{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "fanghr";
    homeDirectory = "/Users/fanghr";
    stateVersion = "22.05";
  };
  programs.home-manager.enable = true;
}
