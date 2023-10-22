{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font Mono";
      package = pkgs.nerdfonts;
      size = 15;
    };
    settings = {
      macos_option_as_alt = true;
    };
  };
}
