## Static Analysis (Creep)

This analysis uses the data of `tutorial/08_creep_cylinder`.

### Analysis target

The target of this analysis is the same 1/8 model of a round bar used in Section 4.3, Static Analysis (Hyperelasticity, Part 1).

### Analysis content

In this creep behavior analysis, an axial tensile displacement is given to a round bar. The analysis control data are presented below.

```
# Control File for FISTR
## Analysis Control
!VERSION
  3
!SOLUTION, TYPE=NLSTATIC
!WRITE,RESULT
!WRITE,VISUAL
## Solver Control
### Boundary Conditon
!BOUNDARY, GRPID=1
  LOADS, 3, 3, -7.0
  FIX, 3, 3, 0.0
  XSYMM, 1, 1, 0.0
  YSYMM, 2, 2, 0.0
### STEP
!STEP, SUBSTEPS=5, CONVERG=1.0e-5
  BOUNDARY, 1
### Material
!MATERIAL, NAME=MAT1
!ELASTIC
  206900.0, 0.29
!CREEP, TYPE=NORTON
  1.e-10, 5.0, 0.0
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=YES,TIMELOG=YES
  10000, 2
  1.0e-8, 1.0, 0.0
```

### Analysis results

The analysis results of the fifth sub-step are shown in Fig. 4.8.1 as a deformation diagram with a Mises stress contour created with REVOCAP_PrePost. Furthermore, a part of the log files of the analysis results is shown below as numerical data of the analysis.

![Analysis results of deformation and Mises stress](./media/tutorial08_01.png){: .center width="350px"}
<div style="text-align: center;">
Fig. 4.8.1: Analysis results of deformation and Mises stress
</div>

```
#### Result step= 5
 ##### Local Summary :Max/IdMax/Min/IdMin####
   //U1   0.0000E+00         1 -4.1832E-01       91
   //U2   0.0000E+00         1 -4.1832E-01       88
   //U3   0.0000E+00         1 -7.0000E+00       38
   //E11 -6.5815E-02        38 -6.9387E-02        7
   //E22 -6.5815E-02        50 -6.9387E-02       13
   //E33  2.3854E-01        13 2.2765E-01        38
   //E12  5.4317E-04        53 -5.5746E-04       10
   //E23  8.9875E-05        72 -2.2085E-03       84
   //E13  8.9875E-05        64 -2.2085E-03       95
   //S11  1.1317E+02        14 -1.1102E+02       49
   //S22  1.1317E+02         6 -1.1102E+02       39
   //S33  4.9374E+04        13 4.7081E+04        38
   //S12  4.3566E+01        53 -4.4697E+01       10
   //S23  7.6408E+00        72 -1.6768E+02       84
   //S13  7.6408E+00        64 -1.6768E+02       95
   //SMS  4.9340E+04        13 4.7114E+04        38
```


