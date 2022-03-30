#!/bin/sh

myNotesDir="./content/notes"
rm -rf $myNotesDir
git clone https://github.com/Haider-Mirza/Notes.git ./content/notes
cd $myNotesDir
rm -rf README.org
rm -rf .git/
