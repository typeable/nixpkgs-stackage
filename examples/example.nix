# Produces Stackage packages set with `stackage2nix` package
# from `${stackage2nixSrc}/stack.yaml`
#
# nix-build ./example.nix -A stackage2nix

let
  nixpkgs = import <nixpkgs> {
    overlays = [ (import ../default.nix) ];
  };
  inherit (nixpkgs) pkgs lib;

  stackage2nixSrc = pkgs.fetchFromGitHub (lib.importJSON ./stackage2nix.json);

  stackage = nixpkgs.haskell.packages.stackage.lib.callStackage2nix "stackage2nix" stackage2nixSrc {
    inherit nixpkgs;
  };
in
  stackage
