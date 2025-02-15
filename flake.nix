{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs =
    { self, ... }@inputs:
    let
      genPkgs =
        system:
        import inputs.nixpkgs {
          inherit system;
        };
      forEachSystem =
        let
          systems = [
            "x86_64-linux"
            "aarch64-linux"
            "x86_64-darwin"
            "aarch64-darwin"
          ];
          inherit (inputs.nixpkgs.lib) genAttrs;
        in
        genAttrs systems;
    in
    {
      packages = forEachSystem (
        system:
        let
          pkgs = genPkgs system;
        in
        {
          default = self.packages.${system}.action;
          action = import ./build-aux/nix { inherit pkgs self; };
          container = import ./build-aux/nix/container {
            inherit pkgs;
            action = self.packages.${system}.action;
          };
        }
      );

      devShells.default = forEachSystem (
        system:
        let
          pkgs = genPkgs system;
        in
        pkgs.mkShell {
          name = "headscale-gh-action-devshell";
          buildInputs = [ self.packages.${system}.action ];
        }
      );
    };
}
