#!/bin/bash

if [ $# -eq 1 ]
then
    dir=$1;
    images=`find -E $dir -maxdepth 1 -type f -regex ".*\.(jpg|jpeg|JPG|JPEG)"`;
    renamed_dir=$dir/renamed;
    mkdir -p $renamed_dir;

    for f in $images
    do
        fname=`jhead $f | grep "Date/Time" | sed 's/Date.*2017/2017/' | sed 's/\:/_/g' | sed 's/ /_/g'`;
        if [ -n "$fname" ]
        then
            fnew=$renamed_dir/$fname.jpg;
            echo "Renamed $f $fnew";
            cp $f $fnew;
        else
            cp $f $renamed_dir/;
            echo "Cannot rename $f, no EXIF tags";
        fi
    done
else
    echo "Usage: rename_photographs_by_date_taken.sh [directory containing images]";
fi
