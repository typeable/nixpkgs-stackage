{ stdenv, cacert, git, curl
, cacheVersion ? "0" }:

{

  hackage-db = stdenv.mkDerivation {
    name = "hackage-db";
    version = cacheVersion;
    phases = [ "installPhase" ];
    src = builtins.fetchTarball https://hackage.haskell.org/01-index.tar.gz;
    installPhase = ''
      mkdir -p $out
      cp -r $src $out
    '';
    SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
  };

  all-cabal-hashes = stdenv.mkDerivation rec {
    name = "all-cabal-hashes";
    version = cacheVersion;
    phases = [ "installPhase" ];
    src = builtins.fetchGit {
      url = https://github.com/commercialhaskell/all-cabal-hashes.git;
      ref = "hackage";
    };
    installPhase = ''
      mkdir -p $out
      cp -r $src $out
    '';
    SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
  };

  stackage-lts = stdenv.mkDerivation {
    name = "stackage-lts";
    version = cacheVersion;
    phases = [ "installPhase" ];
    src = builtins.fetchGit {
      url = https://github.com/fpco/lts-haskell.git;
      ref = "master";
    };
    installPhase = ''
      mkdir -p $out
      cp -r $src $out
    '';
    SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
  };

}
