# Stackage packages accept `overrides` like Nixpkgs `haskellPackages`

let
  _pkgs = import <nixpkgs> {};
  _stackageOverlay = _pkgs.fetchFromGitHub (_pkgs.lib.importJSON ./nixpkgs-stackage.json);
  nixpkgs = import <nixpkgs> {
    overlays = [ (import _stackageOverlay) ];
  };
  inherit (nixpkgs) pkgs lib haskell;

  stackage2nixSrc = pkgs.fetchFromGitHub (lib.importJSON ./stackage2nix.json);

  stackagePackages = haskell.packages.stackage.lib.callStackage2nix "stackage2nix" stackage2nixSrc { inherit nixpkgs; };
  stackage = stackagePackages.override {
    overrides = self: super: {
      stackage2nix = haskell.lib.disableSharedExecutables super.stackage2nix;
    };
  };
in
  stackage
