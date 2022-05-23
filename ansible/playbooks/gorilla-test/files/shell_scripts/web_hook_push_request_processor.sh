#!/bin/bash
FILES="/home/gorilla-admin/*.txt"
while true;
do
    for f in $FILES
    do
      if [ -f "$f" ]
      then
          echo "Processing $f request..."
          cd /home/gorilla-admin/src
          sudo -u gorilla-admin git pull origin master
          supervisorctl restart gorilla-timeoff-app
          cd /home/gorilla-admin
          rm -f $f
      fi
    done
    echo "Waing for more requests..."
    sleep 10
done
