{ nixpkgs ? import <nixpkgs> {} }:

let
  pkgs = import ./default.nix { inherit nixpkgs; };
  lib = pkgs.callPackage ./stackage2nix/lib.nix {};
  # updateScript = pkgs.callPackage ./update-stackage/update.nix { inherit (lib) stackage-lts; };
in pkgs.stdenv.mkDerivation rec {
  name = "nixpkgs-typeable-update-script";

  buildCommand = ''
    echo "Update failed"
    exit 1
  '';

  updateLtsSh = ''
    pushd stackage
    # iterate through stackage-lts configs
    for conf in ${lib.stackage-lts}/*.yaml; do
      resolver=$(basename --suffix='.yaml' $conf)
      if [ ! -d $resolver ]; then
        mkdir $resolver
        pushd $resolver
        (set -x; time ${pkgs.stackage2nix}/bin/stackage2nix --resolver $resolver)
        popd
      fi
    done
    popd # stackage
  '';

  updateStackageSh = ''
    pushd stackage
    echo '{ callPackage }:' > default.nix
    echo '{' >> default.nix
    for dir in $(find . -mindepth 1 -type d | sort); do
      resolver=$(basename $dir)
      echo "  ''${resolver//.} = callPackage $dir {};" >> default.nix
    done
    echo '}' >> default.nix
    popd # stackage
  '';

  shellHook = ''
    echo 'Start ${name}'
    echo 'Start update-lts-sh'
    ${updateLtsSh}
    echo 'Start update-stackage-sh'
    ${updateStackageSh}
    EXIT_CODE=$?
    if [ "$EXIT_CODE" != "0" ]; then
      echo 'ERROR: update-script'
      exit $EXIT_CODE
    fi
    echo 'OK: ${name}'
    exit 0
  '';
}
