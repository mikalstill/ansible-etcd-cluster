#!/bin/bash

git merge upstream/main

# I am not proud of this...
for tag in $(git log --decorate | \
        grep --basic-regexp "commit.*tag: v" | \
        grep -v --basic-regexp "tag.*tag" | \
        sed -e 's/.*tag: //' -e 's/[,)].*//' -e 's/^v//'); do
    echo "Fixing $tag"
    git checkout "v$tag"
    git tag "$tag"
    git push origin "$tag"
done

git checkout master