readme_contents="### File structure:"  # Initialize variable
readme_contents+="\n\`\`\`"  # Add opening triple backticks
readme_contents+="\n$(tree .)"  # Append the output of `tree .`
readme_contents+="\n\`\`\`"  # Add closing triple backticks
echo -e "$readme_contents" > README.md  # Write to file with newline interpretation

git add .
git checkout -b main
git commit -m "$(hostname) $(nixos-rebuild list-generations | grep current | cut -d" " -f1)"
git push -u origin main
