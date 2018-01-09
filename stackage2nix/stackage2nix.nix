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
   rev = "884ca5b6be6880f6ee7453f7d8d4df3ca1060cb1";
   sha256 = "1gcln8gmhi2gar5zqngff5hkkmx7005qg2h2nk34457whd6kxdzg";
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
