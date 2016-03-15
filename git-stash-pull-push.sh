#!/bin/bash

# Equivalent to git stash && git pull --rebase && git push && git stash pop
# (stash pop only runs if there was something to stash)

set -e

echo
echo "*** Stashing ***"
OP=$(git stash)
echo "$OP"
if [ $? -ne 0 ]
then
	echo "ERROR: Failed to stash. Bailing out."
	exit 1
fi

if [ "$OP" = "No local changes to save" ]
then
	STASHED=0
else
	STASHED=1
fi

echo
echo "*** Pulling ***"
git pull --rebase

echo
echo "*** Pushing ***"
git push

if [ $STASHED -eq 1 ]
then
	echo
	echo "*** Unstashing ***"
	git stash pop
fi
