{
  description = "home-manager conf fanghr@bruh";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zsh-you-should-use = {
      url = "github:MichaelAquilina/zsh-you-should-use";
      flake = false;
    };

    wakatime-zsh-plugin = {
      url = "github:sobolevn/wakatime-zsh-plugin";
      flake = false;
    };

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    nixvim.url = "github:nix-community/nixvim";

    nvim.url = "git+ssh://git@github.com/chfanghr/nvim.git";
  };

  outputs = {
    self,
    pre-commit-hooks,
    nixpkgs,
    home-manager,
    nix-doom-emacs,
    nixvim,
    nvim,
    ...
  } @ inputs: let
    system = "aarch64-darwin";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowBroken = true;
      };
      overlays = [(import ./overlay.nix inputs)];
    };
    username = "fanghr";
    findModules = dir:
      builtins.concatLists (builtins.attrValues (builtins.mapAttrs
        (name: type:
          if type == "regular"
          then [
            {
              name = builtins.elemAt (builtins.match "(.*)\\.nix" name) 0;
              value = dir + "/${name}";
            }
          ]
          else if
            (builtins.readDir (dir + "/${name}"))
            ? "default.nix"
          then [
            {
              inherit name;
              value = dir + "/${name}";
            }
          ]
          else findModules (dir + "/${name}"))
        (builtins.readDir dir)));
    modules = builtins.listToAttrs (findModules ./modules);
  in rec {
    checks.${system} = {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
        };
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      inherit (self.checks.${system}.pre-commit-check) shellHook;
      packages = with pkgs; [alejandra treefmt nil];
    };

    overlays.default = import ./overlay.nix inputs;

    homeModules = {
      ${username} = {
        imports = with modules; [
          base
          # nvim
          tools
          haskell
          java
          direnv
          zsh
          man
          git
          helix
          emacs
          kitty
          zellij
          alacritty
          ssh
          # nix-doom-emacs.hmModule
          autossh
          nixvim.homeManagerModules.nixvim
          {programs.nixvim = {enable = true;} // nvim.nvimModules.default;}
        ];
      };
    };

    homeConfigurations = {
      ${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [homeModules.${username}];
      };
    };
  };
}
