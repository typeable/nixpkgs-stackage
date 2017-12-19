# Nixpkgs overlay which aggregates overlays for tools and products

{ nixpkgs ? import <nixpkgs> {}}:

with nixpkgs.lib;
let haskellOverlay = import ./haskell-overlay.nix;
in fix (extends haskellOverlay (_: nixpkgs))
