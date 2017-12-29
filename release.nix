{ supportedSystems ? [ "x86_64-linux" "i686-linux" ]
, supportedStackageReleases ? [ "lts-100" ] }:

let
  lib = (import <nixpkgs> {}).lib;
  release = import <nixpkgs/pkgs/top-level/release-lib.nix> {
    inherit supportedSystems;
    nixpkgsArgs = { overlays = [ (import ./haskell-overlay.nix) ]; };
  };

  # genJobSet :: StackageRelease -> System -> AttrSet
  genJobSet = lts: system:
    (release.pkgsFor system).haskell.packages.stackage."${lts}";

in
  lib.genAttrs supportedStackageReleases (stackage:
    lib.genAttrs supportedSystems (system:
      genJobSet stackage system
  ))
