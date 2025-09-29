
echo "Installing configuration"
FOLDER=$(pwd)
nix-shell -p home-manager nix-output-monitor \
    --run "cd $FOLDER; pwd; make reload-home"

