# Nixpkgs with overlay

{ nixpkgs ? import <nixpkgs> }:

nixpkgs { overlays = [ (import ./default.nix) ]; }
