inputs: final: prev:

let
  x86_64Pkgs = import inputs.nixpkgs {
    system = "x86_64-darwin";
  };
in
{
  zsh-you-should-use = inputs.zsh-you-should-use;
  zsh-wakatime = inputs.wakatime-zsh-plugin;
  rosetta = {
    purescript = x86_64Pkgs.purescript;
    purescript-language-server = x86_64Pkgs.nodePackages.purescript-language-server;
    spago = x86_64Pkgs.spago;
  };
}
