
echo "Installing configuration"
folder=$(dirname $0)
echo "Will switch to folder $folder"
nix-shell -p home-manager nh \
    --run "cd $folder; pwd; make reload-home"

