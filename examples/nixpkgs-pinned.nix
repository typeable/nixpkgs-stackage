# Nixpkgs with Stackage overlay pinned to specific version set in `nixpkgs.json`

{ overlays ? []
, system ? null
, config ? { } }:

let
  _pkgs = import <nixpkgs> {};
  _pkgsPath = _pkgs.fetchFromGitHub (_pkgs.lib.importJSON ../nixpkgs.json);
  _stackageOverlayLocal = ../.;
in
  import _pkgsPath ({
    overlays = [ (import _stackageOverlayLocal) ] ++ overlays;
    config = config // { allowUnfree = true; };
  } // (if system != null then { inherit system; } else { }))
