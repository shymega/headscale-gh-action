{ pkgs }:
let
  inherit (pkgs) lib buildNpmPackage;
in
buildNpmPackage {
  name = "headscale-gh-action";
  version = "0.1.0";

  src = lib.cleanSource ../../.;

  NODE_OPTIONS = "--openssl-legacy-provider";

  npmDepsHash = "sha256-I31UCV5IQ1SZluIoQkblUxNcepFrwn+/uaGYely88a0=";

  buildPhase = ''
    npm run prepare
  '';

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  meta = with pkgs.lib; {
    mainProgram = "headscale-gh-action";
    description = "A GitHub Action for headscale";
    license = licenses.mit;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = with maintainers; [ shymega ];
  };
}
