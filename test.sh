#!/bin/sh

LTS=$1
shift

set -x
NIXPKGS_ALLOW_BROKEN=1 exec nix-build release.nix \
  --arg supportedStackageReleases "[\"$LTS\"]" \
  --arg inHydra false \
  -A $LTS.x86_64-linux \
  $@
