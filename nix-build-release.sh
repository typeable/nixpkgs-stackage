#!/bin/sh
#
# Usage:
# nix-build-release.sh -A lts_10_0.x86_64-linux --dry-run

set -x
NIXPKGS_ALLOW_BROKEN=1 exec nix-build release.nix \
  --option use-binary-caches false \
  --arg inHydra false \
  $@
