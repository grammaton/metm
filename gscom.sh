#!/usr/bin/env bash

# use it by terminal typing:
# bash gscom.sh commitname

git status
git add CAPITOLI/
git commit -am "$1"
