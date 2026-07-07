git fetch origin %1
git merge --squash origin/%1
git commit -m "Squash merge origin/%1"