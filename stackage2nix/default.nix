{ stdenv, makeWrapper, nix, nix-prefetch-scripts
, drv
}:

stdenv.mkDerivation rec {
  name = "stackage2nix-${version}";
  version = drv.version;
  phases = [ "installPhase" "fixupPhase" ];
  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${drv}/bin/stackage2nix $out/bin/stackage2nix \
      --prefix PATH ":" "${nix}/bin" \
      --prefix PATH ":" "${nix-prefetch-scripts}/bin"
  '';
}
