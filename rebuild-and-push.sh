# Copy files to /etc/nixos/
sudo cp -r ./* /etc/nixos/

nix fmt

# Rebuild
sudo nixos-rebuild switch --flake /etc/nixos/#tiqur-nixos


# Commit and push to repo
git add .
git commit -m "$(hostname) $(nixos-rebuild list-generations | grep current | cut -d" " -f1)"
git push -u origin main

#cowsay --super "Done!"
