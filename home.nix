{ config, pkgs, ... }:

{
  home.username = "fanghr";
  home.homeDirectory = "/Users/fanghr";

  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    # Formatters/Linters
    nixpkgs-fmt
    shfmt
    treefmt
    yamllint

    # Misc Tools
    neofetch
    cloc
    wakatime
    pwgen
    ripgrep
    wget
    pass
    openssl_3
    yubikey-manager
    yubikey-personalization
    haskellPackages.hopenpgp-tools
    pinentry_mac

    # Nix
    nix-du
    nix-tree
    nix-prefetch-git
    niv
    cachix
  ];

  programs = {
    home-manager.enable = true;

    neovim = {
      enable = true;

      withPython3 = true;
      withRuby = true;
      withNodeJs = true;

      extraPackages = with pkgs; [
        rnix-lsp
      ];

      coc = {
        enable = true;
        settings = {
          languageserver = {
            nix = {
              command = "rnix-lsp";
              filetypes = [ "nix" ];
            };
            haskell = {
              command = "haskell-language-server";
              args = [ "--lsp" ];
              rootPatterns = [
                ".stack.yaml"
                ".hie-bios"
                "BUILD.bazel"
                "cabal.config"
                "package.yaml"
              ];
              filetypes = [ "hs" "lhs" "haskell" ];
            };
          };
        };
      };

      plugins = with pkgs.vimPlugins; [
        {
          plugin = rainbow;
          config = "let g:rainbow_active = 1";
        }
        {
          plugin = haskell-vim;
          config = ''
            let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
            let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
            let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
            let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
            let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
            let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
            let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
          '';
        }
        vim-airline
        vim-airline-themes
        nerdtree
        vim-nix
        vim-commentary
        coc-nvim
      ];

      extraConfig = ''
        set number relativenumber

        set expandtab
        set shiftwidth=2
      '';

      viAlias = true;
      vimAlias = true;
    };

    java = {
      enable = true;
      package = pkgs.graalvm17-ce;
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };

    exa = {
      enable = true;
      enableAliases = true;
    };

    htop.enable = true;
    jq.enable = true;
    bat.enable = true;

    lsd = {
      enable = true;
      enableAliases = true;
    };

    gpg.enable = true;
  };
}
