# Stackage

generate:

```
~/.local/bin/stackage2nix --hackage-db /home/dbushev/.cabal/packages/hackage.haskell.org/01-index.tar --all-cabal-hashes /home/dbushev/projects/commercialhaskell/all-cabal-hashes --lts-haskell /home/dbushev/projects/fpco/lts-haskell --resolver lts-6.30
```
check:

```
nix-env -f '<nixpkgs>' -qaP -A pkgs.haskell.packages.stackage.lts-635
```
