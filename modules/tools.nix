{
  config,
  pkgs,
  ...
}: let
  purescript_latest = pkgs.callPackage ../pkgs/purescript.nix {};
  tools = with pkgs; [
    # formatters/linters
    shfmt
    treefmt
    yamllint

    # misc
    neofetch
    cloc
    wakatime
    pwgen
    ripgrep
    wget
    pass
    openssl_3
    pinentry_mac
    bazelisk
    tmate
    mdbook
    aria
    htop
    jq
    bat
    z3
    tmux
    ffmpeg_5
    speedtest-cli
    yt-dlp
    gallery-dl
    rq
    mosh
    sops
    nushell
    mosh
    silicon
    cddl
    postgresql
    multimarkdown
    rsync
    mosh

    # git
    gitAndTools.git-ignore

    # c/c++
    clang_14
    clang-tools_14
    cmake
    fmt
    pkg-config

    # rust
    rustup

    # dhall
    dhall
    dhall-lsp-server
    dhall-nix
    dhall-json

    # ocaml
    # opam

    # nix
    nixpkgs-fmt
    alejandra

    # nix-du
    nix-tree
    nix-prefetch-git
    niv
    cachix
    nix-output-monitor
    nil

    # common lisp
    # lispPackages.quicklisp

    # purescript
    purescript_latest
    nodePackages.purescript-language-server
    # rosetta.purescript-language-server
    # spago
    # rosetta.spago

    # Mina
    nodejs-18_x
    # (pkgs.callPackage ./zk-cli.nix {})

    # Minecraft
    prismlauncher
  ];
in {
  home.packages = tools;
}
