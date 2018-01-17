let
  nixpkgs = import ./nixpkgs-pinned.nix {};
  inherit (nixpkgs) pkgs lib haskell;

  stackage2nixSrc = pkgs.fetchFromGitHub (lib.importJSON ./stackage2nix.json);

  stackagePackages = haskell.packages.stackage.lib.callStackage2nix "stackage2nix" stackage2nixSrc { inherit nixpkgs; };
  stackage = stackagePackages.override {
    overrides = self: super: {
      stackage2nix = haskell.lib.disableSharedExecutables super.stackage2nix;
    };
  };
in
  stackage.stackage2nix
