{
  description = "home-manager conf fanghr@bruh";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    nixpkgs.url = "github:NixOS/nixpkgs";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, pre-commit-hooks, nixpkgs, home-manager, ... }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
        };
      };
      username = "fanghr";
    in
    {
      checks.${system} = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true;
          };
        };
      };

      devShells.${system}.deafult = pkgs.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        packages = with pkgs; [ nixpkgs-fmt treefmt ];
      };

      homeConfigurations = {
        ${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix
            ./modules/nvim.nix
          ];
        };
      };

      ${username} = self.homeConfigurations.${username}.activationPackage;
      packages.${system}.default = self.${username};
    };
}
