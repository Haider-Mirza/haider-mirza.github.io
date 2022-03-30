#!/bin/sh

# Variables
myNotesDir="./content/notes"

echo -e "Cloning Notes Git Repository\n"
rm -rf $myNotesDir
git clone https://github.com/Haider-Mirza/Notes.git ./content/notes

cd $myNotesDir

echo -e "Deleting Useless Files\n"
rm -rf README.org
rm -rf .git/

echo "Renaming Notes"
# for i in $( ls -p | grep -v / ); do
# mv "${i}" "${i/*-/}"
# done

for i in $( ls ); do
mv "${i}" "${i/*-/}"
done

