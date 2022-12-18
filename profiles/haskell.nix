{
  config,
  pkgs,
  ...
}: let
  ghcVersion = "924";

  haskellPkgs = pkgs:
    with pkgs; [
      haskell-language-server
      cabal-install
      mtl
      fourmolu
      QuickCheck
      tasty-hunit
      tasty
      gotta-go-fast
    ];

  haskellEnv =
    pkgs.haskell.packages."ghc${ghcVersion}".ghcWithHoogle
    haskellPkgs;
in {
  home.packages = [
    haskellEnv
  ];
}
