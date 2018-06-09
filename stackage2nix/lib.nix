{ stdenv, cacert, git, curl, perl
, cacheVersion ? "0" }:

{

  hackage-db = stdenv.mkDerivation {
    name = "hackage-db";
    version = cacheVersion;
    phases = [ "installPhase" ];
    buildInputs = [ curl ];
    installPhase = ''
      mkdir -p $out
      pushd $out
      curl -o 01-index.tar.gz https://hackage.haskell.org/01-index.tar.gz
      gunzip --keep 01-index.tar.gz
      popd
    '';
    SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
  };

  all-cabal-hashes = stdenv.mkDerivation rec {
    name = "all-cabal-hashes";

    repo = "https://github.com/commercialhaskell/all-cabal-hashes";
    rev = "5ce8e35ce4a408b2421296307f2a4f1ec232affb";

    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "1albwcvfx2rkrm84llviw1ijx4dknkyq7mahbcipw9ys62700lsq";

    phases = [ "buildPhase" ];
    nativeBuildInputs = [ git perl ];
    buildPhase = ''
      # To reduce overhead we are going to checkout 'display' branch (which have just a few files)
      git clone --branch display https://github.com/commercialhaskell/all-cabal-hashes.git $out

      cd $out
      # And now we are checking all the required .cabal files
      git reset --hard ${rev}

      # .git directory is not reproducible, so we are going to
      # materialize an explicit mapping from sha1 hash to .cabal file
      # on top of filesystem. Note that we mention `rev` explicitly
      # here, so we are always getting a consistent set of objects.
      git rev-list --objects ${rev} \
       | git cat-file --batch-check='%(objectname) %(objecttype) %(rest)' \
       | grep '^[^ ]* blob' \
       | grep -F .cabal \
       | awk '{print $1}' \
       | perl -MFile::Path -nlE 'my($l1, $l2) = m/^(..)(..)/; my $path = "$ENV{out}/_hash-lookup/$l1/$l2"; mkpath $path; system("git cat-file blob $_ > $path/$_")'

      # And now we can get rid of non-deterministic part
      rm -rf .git
    '';

    SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
  };

  stackage-lts = stdenv.mkDerivation {
    name = "stackage-lts";
    version = cacheVersion;
    phases = [ "installPhase" ];
    buildInputs = [ git ];
    installPhase = ''
      mkdir -p $out
      git clone --depth 1 https://github.com/fpco/lts-haskell.git $out
    '';
    SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt";
  };

}
