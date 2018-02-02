# Generated by stackage2nix 0.6.0 from "/nix/store/hjyi9jjczpnkmjskxpdrx1bcjrxzm15a-stackage-lts/lts-2.21.yaml"
{ pkgs, haskellLib }:

with haskellLib; self: super: {

  # core packages
  "Cabal" = null;
  "array" = null;
  "base" = null;
  "bin-package-db" = null;
  "binary" = null;
  "bytestring" = null;
  "containers" = null;
  "deepseq" = null;
  "directory" = null;
  "filepath" = null;
  "ghc-prim" = null;
  "haskeline" = null;
  "haskell2010" = null;
  "haskell98" = null;
  "hoopl" = null;
  "hpc" = null;
  "integer-gmp" = null;
  "old-locale" = null;
  "old-time" = null;
  "pretty" = null;
  "process" = null;
  "rts" = null;
  "template-haskell" = null;
  "terminfo" = null;
  "time" = null;
  "transformers" = null;
  "unix" = null;
  "xhtml" = null;
  # break cycle: text QuickCheck test-framework xml quickcheck-unicode test-framework-hunit test-framework-quickcheck2
  "QuickCheck" = dontCheck super.QuickCheck;
  "text" = dontCheck super.text;
  # break cycle: silently nanospec hspec hspec-core hspec-expectations markdown-unlit stringbuilder hspec-meta hspec-discover
  "hspec-discover" = dontCheck super.hspec-discover;
  "stringbuilder" = dontCheck super.stringbuilder;
  "nanospec" = dontCheck super.nanospec;
  "markdown-unlit" = dontCheck super.markdown-unlit;
  "hspec-expectations" = dontCheck super.hspec-expectations;
  # break cycle: statistics monad-par mwc-random vector-algorithms
  "mwc-random" = dontCheck super.mwc-random;

}
