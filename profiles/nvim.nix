{ config, pkgs, libs, inputs, system, ... }:

{
  programs.neovim = {
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
        suggest = {
          noselect = true;
          enablePreview = true;
          enablePreselect = false;
          disableKind = true;
          coc.preferences.formatOnSaveFiletypes = [ "nix" ];
        };
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
              "project.cabal"
              "*.cabal"
            ];
            filetypes = [ "hs" "lhs" "haskell" "lhaskell" ];
          };
        };
      };
    };

    plugins = with pkgs.vimPlugins; [
      {
        plugin = rainbow;
        config = ''
          let g:rainbow_active = 1
        '';
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
      {
        plugin = vim-airline;
        config = ''
          let g:airline#extensions#tabline#enabled = 1
        '';
      }
      {
        plugin = vim-airline-themes;
        config = ''
          let g:airline_theme = 'violet'
        '';
      }
      nerdtree
      vim-nix
      vim-commentary
      coc-nvim
      gitgutter
      fugitive
      undotree
      nvim-autopairs
    ];

    extraConfig = ''
      set number relativenumber

      set expandtab
      set mouse=a
      set clipboard^=unnamed,unnamedplus
      set tabstop=2
      set shiftwidth=2

      vmap <leader>ca <Plug>(coc-codeaction-selected)
      nmap <leader>ca <Plug>(coc-codeaction-cursor)
    '';

    viAlias = true;
    vimAlias = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
