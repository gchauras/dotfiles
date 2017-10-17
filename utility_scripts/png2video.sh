#!/bin/bash

if [ $# -eq 3 ]
then
    fps=$3
    video=$2
    dir=$1
    curr_dir=`pwd`

    cd $dir
    mencoder "mf://*.png" -mf fps=$fps $MENCODER_X264OPTS -o $video
    mv $video $curr_dir/
    cd $curr_dir

else
    echo "Usage: png2video.sh [directory containing png files] [output video file]"
    exit 1;
fi
