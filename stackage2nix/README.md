# stackage2nix

Directory contains ready-to-use `stackage2nix` wrapper with
`--all-cabal-hashes` and `--lts-haskell` flags set up. It also has all
required executables on `PATH`.

## haskell-packages-private

Directory contains Stackage LTS packages needed to build `stackage2nix` wrapper.

TODO: should be replaced with LTS packages from this repo.

## lib.nix

Provides Nix expressions for `hackage-db`, `all-cabal-hashes` and `lts-haskell`
sources.
