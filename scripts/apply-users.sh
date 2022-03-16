#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/sonoflope/home.nix
popd
