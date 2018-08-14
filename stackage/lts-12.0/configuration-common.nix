{ pkgs, haskellLib }:

with haskellLib; self: super: {
  cabal2nix = dontCheck super.cabal2nix;
}
