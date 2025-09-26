
echo "Installing configuration"
nix-shell -p home-manager nix-output-monitor --run "pwd; make reload-home"
# nix run home-manager/release-25.05 -- switch --impure

