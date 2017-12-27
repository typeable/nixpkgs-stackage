self: super:

{
  haskell = super.haskell // {
    packages = super.haskell.packages // {
      stackage = super.callPackage ./stackage {};
    };
  };

  stackage2nix = import ./stackage2nix { nixpkgs = super; };
}
