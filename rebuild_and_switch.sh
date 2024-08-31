./rebuild.sh

git add .
git commit -m "$(hostname) $(nixos-rebuild list-generations | grep current | cut -d" " -f1)"
git push -u origin main
