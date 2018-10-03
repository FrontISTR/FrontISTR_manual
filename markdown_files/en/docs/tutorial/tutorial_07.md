## Static Analysis (Viscoelasticity)

Data of `tutorial/07_viscoelastic_cylinder/` is used to implement this analysis.

### Analysis Object

The same 1/8 model cylinder as in the static analysis (hyperelasticity part 1) in Section 4.3 is the object of the analysis.

### Analysis Content

Stress relaxation analysis is implemented where tension displacement is applied to the cylinder in the axial direction. The analysis control data is shown in the following.

```
# Control File for FISTR
## Analysis Control
!VERSION
  3
!SOLUTION, TYPE=NLSTATIC
!WRITE,VISUAL
!WRITE,RESULT
## Solver Control
### Boundary Conditon
!BOUNDARY, GRPID=1
  LOADS, 3, 3, -7.0
  FIX, 3, 3, 0.0
  XSYMM, 1, 1, 0.0
  YSYMM, 2, 2, 0.0
### STEP
!STEP, TYPE=VISCO, CONVERG=1.0e-5
  0.2, 2.0
  BOUNDARY, 1
### Material
!MATERIAL, NAME=MAT1
!ELASTIC
  206900.0, 0.29
!VISCOELASTIC
  0.5, 1.0
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=YES,TIMELOG=YES
  10000, 2
  1.0e-8, 1.0, 0.0
```

### Analysis Results

A deformed figure applied with a contour of the Mises stress was created by REVOCAP_PrePost, and is shown in Figure 4.7.1. This is the analysis results after 2 seconds (10th step). Moreover, a portion of the analysis results log file is shown in the following as numeric data of the analysis results.

<div style="text-align: center;">
<img src="./media/tutorial07_01.png" width="350px"><br>
Figure 4.7.1: Analysis Results of Deformation and Mises Stress
</div>

```
#### Result step=
10
##### Local Summary :Max/IdMax/Min/IdMin####
  //U1   0.0000E+00         1 -7.4531E-01       91
  //U2   0.0000E+00         1 -7.4531E-01       88
  //U3   0.0000E+00         1 -7.0000E+00       38
  //E11 -1.0763E-01        38 -1.1244E-01        7
  //E22 -1.0763E-01        50 -1.1244E-01       13
  //E33  3.0270E-01        13 2.9129E-01        50
  //E12  9.8113E-04        53 -9.9997E-04       10
  //E23  1.1878E-04        72 -3.2869E-03       84
  //E13  1.1878E-04        64 -3.2869E-03       95
  //S11  1.4135E+02        13 -1.3699E+02       50
  //S22  1.4135E+02         7 -1.3699E+02       38
  //S33  3.8691E+04        13 3.7107E+04        50
  //S12  4.6701E+01        53 -4.7594E+01       10
  //S23  5.2254E+00        72 -1.5313E+02       84
  //S13  5.2254E+00        64 -1.5313E+02       95
  //SMS  3.8602E+04        13 3.7194E+04        50
```
