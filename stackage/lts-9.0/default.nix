{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;
let
  inherit (stdenv.lib) extends;
  stackagePackages = self: import ./packages.nix { inherit pkgs stdenv; inherit (self) callPackage ; };
  stackageConfig = callPackage ./configuration-packages.nix {};
in callPackage (nixpkgs.path + /pkgs/development/haskell-modules) {
  ghc = pkgs.haskell.compiler.ghc802;
  compilerConfig = self: extends stackageConfig (stackagePackages self);
  haskellLib = callPackage (nixpkgs.path + /pkgs/development/haskell-modules/lib.nix) {};
  initialPackages = args: self: {};
  configurationCommon = args: self: super: {};
}
