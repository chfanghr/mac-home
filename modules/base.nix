{
  config,
  pkgs,
  ...
}: {
  home = {
    username = "fanghr";
    homeDirectory = "/Users/fanghr";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
