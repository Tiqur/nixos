# Write file-structure to README.md
readme_contents="### File structure:"
readme_contents+="\n\`\`\`"
readme_contents+="\n$(tree .)"
readme_contents+="\n\`\`\`"
echo -e "$readme_contents" > README.md

# Format files
find . -type f -name "*.nix" -exec nixfmt {} \;


# Add to git repo and push
git add .
git checkout -b main
git commit -m "$(hostname) $(nixos-rebuild list-generations | grep current | cut -d" " -f1)"
git push -u origin main
