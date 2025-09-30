#!/bin/sh

# WARNING - This is only for a temporary usage during this year

num=$1
folder=${PWD##*/}

if [ $# -ne 2 ]; then
    echo "[W] No section provided"
    git commit -am "submit: folder $folder"
    git tag -ma "exercises-$folder-$num"
    git push --follow-tags
else
    section=$2
    git commit -am "submit: folder $folder section $section"
    git tag -ma "exercises-$section-$folder-$num"
    git push --follow-tags
fi

