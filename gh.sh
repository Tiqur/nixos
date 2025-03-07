tree . > README.md

git add .
git checkout -b main
git commit -m "$(hostname) $(nixos-rebuild list-generations | grep current | cut -d" " -f1)"
git push -u origin main
