self: super:

{
  haskell = super.haskell // {
    packages = super.haskell.packages // {
      stackage = import ./stackage { inherit self; };
    };
  };

  stackage2nix = import ./stackage2nix { nixpkgs = self; };
}
