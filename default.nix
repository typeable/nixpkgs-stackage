self: super:

let

  # from pkgs/stdenv/generic/make-derivation.nix
  # This parameter is sometimes a string, sometimes null, and sometimes a list, yuck
  normalizedConfigureFlags = configureFlags: let inherit (super) lib; in
    (/**/ if lib.isString configureFlags then [configureFlags]
     else if configureFlags == null      then []
     else                                     configureFlags);

in {
  haskell = super.haskell // {
    packages = super.haskell.packages // {
      stackage = super.callPackage ./stackage {} // {
        lib = super.callPackage ./lib.nix { };
      };
    };
  };

  stackage2nix = super.callPackage ./stackage2nix {
    stackage2nix = super.haskell.lib.disableSharedExecutables
      (self.haskell.packages.stackage.lts-100.callPackage ./stackage2nix/stackage2nix.nix{});
    cacheVersion = builtins.readFile ./cache-version.txt;
  };

  stackage2nix-static = super.callPackage ./stackage2nix {
    stackage2nix =
      (self.haskell.packages.stackage.lts-100.callPackage ./stackage2nix/stackage2nix.nix {}).overrideAttrs (attrs: {
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
