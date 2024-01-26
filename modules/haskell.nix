{
  config,
  pkgs,
  ...
}: let
  haskellPkgs = hpkgs:
    with hpkgs; [
      mtl
      transformers
      containers
      optics
      fourmolu
      QuickCheck
      tasty-hunit
      tasty
    ];

  haskellEnv =
    pkgs.haskellPackages.ghcWithHoogle
    haskellPkgs;
in {
  home.packages = [
    haskellEnv
    pkgs.haskell-language-server
    pkgs.cabal-install
  ];
}
