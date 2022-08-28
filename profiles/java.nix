{ config, pkgs, ... }:

{
  programs.java = {
    enable = true;
    package = pkgs.graalvm17-ce;
  };
}
