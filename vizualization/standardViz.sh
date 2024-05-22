#!/bin/bash

# The first argument to this script must be the input .nc file
# The second argument must be the filepath to save the mpeg file to


echo "convert to cartesian"
module purge
source ~/dataModules.sh
Rscript /work/GLHABS/GreatLakesHydro/utilities/xy_fromLonLat.R $1
module purge


echo "Create png files"
source ~/visitMods.sh
visit -nowin -cli -s /work/GLHABS/GreatLakesHydro/vizualization/standardViz.py $1 $2
module purge

echo "Combine .png files to movie"
ffmpeg -framerate 30 -pattern_type glob -i $2'_*.png' out.mpeg

echo "Clean up"
rm $2*.png 