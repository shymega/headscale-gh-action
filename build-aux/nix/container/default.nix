{
  pkgs,
  action,
}:
let
  inherit (pkgs.dockerTools) buildLayeredImage;
in
with pkgs;
buildLayeredImage {
  name = "headscale-gh-action-container";

  config.Cmd = [ "${lib.getExe action}" ];
  contents = [ action ];
}
