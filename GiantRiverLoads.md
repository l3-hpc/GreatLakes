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
