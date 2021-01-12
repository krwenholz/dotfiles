cp --recursive --force home/* $HOME
sudo cp etc/nixos/custom-configuration.nix /etc/nixos/custom-configuration.nix
echo "Don't forget to rebuild nix for changes to take effect"
