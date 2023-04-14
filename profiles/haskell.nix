{
  config,
  pkgs,
  ...
}: let
  ghcVersion = "94";

  dontCheck = pkgs.haskell.lib.dontCheck;

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
