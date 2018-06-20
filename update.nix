{ nixpkgs ? import ./nixpkgs.nix {}
, cacheVersion ? "0" }:

with nixpkgs; let
  lib = callPackage ./stackage2nix/lib.nix { inherit cacheVersion; };
in stdenv.mkDerivation rec {
  name = "nixpkgs-typeable-update-script";

  buildCommand = ''
    echo "Update failed"
    exit 1
  '';

  # generate missing stackage/lts-xx packages
  updateLtsSh = ''
    pushd stackage
    # iterate through stackage-lts configs
    for conf in $(find ${lib.stackage-lts} -type f -name '*.yaml' | sort --version-sort); do
      resolver=$(basename --suffix='.yaml' $conf)
      if [ ! -d $resolver ]; then
        mkdir $resolver
        pushd $resolver
        # generate stackage release
        (set -x; time ${stackage2nixWrapper}/bin/stackage2nix --resolver $resolver)
        # update supported releases
        popd
        echo $resolver >> ../supported-stackage-releases.txt
      fi
    done
    popd # stackage

    sort --version-sort -o supported-stackage-releases.txt supported-stackage-releases.txt
  '';

  # update stackage/default.nix
  updateStackageSh = ''
    pushd stackage
    echo '{ callPackage }:' > default.nix
    echo '{' >> default.nix
    for dir in $(find . -mindepth 1 -type d | sort --version-sort); do
      resolver=$(basename $dir)
      echo "  ''${resolver//.} = callPackage $dir {};" >> default.nix
    done
    echo '}' >> default.nix
    popd
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
