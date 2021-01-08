cp $HOME/*.nix home
cp --recursive $HOME/includes home
git diff
git add .
git commit
git push origin master
