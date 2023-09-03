# LakeErie.md

Notes for the Lake Erie TP model

Start with original FVCOM code and inputs.

LakeErieTP
- source
  - bio_tp
  - mod_bio_3D
- simulations
  -   input
      -   full_year
  -   2013
- scripts

```
DefineScalarExpression("TP_tot", "RPOP + LPOP + RDOP + LDOP + PO4T + LPIP + RPIP + (ZOO1 + ZOO2 + ZOO3)/50.0")
```
