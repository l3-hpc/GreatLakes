# run the following from the shell
#Rscript convertSphere2Car.R <inputfile> <number-of-lines-to-skip> <outputfile>

source ~/dataScience.sh

gridFolder=/work/GLHABS/LakeOntario/shared/loofs_for_epa/grid
funcFolder=/work/GLHABS/LakeOntario/shared/conversionFunctions
outputFolder=/work/GLHABS/FVCOM-retry4.3/input

dos2unix ${gridFolder}/fvcom_grd.dat
dos2unix ${gridFolder}/fvcom_cor.dat
dos2unix ${gridFolder}/fvcom_dep.dat


# I ran
Rscript ${funcFolder}/Generate_XY_Coordinates.R -f ${gridFolder}/fvcom_grd.dat -o ${outputFolder}/XY_grid.dat
Rscript ${funcFolder}/convertSphere2Cart.R -f ${gridFolder}/fvcom_cor.dat -s 1 -o ${outputFolder}/XY_cor.dat -c "Lon,Lat,Cor"
Rscript ${funcFolder}/convertSphere2Cart.R -f ${gridFolder}/fvcom_dep.dat -s 1 -o ${outputFolder}/XY_dep.dat -c "Lon,Lat,Depth"
