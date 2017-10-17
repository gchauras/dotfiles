#!/bin/bash

# Sets of undistortion parameters a, b, c and sources
declare -a param_sets=( \
    "0.10,-0.32,0"                  # im.snibgo.com/debarrel.htm
    "0.001,0,-0.31"                 # im.snibgo.com/debarrel.htm
    "-0.081,0.192,-0.393"           # im.snibgo.com/debarrel.htm
    "0.06335,-0.18432,-0.13009"     # www.imagemagick.org/Usage/lens/ wide angle
    "0.01359,-0.06034,-0.10618"     # www.imagemagick.org/Usage/lens/ mediaum angle
    "0.030530,-0.124312,-0.038543"  # www.imagemagick.org/Usage/lens/ HD video
    "0,0,-0.5"                      # http://www.noah.org/wiki/ImageMagick (video)
    "0,0,-0.3"                      # http://www.noah.org/wiki/ImageMagick (fisheye)
    )

if [ $# -eq 1 ]
then
    image=$1

    # extract filename extension
    imagename="${image##*/}"
    extension="${imagename##*.}"
    imagename="${imagename%.*}"

    # number of param sets
    num_param_sets=${#param_sets[@]}

    # loop to read all param sets
    for (( i=0; i<${num_param_sets}; i++ ));
    do
        out=`echo $image | sed s/\.$extension/_ud_$i.$extension/g`

        params=${param_sets[$i]}

        echo "Undistorting" $image "->" $out "using" $params

        convert $image -distort barrel $params $out
    done

    exit 0;

else
    echo "Usage: undistort_gopro.sh [path to image]"
    exit 1;
fi
