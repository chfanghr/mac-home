{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = true;

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
      {
        name = "wakatime-zsh-plugin";
        src = pkgs.zsh-wakatime;
        file = "wakatime.plugin.zsh";
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
      "flush_routes" = "sudo route -n flush";
    };
    initExtraFirst = ''
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

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
      # export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      # gpgconf --launch gpg-agent

      function repl() {
        source="$(nix flake prefetch --json "$1" | ${pkgs.jq}/bin/jq -r .storePath)"
        TEMP="$(mktemp --suffix=.nix)"
        echo "let self = builtins.getFlake \"$source\"; in self // self.legacyPackages.\''${builtins.currentSystem} or { } // self.packages.\''${builtins.currentSystem} or { }" > "$TEMP"
        nix repl "$TEMP"
        rm "$TEMP"
      }

      function ss() { nix shell "self#$1" }
      function es() { nix edit "self#$1" }
      function bs() { nix build "self#$1" }
      function is() { nix search "self#$1" }
      function rs() { repl self }

      # source "$HOME/.cargo/env"

      function hs-shell-with(){
       nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $* ])"
      }

      ${pkgs.pueue}/bin/pueued -d >/dev/null 2>&1 || true

      if [ -e $HOME/.cargo/env ]; then source $HOME/.cargo/env; fi
    '';
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
  };
}
