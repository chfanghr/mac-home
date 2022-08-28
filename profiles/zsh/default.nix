{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    enableSyntaxHighlighting = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "dirhistory"
        "git"
        "sudo"
      ];
    };

    dotDir = ".config/zsh";

    history = rec {
      size = 1000000;
      save = size;
      path = "$HOME/.local/share/zsh/history";
    };

    plugins = [
      {
        name = "you-should-use";
        src = pkgs.zsh-you-should-use;
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    shellAliases = {
      "b" = "nix build";
      "p" = "nix-shell --run zsh -p";
      "s" = "nix shell";
      "e" = "$EDITOR";
      "d" = "nix develop";
      "r" = "nix run";
      "f" = "nix search";
      "fs" = "nix search self";
    };
    initExtraFirst = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    initExtra = ''
      if [[ -r "$HOME/.iterm2_shell_integration.zsh" ]]; then
        source "$HOME/.iterm2_shell_integration.zsh"
      fi

      export GPG_TTY="$(tty)"
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      gpgconf --launch gpg-agent
    '';
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
  };
}
