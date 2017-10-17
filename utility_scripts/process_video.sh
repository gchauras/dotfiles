#!/bin/bash

if [ $# -eq 1 ]
then
    v=$1

    echo Processing $v

    outdir=$v
    outdir+="_frames"

    mkdir -p $outdir
    rm   -rf $outdir/*

    ./video2png.sh $v $outdir 2>> log

    for img in `find $outdir -type f -name *.png -or -name *.jpg`
    do
        ./undistort_gopro.sh $img
    done

    exit 0;
else
    echo "Usage: process_video.sh [path to video]"
    exit 1;
fi
