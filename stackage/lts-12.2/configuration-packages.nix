# Generated by stackage2nix 0.7.1 from "/nix/store/vi3b29i095jbnj2lmc2889zmdpxgxlik-stackage-lts/lts-12.2.yaml"
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
  # break cycle: HUnit call-stack nanospec hspec hspec-core clock tasty async hashable test-framework-hunit wcwidth attoparsec scientific tasty-ant-xml generic-deriving hspec-discover hspec-meta hspec-expectations quickcheck-io tasty-hunit tasty-quickcheck tasty-smallcheck silently temporary exceptions stringbuilder
  "stringbuilder" = dontCheck super.stringbuilder;
  "exceptions" = dontCheck super.exceptions;
  "temporary" = dontCheck super.temporary;
  "silently" = dontCheck super.silently;
  "hspec-discover" = dontCheck super.hspec-discover;
  "generic-deriving" = dontCheck super.generic-deriving;
  "hashable" = dontCheck super.hashable;
  "scientific" = dontCheck super.scientific;
  "async" = dontCheck super.async;
  "clock" = dontCheck super.clock;
  "nanospec" = dontCheck super.nanospec;
  # break cycle: scalendar SCalendar
  "SCalendar" = dontCheck super.SCalendar;
  # break cycle: statistics monad-par mwc-random vector-algorithms
  "mwc-random" = dontCheck super.mwc-random;

}
