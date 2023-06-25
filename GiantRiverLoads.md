Alias to get to LakeErie research storage
```
le
```

Lake Erie run output folder
```
cd /rsstu/users/l/lllowe/LakeErie/FVCOM/simulations/2013/output
```

Create a local directory for checking rivers, **CHECK_RIVERS**.  Copy latest leem_0001.nc file.  Open it in VisIt.

For LEEM, calculate TP equivalent
```
DefineScalarExpression("TP_tot", "RPOP + LPOP + RDOP + LDOP + PO4T + LPIP + RPIP + (ZOO1 + ZOO2 + ZOO3)/50.0") 
```

For TP, March 2nd is Cycle 1036800, Time 56353.

To check relative difference:

To make a variable that is the difference with the last timestep, say with variable 'SIT' from filename 'file.nc'.  First load the file.  Then:
Controls : Data level comparisons : Between different time slices on the same mesh
file.nc : Target mesh=SigmaLayer_Mesh : Donor field : SIT
- Specify absolute time
- Time index = 91
Connectivity-based CMFE
Choose a good name for the expression, like 'diffSIT'
What do you want to do with  donor field = Expression with SIT : Variable - donor field
(Choosing "Variable - donor field" will give positive values if the value increases.)
Done

(TP-conn_cmfe(<[91]i:TP>, <SigmaLayer_Mesh>))


```
       IF(BIOLOGICAL_MODEL)THEN

       ! GET THE BIOLOGICAL CONCENTRATION FOR BIO TYPE 1
       IF(NTT > 0)THEN
       VAR => FIND_VAR(NCF,TRIM(BIO_NAME(1,1)),FOUND)
       IF(.NOT.FOUND)CALL FATAL_ERROR &
            & ("IN RIVER FILE COULD NOT FIND BIO DATA FOR BIO TYPE", &
            & TRIM(BIO_NAME(1,1)) )

       ALLOCATE(STORAGE_VEC(nrs), stat = status)
       IF(STATUS /= 0) CALL FATAL_ERROR("ALLOCATION ERROR IN RIVER_DISCHARGE")
       RIVER_FORCING(I)%BIO1_N => reference_var(var)
       CALL NC_CONNECT_PVAR(RIVER_FORCING(I)%BIO1_N,STORAGE_VEC)
       NULLIFY(STORAGE_VEC)

       ALLOCATE(STORAGE_VEC(nrs), stat = status)
       IF(STATUS /= 0) CALL FATAL_ERROR("ALLOCATION ERROR IN RIVER_DISCHARGE")
       RIVER_FORCING(I)%BIO1_P => reference_var(var)
       CALL NC_CONNECT_PVAR(RIVER_FORCING(I)%BIO1_P,STORAGE_VEC)
       NULLIFY(STORAGE_VEC)

       ENDIF
```

```
       IF(NTT > 0)THEN
         RIVER_FORCING(I)%BIO1_N%CURR_STKCNT = 0; RIVER_FORCING(I)%BIO1_P%CURR_STKCNT = 0;
       END IF
```
