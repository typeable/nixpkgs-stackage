# Generated by stackage2nix 0.6.1 from "/nix/store/jwic59nw202khsy06b5hy9irq3zipzb8-stackage-lts/lts-6.32.yaml"
{ pkgs, haskellLib }:

with haskellLib; self: super: {

  # core packages
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
  "hoopl" = null;
  "hpc" = null;
  "integer-gmp" = null;
  "pretty" = null;
  "process" = null;
  "template-haskell" = null;
  "time" = null;
  "transformers" = null;
  "unix" = null;
  # break cycle: text QuickCheck test-framework xml quickcheck-unicode test-framework-hunit test-framework-quickcheck2
  "QuickCheck" = dontCheck super.QuickCheck;
  "text" = dontCheck super.text;
  # break cycle: chell-quickcheck chell options
  "options" = dontCheck super.options;
  # break cycle: tasty clock tasty-quickcheck tasty-hunit
  "clock" = dontCheck super.clock;
  # break cycle: silently nanospec hspec hspec-core stringbuilder
  "stringbuilder" = dontCheck super.stringbuilder;
  "nanospec" = dontCheck super.nanospec;
  # break cycle: warp HTTP
  "HTTP" = dontCheck super.HTTP;
  # break cycle: statistics monad-par mwc-random vector-algorithms
  "mwc-random" = dontCheck super.mwc-random;

}
