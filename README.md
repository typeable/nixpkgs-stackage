# nixpkgs-stackage

[![Build Status](https://travis-ci.org/typeable/nixpkgs-stackage.svg?branch=master)](https://travis-ci.org/typeable/nixpkgs-stackage)

Nixpkgs overlay adding Stackage Haskell packages at the `pkgs.haskell.packages.stackage`

# Install

Symlink the current `./default.nix` into the `~/.config/nixpkgs/overlays` folder.

```
cd ~/.config/nixpkgs/overlays
ln -s /path/to/default.nix stackage-overlay.nix
```

## Contents

- Stackage LTS releases at `pkgs.haskell.packages.stackage`
- [stackage2nix][] at `pkgs`
- build utils at `pkgs.haskell.packages.stackage.lib`

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

Build derivation for `stackage2nix` from `stackage2nix.json` source.

``` nix
let
  nixpkgs = import <nixpkgs> {
    overlays = [ (import ../default.nix) ];
  };
  inherit (nixpkgs) pkgs lib;

  stackage2nixSrc = pkgs.fetchFromGitHub (lib.importJSON ./stackage2nix.json);

  stackage = nixpkgs.haskell.packages.stackage.lib.callStackage2nix "stackage2nix" stackage2nixSrc {
    inherit nixpkgs;
  };
in
  stackage
```

Build:

```
nix-build example.nix -A stackage2nix
```

See [examples](./examples) directory for more


[stackage2nix]: https://github.com/typeable/stackage2nix
