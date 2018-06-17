self: super:

let

  # from pkgs/stdenv/generic/make-derivation.nix
  # This parameter is sometimes a string, sometimes null, and sometimes a list, yuck
  normalizedConfigureFlags = configureFlags: let inherit (super) lib; in
    (/**/ if lib.isString configureFlags then [configureFlags]
     else if configureFlags == null      then []
     else                                     configureFlags);

  stackage2nixPackages = import ./stackage2nix/stackage-packages.nix { nixpkgs = self; };

in {
  haskell = super.haskell // {
    packages = super.haskell.packages // {
      stackage = super.callPackage ./stackage {} // {
        lib = super.callPackage ./lib.nix {};
      };
    };
  };

  stackage2nix = super.haskell.lib.disableSharedExecutables stackage2nixPackages.stackage2nix;

  stackage2nixWrapper = import ./stackage2nix/impure.nix {
    cacheVersion = builtins.readFile ./cache-version.txt;
    inherit self;
  };

  stackage2nix-static = import ./stackage2nix/impure.nix {
    drv =
      let
        stackagePackages = import ./stackage2nix/stackage-packages.nix { nixpkgs = self; };
      in self.haskell.lib.overrideCabal stackagePackages.stackage2nix (drv: {
        enableSharedExecutables = false;
        enableSharedLibraries = false;
        configureFlags = [
          "--ghc-option=-optl=-static"
          "--ghc-option=-optl=-L${self.glibc.static}/lib"
          "--ghc-option=-optl=-L${self.gmp.override { withStatic = true; }}/lib"
          "--ghc-option=-optl=-L${self.icu-static.static}/lib"
          "--ghc-option=-optl=-L${self.openssl-static.static}/lib"
          "--ghc-option=-optl=-L${self.zlib.static}/lib"
        ];
      });
    cacheVersion = builtins.readFile ./cache-version.txt;
    inherit self;
  };

  icu-static = super.icu.overrideAttrs (attrs: {
    dontDisableStatic = true;
    configureFlags = normalizedConfigureFlags attrs.configureFlags ++ [ "--enable-static" ];
    outputs = attrs.outputs ++ [ "static" ];
    postInstall = ''
      moveToOutput "lib/*.a" "$static"
    '' + (if attrs ? postInstall then attrs.postInstall else "");
  });

  openssl-static = super.openssl.overrideAttrs (attrs: {
    dontDisableStatic = true;
    outputs = attrs.outputs ++ [ "static" ];
    postInstall = ''
      mkdir -p $static/lib;
      cp -v *.a $static/lib;
    '' + (if attrs ? postInstall then attrs.postInstall else "");
  });

}
