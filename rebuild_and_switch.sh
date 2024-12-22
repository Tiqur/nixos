#sudo nix flake update
sudo nixos-rebuild switch --upgrade --flake .#default --verbose


git add .
git checkout -b main
git commit -m "$(hostname) $(nixos-rebuild list-generations | grep current | cut -d" " -f1)"
git push -u origin main
