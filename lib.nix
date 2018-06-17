{ stdenv, lib, cacert, glibcLocales, stackage2nixWrapper }:

rec {

  stackageSrc2nix = { name, src }:
    stdenv.mkDerivation {
      name = "stackage2nixWrapper-${name}";

      phases = ["installPhase"];
      buildInputs = [ stackage2nixWrapper ];
      preferLocalBuild = true;

      installPhase = ''
        export HOME="$TMP"
        mkdir -p "$out"
        cd $out
        stackage2nix "${src}"
      '';

      SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
      LANG = "en_US.UTF-8";
      LOCALE_ARCHIVE = lib.optionalString stdenv.isLinux "${glibcLocales}/lib/locale/locale-archive";

  };

  callStackage2nix = name: src: import (stackageSrc2nix { inherit name src; });

}
