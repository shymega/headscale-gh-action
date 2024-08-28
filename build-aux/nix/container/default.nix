{
  pkgs ? import <nixpkgs> { },
  action,
}:
let
  inherit (pkgs.dockerTools) buildImage;
  inherit (pkgs) buildEnv;
in
buildImage {
  name = "headscale-gh-action-container";

  config =
    let
      inherit (pkgs.lib) getExe;
      cmdLine = "${getExe pkgs.nodejs} ${action}/dist/index.js";
    in
    {
      Cmd = "${cmdLine}";
    };

  copyToRoot = buildEnv {
    name = "headscale-gh-action";
    paths = [
      (buildEnv {
        name = "headscale-gh-action";
        paths = [ pkgs.nodejs ];
      })
    ];
  };
}
