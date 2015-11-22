#!/bin/bash
if [ $# -lt 0 ]
then
   echo ""
   echo "Usage: ajoute_fichier.sh [fichier]  [commit] "
   echo ""
 exit 1
fi

#cp $1 .
git add $1 
git commit -m "$2"
git push 

