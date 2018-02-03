# Nixpkgs with Stackage overlay pinned to `nixpkgs.json` revision

{ pkgsPath ? null
, overlays ? []
, system ? null }:

let
  _pkgs = import <nixpkgs> {};
  _pkgsPath = if pkgsPath != null
    then pkgsPath
    else _pkgs.fetchFromGitHub (_pkgs.lib.importJSON ./nixpkgs.json);
in
  import _pkgsPath ({
    overlays = [ (import ./default.nix) ] ++ overlays;
  } // (if system != null then { inherit system; } else {}))
