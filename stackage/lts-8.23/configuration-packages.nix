# Generated by stackage2nix 0.6.1 from "/nix/store/jwic59nw202khsy06b5hy9irq3zipzb8-stackage-lts/lts-8.23.yaml"
{ pkgs, haskellLib }:

with haskellLib; self: super: {

  # core packages
  "array" = null;
  "base" = null;
  "binary" = null;
  "bytestring" = null;
  "containers" = null;
  "deepseq" = null;
  "directory" = null;
  "filepath" = null;
  "ghc-boot" = null;
  "ghc-boot-th" = null;
  "ghc-prim" = null;
  "ghci" = null;
  "hoopl" = null;
  "hpc" = null;
  "integer-gmp" = null;
  "pretty" = null;
  "process" = null;
  "rts" = null;
  "template-haskell" = null;
  "time" = null;
  "transformers" = null;
  "unix" = null;
  # break cycle: HUnit call-stack nanospec hspec QuickCheck test-framework xml text quickcheck-unicode test-framework-hunit test-framework-quickcheck2 hspec-core async hspec-expectations hspec-meta quickcheck-io silently temporary base-compat exceptions tasty clock tasty-quickcheck tasty-hunit optparse-applicative regex-tdfa parsec hspec-discover stringbuilder
  "stringbuilder" = dontCheck super.stringbuilder;
  "hspec-discover" = dontCheck super.hspec-discover;
  "optparse-applicative" = dontCheck super.optparse-applicative;
  "clock" = dontCheck super.clock;
  "exceptions" = dontCheck super.exceptions;
  "base-compat" = dontCheck super.base-compat;
  "temporary" = dontCheck super.temporary;
  "silently" = dontCheck super.silently;
  "async" = dontCheck super.async;
  "text" = dontCheck super.text;
  "nanospec" = dontCheck super.nanospec;
  # break cycle: http-streams snap-server
  "snap-server" = dontCheck super.snap-server;
  # break cycle: statistics monad-par mwc-random vector-algorithms
  "mwc-random" = dontCheck super.mwc-random;

}
