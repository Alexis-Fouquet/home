
# Makefile for quick usage of nix commands
.PHONY: full reload-os update reload-home

full: update
	make reload-os

# impure as it is using a configuration file located in another folder
reload-os:
	nixos-rebuild switch --flake . --impure --use-remote-sudo

reload-home:
	home-manager switch --impure

update: flake.lock

flake.lock:
	nix flake update

