{ mkDerivation, fetchgit, aeson, base, bytestring, Cabal, cabal2nix
, containers, deepseq, distribution-nixpkgs, exceptions, filepath
, gitlib, gitlib-libgit2, hopenssl, hspec, inflections
, language-nix, lens, network-uri, optparse-applicative, pretty
, QuickCheck, shakespeare, stackage-curator, stdenv, text
, unordered-containers, yaml
}:
mkDerivation {
  pname = "stackage2nix";
  version = "0.5.0";
  src = fetchgit {
   url = "https://github.com/typeable/stackage2nix.git";
   rev = "7bd086b41252e293af1b3d8a15e6b53bc63230bf";
   sha256 = "06hyma8cxncv2l6icdaf2dwh2mxjbgds6l2z2x8kp25gq2qlqx1r";
  };
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base bytestring Cabal cabal2nix containers deepseq
    distribution-nixpkgs exceptions filepath gitlib gitlib-libgit2
    hopenssl inflections language-nix lens network-uri
    optparse-applicative pretty QuickCheck stackage-curator text
    unordered-containers yaml
  ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [
    base bytestring Cabal hspec pretty shakespeare text yaml
  ];
  homepage = "https://github.com/typeable/stackage2nix#readme";
  description = "Convert Stack files into Nix build instructions";
  license = stdenv.lib.licenses.bsd3;
}
