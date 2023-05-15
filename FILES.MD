Working directories

Research storage, location and cd
```
/rsstu/users/l/lllowe/LakeErie/
le
``

Limnotech's model
```
/rsstu/users/l/lllowe/LakeErie/A2EM_UFV
```

Limnotech inputs:
```
!========== A2EM Input Files ===================================================

BCFILNA = bc.inp
*** BC Options
         2         1


PSFILNA = ps.inp
NPSFILNA = NULL
FLFILNA = NULL
ATMFILNA = atm.inp
PCFILNA = pc.inp
ICFILNA = ic.inp
KINFILNA = sed.inp
```

rivers file, Baseline_2013_riv.dat, has 80 lines for rivers, then
```
2
0
```

OBC file, Baseline_2013_obc.dat, has
```
OBC Node Number =   2
1       6105    1       15.     0.
2       6106    1       15.     0.
```

My NML file:
```
 &NML_OPEN_BOUNDARY_CONTROL
 OBC_ON                     = T,
 OBC_NODE_LIST_FILE         = 'leem_fine_obc.dat',
 OBC_ELEVATION_FORCING_ON   = T,
 OBC_ELEVATION_FILE         = '2013_leem_fine_julian_obc.nc',
 OBC_TS_TYPE                = 1,
 OBC_TEMP_NUDGING           = F,
 OBC_TEMP_FILE              = 'none',
 OBC_TEMP_NUDGING_TIMESCALE =  1.0000000E+00,
 OBC_SALT_NUDGING           = F,
 OBC_SALT_FILE              = 'none',
 OBC_SALT_NUDGING_TIMESCALE =  0.0000000E+00,
 OBC_MEANFLOW               = F,
 OBC_MEANFLOW_FILE          = 'none',
 OBC_LONGSHORE_FLOW_ON      = F,
 OBC_LONGSHORE_FLOW_FILE    = 'none'
 /
```

mod_input.F:
```
#   if defined (BioGen)
    OBC_BIO_NUDGING = .False.
    OBC_BIO_FILE = trim(casename)//"_obc.nc "
    OBC_BIO_NUDGING_TIMESCALE = 0.0
#   endif    
```

mod_force.F
```
SUBROUTINE OBC_BIO
...
    ! FIND THE FORCING FILE OBJECT
    OBC_B_FILE => FIND_FILE(FILEHEAD,trim(OBC_BIO_FILE),FOUND)
    IF(.not. FOUND) CALL FATAL_ERROR &
         & ("COULD NOT FIND OPEN BOUNDARY CONDITION BIOLOGICAL FILE OBJECT",&
         & "FILE NAME: "//TRIM(OBC_BIO_FILE))
         
         
       IF(NTT > 0)THEN
       VAR => FIND_VAR(OBC_B_FILE,BIO_NAME(1,1),FOUND)
       IF(.not. FOUND) CALL FATAL_ERROR &
            & ("IN OPEN BOUNDARY CONDITION BIOLOGICAL NUDGING FILE OBJECT",&
            & "FILE NAME: "//TRIM(OBC_BIO_FILE),&
            &"COULD NOT FIND VARIABLE "//TRIM(BIO_NAME(1,1)))

       ATT => FIND_ATT(VAR,'units',FOUND)
       IF(.not. FOUND) CALL FATAL_ERROR &
            & ("IN OPEN BOUNDARY CONDITION BIOLOGICAL NUDGING FILE OBJECT",&
            & "FILE NAME: "//TRIM(OBC_BIO_FILE),&
            &"COULD NOT FIND BIO1 VARIRIABLE'S ATTRIBUTE 'units'")

       if(TRIM(ATT%CHR(1)) .NE. BIO_NAME(1,2))  CALL FATAL_ERROR &
            & ("IN OPEN BOUNDARY CONDITION BIOLOGICAL NUDGING FILE OBJECT",&
            & "FILE NAME: "//TRIM(OBC_BIO_FILE),&
            &"BIO1 VARIRIABLE ATTRIBUTE 'units' SHOULD BE "//TRIM(BIO_NAME(1,2)))

```

leem_fine_obc.dat
```
OBC Node Number =   2
1       6105    1       15.     0.
2       6106    1       15.     0.
```

OBC NAMELIST, mod_main.F
```
    NAMELIST /NML_OPEN_BOUNDARY_CONTROL/    &
         & OBC_ON,                          &
         & OBC_NODE_LIST_FILE,              &
         & OBC_ELEVATION_FORCING_ON,        &
         & OBC_ELEVATION_FILE,              &
         & OBC_TS_TYPE,                     &
         & OBC_TEMP_NUDGING,                &
         & OBC_TEMP_FILE,                   &
         & OBC_TEMP_NUDGING_TIMESCALE,      &
         & OBC_SALT_NUDGING,                &
         & OBC_SALT_FILE,                   &
         & OBC_SALT_NUDGING_TIMESCALE,      &
#   if defined (WATER_QUALITY)
         & OBC_WQM_NUDGING,                 &
         & OBC_WQM_FILE,                    &
         & OBC_WQM_NUDGING_TIMESCALE,       &
#   endif    
#   if defined (BioGen)
         & OBC_BIO_NUDGING,                 &
         & OBC_BIO_FILE,                    &
         & OBC_BIO_NUDGING_TIMESCALE,       &
#   endif    
         & OBC_MEANFLOW,                    &
         & OBC_MEANFLOW_FILE,               &
         & OBC_TIDEOUT_INITIAL,             &
         & OBC_TIDEOUT_INTERVAL,            &
         & OBC_LONGSHORE_FLOW_ON,           &
         & OBC_LONGSHORE_FLOW_FILE,         &
         & OBC_DEPTH_CONTROL_ON
```


