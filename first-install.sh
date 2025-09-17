
echo "Installing configuration"
nix-shell -p home-manager nix-output-monitor --run "make reload-home"
# nix run home-manager/release-25.05 -- switch --impure

