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
        lib = super.callPackage ./stackage2nix/lib.nix {};
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
      let
        staticConfigureFlags = super.lib.concatStringsSep " " [
          "--ghc-option=-optl=-static"
          "--ghc-option=-optl=-pthread"
          "--ghc-option=-optl=-L${super.glibc.static}/lib"
          "--ghc-option=-optl=-L${super.gmp5.static}/lib"
          "--ghc-option=-optl=-L${self.icu-static.static}/lib"
          "--ghc-option=-optl=-L${self.openssl-static.static}/lib"
          "--ghc-option=-optl=-L${super.zlib.static}/lib"
        ];
        buildStaticExecutable = drv:
          super.haskell.lib.appendConfigureFlag (super.haskell.lib.disableSharedExecutables drv) staticConfigureFlags;
      in
        buildStaticExecutable
         (self.haskell.packages.stackage.lts-100.callPackage ./stackage2nix/stackage2nix.nix{});
    cacheVersion = builtins.readFile ./cache-version.txt;
  };

  icu-static = super.icu.overrideAttrs (attrs: {
    dontDisableStatic = true;
    configureFlags = normalizedConfigureFlags attrs.configureFlags ++ [ "--enable-static" ];
    outputs = attrs.outputs ++ [ "static" ];
    postInstall = ''
      moveToOutput "lib/*.a" "$static"
    '' + attrs.postInstall;
  });

  openssl-static = super.openssl.overrideAttrs (attrs: {
    dontDisableStatic = true;
    outputs = attrs.outputs ++ [ "static" ];
    postInstall = ''
      mkdir -p $static/lib;
      moveToOutput "*.a" "$static/lib";
    '' + attrs.postInstall;
  });

}
