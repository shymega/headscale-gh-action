{ pkgs, self }:
let
  inherit (pkgs) buildNpmPackage;
in
with pkgs;
buildNpmPackage {
  name = "headscale-gh-action";
  version = "0.1.0";

  src = lib.cleanSource self;

  NODE_OPTIONS = "--openssl-legacy-provider";

  npmDepsHash = "sha256-5tUgcmwb8lx9dVhsg0DTrt2mIAxlkuKMc9+suPlVKjs=";

  buildInputs = [
    headscale
  ];

  buildPhase = ''
    npm run prepare
  '';

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  meta = with lib; {
    mainProgram = "headscale-gh-action";
    description = "A GitHub Action for headscale";
    license = with licenses; mit;
    platforms = with platforms; linux ++ darwin;
    maintainers = with maintainers; [ shymega ];
  };
}
