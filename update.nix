{ nixpkgs ? import <nixpkgs> {} }:

let
  # TODO define pkgsTypeable
  pkgs = import ./default.nix { inherit nixpkgs; };
  lib = pkgs.callPackage ./stackage2nix/lib.nix {};
  # updateScript = pkgs.callPackage ./update-stackage/update.nix { inherit (lib) stackage-lts; };
in pkgs.stdenv.mkDerivation rec {
  name = "nixpkgs-typeable-update-script";

  buildCommand = ''
    echo "Update failed"
    exit 1
  '';

  updateScriptSh = ''
    pushd stackage
    # iterate throuch stackage-lts configs
    for conf in ${lib.stackage-lts}/*.yaml; do
      resolver=$(basename --suffix='.yaml' $conf)
      if [ $resolver = 'lts-9.1' ] && [ ! -d $resolver ]; then
        mkdir $resolver
        pushd $resolver
        (set -x; ${pkgs.stackage2nix}/bin/stackage2nix --resolver $resolver)
        popd
      fi
    done
    popd # stackage
  '';

  shellHook = ''
    echo "Running ${name}"
    ${updateScriptSh}
    EXIT_CODE=$?
    if [ "$EXIT_CODE" != "0" ]; then
      echo 'ERROR: update-script'
      exit $EXIT_CODE
    fi
    echo 'OK: update-script'
    exit 0
  '';
}
