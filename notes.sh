#!/bin/sh

myNotesDir="./content/notes"

if [[ -d $myNotesDir ]]
then
    rm -rf $myNotesDir
fi

git clone https://github.com/Haider-Mirza/Notes.git ./content/notes
cd $myNotesDir
rm -rf README.org
rm -rf .git/
