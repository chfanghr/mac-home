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
    yubikey-personalization
    pinentry_mac
    bazelisk
    tmate
    mdbook
    gitAndTools.git-ignore
    niv
    aria

    # c/c++
    clang
    clang-tools
    fmt

    # dhall
    dhall
    dhall-lsp-server
    dhall-nix
    dhall-json

    # Haskell
    cabal-install
    haskellPackages.cabal-fmt
    haskell.compiler.ghc924
    haskellPackages.haskell-language-server
    haskellPackages.fourmolu
    haskellPackages.hopenpgp-tools
    haskellPackages.QuickCheck
    haskellPackages.tasty-hunit
    haskellPackages.tasty

    # OCaml
    opam

    # Nix
    nix-du
    nix-tree
    nix-prefetch-git
    niv
    cachix
  ];

  programs = {
    home-manager.enable = true;

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
  };
}
