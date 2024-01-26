{
  config,
  pkgs,
  ...
}: let
  ghcVersion = "96";

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
    ];

  haskellEnv =
    pkgs.haskell.packages."ghc${ghcVersion}".ghcWithHoogle
    haskellPkgs;
in {
  home.packages = [
    haskellEnv
  ];
}
