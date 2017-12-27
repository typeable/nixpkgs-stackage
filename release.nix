{ supportedSystems ? [ "x86_64-linux" "i686-linux" ]
, supportedStackageReleases ? [ "lts-100" ] }:

let
  lib = (import <nixpkgs> {}).lib;
  release = import <nixpkgs/pkgs/top-level/release-lib.nix> {
    inherit supportedSystems;
    nixpkgsArgs = { overlays = [ (import ./haskell-overlay.nix) ]; };
  };

  # hasSupportedSystem :: System -> Derivation -> Bool
  hasSupportedSystem = system: pkg:
    # Test `isAttrs pkg` to ensure that pkg is a derivation
    lib.isAttrs pkg && lib.elem system pkg.meta.platforms;

  # genJobSet :: StackageRelease -> System -> AttrSet
  genJobSet = lts: system:
    lib.filterAttrs
      (_: pkg: hasSupportedSystem system pkg)
      (release.pkgsFor system).haskell.packages.stackage."${lts}";

in
  lib.genAttrs supportedStackageReleases (stackage:
    lib.genAttrs supportedSystems (system:
      genJobSet stackage system
  ))
