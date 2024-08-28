{ pkgs ? import <nixpkgs> {}
, action
}:
pkgs.dockerTools.buildImage {
name = "headscale-gh-action-container";
config = {
  Cmd = "${action}/bin/headscale-gh-action";
};
}
