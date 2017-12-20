{ pkgs, haskellLib }:

with haskellLib;
self: super: {

  warp = addBuildDepend super.warp pkgs.curl;

}
