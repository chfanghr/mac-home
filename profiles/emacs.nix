{ config, pkgs, libs, inputs, system, ... }:

{
  programs.emacs = {
    enable = true;

    extraPackages = epkgs: with epkgs; [
      melancholy-theme
    ];

    extraConfig = ''
      (require 'package)

      ;; optional. makes unpure packages archives unavailable
      (setq package-archives nil)

      (setq package-enable-at-startup nil)
      (package-initialize)
    '';
  };
}
