{ stdenv, lib, cacert, glibcLocales, stackage2nix, stackage2nixWrapper }:

rec {

  stackage2nixGeneric = { drv, pname, installPhase, name, src }:
    stdenv.mkDerivation {

      name = "${pname}-${name}";

      phases = [ "installPhase" ];
      buildInputs = [ drv ];
      preferLocalBuild = true;

      SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
      LANG = "en_US.UTF-8";
      LOCALE_ARCHIVE = lib.optionalString stdenv.isLinux "${glibcLocales}/lib/locale/locale-archive";

      inherit installPhase;
  };

  stackage2nixWrapperSrc = { name, src }: stackage2nixGeneric {
    drv = stackage2nixWrapper;
    pname = "stackage2nixWrapper";
    installPhase = ''
      export HOME="$TMP"
      mkdir -p $out
      cd $out
      stackage2nix "${src}"
    '';

    inherit name src;
  };

  stackage2nixSrc = { name, src }: stackage2nixGeneric {
    drv = stackage2nix;
    pname = "stackage2nix";
    installPhase = ''
      export HOME="$TMP"
      mkdir -p $out
      cd $out
      stackage2nix "${src}"
    '';

    inherit name src;
  };

  stackage2nixSrcArgs = { name, src, stackage-lts, all-cabal-hashes, hackage-db }: stackage2nixGeneric {
    drv = stackage2nix;
    pname = "stackage2nixArgs";
    installPhase = ''
      export HOME="$TMP"
      mkdir -p $out
      cd $out
      stackage2nix --all-cabal-hashes ${all-cabal-hashes} --lts-haskell ${stackage-lts} --hackage-db ${hackage-db}
    '';

    inherit name src;
  };

  callStackage2nix = name: src: import (stackage2nixSrc { inherit name src; });

  callStackage2nixWrapper = name: src: import (stackage2nixWrapperSrc { inherit name src; });

  callStackage2nixArgs = name: src: stackage-lts: all-cabal-hashes: hackage-db:
    import (stackage2nixSrcArgs { inherit name src stackage-lts all-cabal-hashes hackage-db; });

}
