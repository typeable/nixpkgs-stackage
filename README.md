# Nix

Nixpgs overlay

## Packages

- Stackage LTS releases
- [stackage2nix][]

## Install

Symlink the current `./haskell-overlay.nix` into the `~/.config/nixpkgs/overlays` folder.

```
cd ~/.config/nixpkgs/overlays
ln -s /path/to/haskell-overlay.nix typeable-overlay.nix
```

## Haskell overlay

List LTS packages:

```
nix-env -f '<nixpkgs>' -qaP -A haskell.packages.stackage.lts-100
```

Install stackage2nix:

```
$ nix-env -i stackage2nix
```

## Update script

Update script will add missing lts releases to `stackage` directory

```
nix-shell update.nix --pure
```

[stackage2nix]: https://github.com/typeable/stackage2nix
