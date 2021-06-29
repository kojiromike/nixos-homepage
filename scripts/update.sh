#!/usr/bin/env bash

set -e

echo "Updating flake inputs..."
nix flake lock \
  --update-input released-nixpkgs-unstable \
  --update-input released-nixpkgs-stable \
  --update-input released-nix-unstable \
  --update-input released-nix-stable \
  --update-input nix-pills
  # TODO: temporarily disable nix-dev since it does not build
  #--update-input nix-dev

echo "Shuffle commercial providers ..."
nix develop --command shuffle-commercial-providers --input community/commercial-support.toml > community/commercial-support.html.in

echo "Updating blog..."
nix develop --command update-blog --output-dir blog/
