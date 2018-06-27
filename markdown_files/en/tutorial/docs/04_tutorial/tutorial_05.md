## Static Analysis (Elastoplasticity Part 1)

Data of `tutorial/05_plastic_cylinder/` is used to implement this analysis.

### Analysis Object

The same 1/8 model cylinder as the static analysis (hyperelasticity part 1) in Section 4.3 is the object of the analysis.

### Analysis Content

The necking phenomenon of the cylinder by plastic deformation is analyzed. The Mises model is used for the yield function. The analysis control data shown in the following.

```
# Control File for FISTR
## Analysis Control
!VERSION
  3
!SOLUTION, TYPE=NLSTATIC
!WRITE,RESULT,FREQUENCY=10
!WRITE,VISUAL,FREQUENCY=10
## Solver Control
### Boundary Conditon
!BOUNDARY, GRPID=1
  LOADS, 3, 3, -7.0
  FIX, 3, 3, 0.0
  XSYMM, 1, 1, 0.0
  YSYMM, 2, 2, 0.0
### STEP
!STEP, SUBSTEPS=40, CONVERG=4.6e-3
  BOUNDARY, 1
### Material
!MATERIAL, NAME=MAT1
!ELASTIC
  206900.0, 0.29
!PLASTIC, YIELD=MISES, HARDEN=MULTILINEAR
  450.0, 0.0
  608.0, 0.05
  679.0, 0.1
  732.0, 0.2
  752.0, 0.3
  766.0, 0.4
  780.0, 0.5
### Output
!OUTPUT_VIS
  NSTRAIN, ON
!OUTPUT_RES
  ISTRESS, ON
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=NO,TIMELOG=YES
  2000, 2
  1.0e-8, 1.0, 0.0
```

### Analysis Results

As analysis results of the 35th sub step, a deformed figure applied with a contour of the Mises stress was created by REVOCAP\_PrePost, and is shown in Figure 4.5.1. Moreover, a portion of the analysis results log file is shown in the following as numeric data of the analysis results.

<div style="text-align: center;">
<img src="../media/image05_01.png" width="350px"><br>
Figure 4.5.1: Analysis Results of Deformation and Mises Stress
</div>

```
#### Result step=    40
 ##### Local Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    0.0000E+00         1 -7.2695E-01         7
 //U2    0.0000E+00         1 -7.2695E-01        13
 //U3    0.0000E+00         1 -7.0000E+00        38
 //E11  -1.0810E-01        38 -1.2378E-01         7
 //E22  -1.0810E-01        50 -1.2378E-01        13
 //E33   2.4788E-01        13  2.1876E-01        38
 //E12   9.9178E-04        53 -1.1026E-03        10
 //E23   8.1094E-08        38 -3.4137E-03        86
 //E31   8.1094E-08        50 -3.4137E-03        93
 //S11   1.0846E+01         1 -1.2094E+01        44
 //S22   1.0846E+01         1 -1.2094E+01        44
 //S33   7.5130E+02         1  7.2331E+02        44
 //S12   1.3859E+00       148 -2.0846E+00       136
 //S23   1.7004E+00       100 -5.6058E+00        80
 //S31   1.7004E+00        79 -5.6058E+00        99
 //SMS   7.4086E+02        13  7.3505E+02        38
```
