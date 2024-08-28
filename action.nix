{ pkgs }:
let
  lib = pkgs.lib;
  buildNpmPackage = pkgs.buildNpmPackage;
in
buildNpmPackage {
  name = "headscale-gh-action";
  version = "0.1.0";

  src = lib.cleanSource ./.;

  buildPhase = ''
    npm run all
  '';

  npmDepsHash = "sha256-I31UCV5IQ1SZluIoQkblUxNcepFrwn+/uaGYely88a0=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  # Add metadata.
}
