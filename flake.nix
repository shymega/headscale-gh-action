{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, ...}@inputs: let
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs { inherit system; };
  in
  {
    packages.${system} = rec {
      default = action;
      action = import ./action.nix { inherit pkgs; };
      container = import ./container.nix { inherit pkgs action; };
    };
  };
}
