# nixpkgs-stackage

Nixpkgs overlay with Haskell Stackage packages

## Packages

- Stackage LTS releases
- [stackage2nix][]

## Install

Symlink the current `./default.nix` into the `~/.config/nixpkgs/overlays` folder.

```
cd ~/.config/nixpkgs/overlays
ln -s /path/to/default.nix stackage-overlay.nix
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

Update script will add missing lts releases to `stackage` directory:

```
./update.sh
```

# Examples

Build derivation example for `stackage2nix` source repo.

``` nix
let
  nixpkgs = import <nixpkgs> {
    overlays = [ (import ../default.nix) ];
  };
  inherit (nixpkgs) pkgs lib;

  stackage2nixSrc = pkgs.fetchFromGitHub (lib.importJSON ./stackage2nix.json);

  stackage = nixpkgs.haskell.packages.stackage.lib.callStackage2nix "schematic" stackage2nixSrc {
    inherit nixpkgs;
  };
in
  stackage.stackage2nix
```

Build:

```
nix-bulid example.nix
```

See [examples](./examples) directory for more


[stackage2nix]: https://github.com/typeable/stackage2nix
