{ pkgs, haskellLib }:

with haskellLib; self: super: {
  cabal2nix = dontCheck super.cabal2nix;
  hlibgit2 = disableHardening super.hlibgit2 [ "format" ];
}
