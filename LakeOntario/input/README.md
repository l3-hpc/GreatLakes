Lake Ontario TP modeling data
- glerl.noaa.gov/waf/data/loofs_for_epa.tar - NOAA/GLERL data (Kessler and Rowe) 3/13/2024
	- See README within for description of all files included
- Converted spherical to cartesian (see files in conversionuFunctions)
- Convert WRF to FVCOM grid
```bash
/work/GLHABS/LakeOntario/shared/WRF2FVCOM/wrf2fvcom \
-i /work/GLHABS/LakeOntario/shared/loofs_for_epa/forcing/loofs_met_2018_06.nc \
-o /work/GLHABS/LakeOntario/shared/loofs_for_epa/forcing/loofs_met_2018_06_FVCOM.nc \
-v 4.0
```
