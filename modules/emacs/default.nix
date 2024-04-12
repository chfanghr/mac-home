{pkgs, ...}: {
  # programs.emacs = {
  #   enable = true;
  # };
  # programs.doom-emacs = {
  # enable = true;
  #  doomPrivateDir = ./doom.d;
  # };

  # home.file.".emacs.d" = {
  #   source = pkgs.fetchFromGitHub {
  #     owner = "syl20bnr";
  #     repo = "spacemacs";
  #     rev = "4489c337f22835674542df0642ed9533882bd1e3";
  #     sha256 = "sha256-HdQY8x+mgyWuSkHp9lERGHQyK0ZQp4jdKcfqzXcJry4=";
  #     fetchSubmodules = true;
  #   };

  #   recursive = true;
  # };

  # home.file.".spacemacs".source = ./spacemacs.el;
}
