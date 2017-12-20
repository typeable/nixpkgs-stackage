{ mkDerivation, fetchgit, aeson, base, bytestring, Cabal, cabal2nix
, containers, deepseq, distribution-nixpkgs, exceptions, filepath
, gitlib, gitlib-libgit2, hopenssl, hspec, inflections
, language-nix, lens, network-uri, optparse-applicative, pretty
, QuickCheck, shakespeare, stackage-curator, stdenv, text
, unordered-containers, yaml
}:
mkDerivation {
  pname = "stackage2nix";
  version = "0.4.0";
  src = fetchgit {
   url = "https://github.com/typeable/stackage2nix.git";
   rev = "34731adba9da7c2496a2bae3c427ef6eedf6940d";
   sha256 = "1wfs6cma50bvjx7ci6wdrq88br3019fz4myfsdxg04sngndqa61p";
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
  homepage = "https://github.com/4e6/stackage2nix#readme";
  description = "Convert Stack files into Nix build instructions";
  license = stdenv.lib.licenses.bsd3;
}
