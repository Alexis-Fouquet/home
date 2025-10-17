
# Makefile for quick usage of nix commands
.PHONY: full reload-os update reload-home
# If switching again to nom instead of nh
# nom = |& { command -v nom && nom || cat; }

full: update
	make reload-os

# impure as it is using a configuration file located in another folder
reload-os:
	nh os switch . -- --impure

reload-home:
	nh home switch . -- --impure

update: flake.lock

flake.lock:
	nix flake update

