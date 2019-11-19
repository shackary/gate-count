cd /home/pi/Documents/gate-count
git stash
git pull
git stash apply
git add raws/hits_test.txt
git commit -m "new updates"
git push
