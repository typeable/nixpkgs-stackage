{ nixpkgs ? import ../default.nix {}
, cacheVersion }:

with nixpkgs;
let
  lib = callPackage ./lib.nix { inherit cacheVersion; };
  haskellPackages = haskell.packages.stackage.lts-100;
  stackage2nix = haskell.lib.disableSharedExecutables
    (haskellPackages.callPackage ./stackage2nix.nix {});
in stdenv.mkDerivation rec {
  name = "stackage2nix-${version}";
  version = stackage2nix.version;
  phases = [ "installPhase" "fixupPhase" ];
  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${stackage2nix}/bin/stackage2nix $out/bin/stackage2nix \
      --add-flags "--all-cabal-hashes ${lib.all-cabal-hashes}" \
      --add-flags "--lts-haskell ${lib.stackage-lts}" \
      --add-flags "--hackage-db ${lib.hackage-db}/01-index.tar" \
      --prefix PATH ":" "${nix}/bin" \
      --prefix PATH ":" "${nix-prefetch-scripts}/bin"
  '';
}
