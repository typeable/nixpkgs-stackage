# Generated by stackage2nix 0.7.1 from "/nix/store/vi3b29i095jbnj2lmc2889zmdpxgxlik-stackage-lts/lts-11.16.yaml"
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
  # break cycle: test-framework-quickcheck2 test-framework ansi-terminal colour ansi-wl-pprint
  "colour" = dontCheck super.colour;
  # break cycle: HUnit call-stack nanospec hspec hspec-core hspec-expectations hspec-meta async test-framework-hunit quickcheck-io silently temporary base-compat tasty clock tasty-quickcheck tasty-hunit hspec-discover stringbuilder
  "stringbuilder" = dontCheck super.stringbuilder;
  "hspec-discover" = dontCheck super.hspec-discover;
  "clock" = dontCheck super.clock;
  "base-compat" = dontCheck super.base-compat;
  "temporary" = dontCheck super.temporary;
  "silently" = dontCheck super.silently;
  "async" = dontCheck super.async;
  "nanospec" = dontCheck super.nanospec;
  # break cycle: scalendar SCalendar
  "SCalendar" = dontCheck super.SCalendar;
  # break cycle: http-streams snap-server
  "snap-server" = dontCheck super.snap-server;
  # break cycle: statistics monad-par mwc-random vector-algorithms
  "mwc-random" = dontCheck super.mwc-random;

}
