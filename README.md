
This is my main config repository.
Tested on multiple distributions and computers.

To build, use `home-manager build --impure`.
I use the `--impure` argument to be able to get the USER variable in the flake.

Without home-manager, `nix run` or `nix-shell` can be used.
The script `first-install.sh` is provided for this purpose.

The Makefile can be used to run these commands:
- `reload-os`: reload the whole NixOS config, may not work on every computer
- `reload-home`: only home-manager and what it manages (like nixvim)
- `update`: update the lock
- `full`: update and then reload-os

