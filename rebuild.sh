# Copy files to /etc/nixos/
sudo cp -r ./* /etc/nixos/

# Rebuild
sudo nixos-rebuild switch --flake /etc/nixos/#tiqur-nixos


# Commit and push to repo
#git add .
#git commit -m ""
#git push -u origin main

cowsay --super "Done!"
