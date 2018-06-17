{ nixpkgs ? import <nixpkgs> {}
, stackage-nightly ? null
, stackage-lts
, all-cabal-hashes
, hackage-db
}:

let
  inherit (nixpkgs) pkgs stdenv makeWrapper runCommand;

  stackagePackages = import ./stackage-packages.nix { inherit nixpkgs; };
  stackage2nix = pkgs.haskell.lib.disableSharedExecutables stackagePackages.stackage2nix;

  stackageAll = runCommand "stackage-all" { }
  ''
    mkdir $out
    for file in ${stackage-lts}/*.yaml
    do
      ln -s $file $out
    done
  '' + stdenv.lib.optionalString (stackage-nightly != null) ''
    for file in ${stackage-nightly}/*.yaml
    do
      ln -s $file $out
    done
  '';
in pkgs.stdenv.mkDerivation rec {
  name = "stackage2nix-${version}";
  version = stackage2nix.version;
  phases = [ "installPhase" "fixupPhase" ];
  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${stackage2nix}/bin/stackage2nix $out/bin/stackage2nix \
      --add-flags "--all-cabal-hashes ${all-cabal-hashes}" \
      --add-flags "--lts-haskell ${stackageAll}" \
      --add-flags "--hackage-db ${hackage-db}" \
      --prefix PATH ":" "${pkgs.nix}/bin" \
      --prefix PATH ":" "${pkgs.nix-prefetch-scripts}/bin"
  '';
}
