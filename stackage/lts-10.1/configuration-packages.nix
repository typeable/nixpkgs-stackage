# Generated by stackage2nix 0.6.0 from "/nix/store/7qx86j1c631k9189wq1b8na3psv9g51w-stackage-lts/lts-10.1.yaml"
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
  "terminfo" = null;
  "time" = null;
  "transformers" = null;
  "unix" = null;
  # break cycle: HUnit call-stack nanospec hspec hspec-core ansi-terminal colour test-framework ansi-wl-pprint xml text test-framework-hunit test-framework-quickcheck2 async hspec-expectations hspec-meta quickcheck-io silently temporary base-compat exceptions tasty clock tasty-quickcheck tasty-hunit optparse-applicative regex-tdfa parsec hspec-discover stringbuilder
  "stringbuilder" = dontCheck super.stringbuilder;
  "hspec-discover" = dontCheck super.hspec-discover;
  "clock" = dontCheck super.clock;
  "exceptions" = dontCheck super.exceptions;
  "base-compat" = dontCheck super.base-compat;
  "temporary" = dontCheck super.temporary;
  "silently" = dontCheck super.silently;
  "async" = dontCheck super.async;
  "text" = dontCheck super.text;
  "colour" = dontCheck super.colour;
  "nanospec" = dontCheck super.nanospec;
  # break cycle: scalendar SCalendar
  "SCalendar" = dontCheck super.SCalendar;
  # break cycle: http-streams snap-server
  "snap-server" = dontCheck super.snap-server;
  # break cycle: statistics monad-par mwc-random vector-algorithms
  "mwc-random" = dontCheck super.mwc-random;

}
