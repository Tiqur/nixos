# Copy files to /etc/nixos/
sudo cp -r ./* /etc/nixos/

nix fmt

# Rebuild
sudo nixos-rebuild switch --flake /etc/nixos/#tiqur-nixos

#cowsay --super "Done!"
