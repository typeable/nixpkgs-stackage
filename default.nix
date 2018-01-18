self: super:

let

  # from pkgs/stdenv/generic/make-derivation.nix
  # This parameter is sometimes a string, sometimes null, and sometimes a list, yuck
  normalizedConfigureFlags = configureFlags: let inherit (super) lib; in
    (/**/ if lib.isString configureFlags then [configureFlags]
     else if configureFlags == null      then []
     else                                     configureFlags);

  bootstrapPackages = import ./stackage2nix/stackage-packages.nix { nixpkgs = self; };

in {
  haskell = super.haskell // {
    packages = super.haskell.packages // {
      stackage = super.callPackage ./stackage {} // {
        lib = super.callPackage ./lib.nix {
          inherit (bootstrapPackages) stackage2nix;
        };
      };
    };
  };

  stackage2nix = import ./stackage2nix {
    cacheVersion = builtins.readFile ./cache-version.txt;
    inherit self;
  };

  stackage2nix-static = import ./stackage2nix {
    drv =
      bootstrapPackages.stackage2nix.overrideAttrs (attrs: {
        enableSharedExecutables = false;
        enableSharedLibraries = false;
        configureFlags = [
          "--disable-shared"
          "--ghc-option=-optl=-static"
          "--ghc-option=-optl=-pthread"
          "--ghc-option=-optl=-L${super.glibc.static}/lib"
          "--ghc-option=-optl=-L${super.gmp5.static}/lib"
          "--ghc-option=-optl=-L${self.icu-static.static}/lib"
          "--ghc-option=-optl=-L${self.openssl-static.static}/lib"
          "--ghc-option=-optl=-L${super.zlib.static}/lib"
          "--ghc-option=-fPIC"
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
