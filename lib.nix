{ stdenv, lib, cacert, glibcLocales, stackage2nix }:

rec {

  stackageSrc2nix = { name, src }:
    stdenv.mkDerivation {
      name = "stackage2nix-${name}";
      buildInputs = [ stackage2nix ];
      preferLocalBuild = true;
      phases = ["installPhase"];
      SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
      LANG = "en_US.UTF-8";
      LOCALE_ARCHIVE = lib.optionalString stdenv.isLinux "${glibcLocales}/lib/locale/locale-archive";
      installPhase = ''
        export HOME="$TMP"
        mkdir -p "$out"
        cd $out
        stackage2nix "${src}"
      '';
  };

  callStackage2nix = name: src: import (stackageSrc2nix { inherit name src; });

}
