{ supportedSystems ? [ "x86_64-linux" "i686-linux" ]
, supportedReleases ? null
, inHydra ? true
, pkgs ? import <nixpkgs> {}
}:

let
  inherit (pkgs) lib;

  release = import (pkgs.path + "/pkgs/top-level/release-lib.nix") {
    inherit supportedSystems;
    nixpkgsArgs = { overlays = [ (import ./default.nix) ]; };
  };

  # supportedStackageReleases :: [StackageVersion]
  supportedStackageReleases =
    if supportedReleases == null
    then
      lib.unique
        (map (builtins.replaceStrings ["."] [""])
          (builtins.filter (x: x != "")
            (lib.splitString "\n"
              (builtins.readFile ./supported-stackage-releases.txt))))
    else
      supportedReleases;

  # hasSupportedSystem :: System -> Derivation -> Bool
  hasSupportedSystem = system: pkg:
    # Test `isAttrs pkg` to ensure that pkg is a derivation
    lib.isAttrs pkg && lib.elem system pkg.meta.platforms;

  # genJobSetFiltered :: System -> StackageVersion -> AttrSet
  genJobSetFiltered = system: stackage:
    lib.filterAttrs
      (_: pkg: hasSupportedSystem system pkg)
      (release.pkgsFor system).haskell.packages.stackage."${stackage}";

  # genJobSetFull :: System -> StackageVersion -> AttrSet
  genJobSetFull = system: stackage:
    (release.pkgsFor system).haskell.packages.stackage."${stackage}";

  # genJobSet :: StackageRelease -> System -> AttrSet
  genJobSet = if inHydra then genJobSetFull else genJobSetFiltered;

in
  lib.genAttrs supportedSystems (system:
    lib.genAttrs supportedStackageReleases (stackage:
      genJobSet system stackage
  ))
