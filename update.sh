cp $HOME/*.nix home
cp /etc/nixos/custom-configuration.nix etc/nixos/custom-configuration.nix
cp --recursive $HOME/includes home
git diff
git add .
git commit
git push origin master
