#!/bin/bash

if [ $# -eq 2 ]
then
    video=$1
    dir=$2

    mkdir -p $dir
    rm -rf   $dir/*
    ffmpeg -i $video -r 1 $dir/%06d.png

    if [ $? -eq 0 ]
    then
        echo "Completed extracting frames from $video to $dir"
        exit 0;
    else
        echo "Failed to extract frames from $video to $dir"
        exit 1;
    fi

else
    echo "Usage: video2image.sh [path to video] [output directory]"
    exit 1;
fi
