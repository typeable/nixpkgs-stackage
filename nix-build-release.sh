#!/bin/sh
#
# Usage:
# test.sh -A lts-100.x86_64-linux --dry-run

set -x
NIXPKGS_ALLOW_BROKEN=1 exec nix-build release.nix \
  --option use-binary-caches false \
  --arg inHydra false \
  $@
