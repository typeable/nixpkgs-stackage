#!/bin/sh
#
# nixpkgs-typeable update script
#
# - updates ./cacheVersion.txt, this will trigger updates of
#   `stackage-lts`, `all-cabal-hashes` and `hackage-db`
# - generates new stackage releases in `stackage` directory
# - updates `stackage/default.nix` index

DATE=$(date --iso-8601)
echo $DATE > cacheVersion.txt
exec nix-shell update.nix --argstr cacheVersion "$DATE"
