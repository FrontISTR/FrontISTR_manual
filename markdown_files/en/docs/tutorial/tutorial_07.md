## Non-Linear Static Analysis (Viscoelasticity)

This analysis uses the data of `tutorial/07_viscoelastic_cylinder`.

### Analysis target

The object of analysis is the same round-bar 1/8 model as the [Non-Linear Static Analysis (Hyperelasticity, Part 1)](tutorial_03.md).

### Analysis content

A stress relaxation analysis is performed by applying axial tensile displacement to a round bar. The analysis control data is shown below.

#### Analysis control data `cylinder.cnt`

```
#  Control File for FISTR
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
 FIX,   3, 3, 0.0
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
 10000, 1
 1.0e-8, 1.0, 0.0
## Post Control
!VISUAL,metod=PSR
!surface_num=1
!surface 1
!output_type=VTK
!END
```

### Analysis procedure

Execute the FrontISTR execution command `fistr1`.

```
$ cd FrontISTR/tutorial/07_viscoelastic_cylinder
$ fistr1 -t 4
(Runs in 4 threads.)
```

### Analysis results

The deformation diagram with the Mises stress contours added is created by REVOCAP_PrePost and shown in Figure 4.7.1. The analysis results after 2 seconds (10th step). A part of the log file is shown below as numerical data of the analysis results.

![Analysis results of deformation and Mises stress](./media/tutorial07_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.7.1: Analysis results of deformation and Mises stress
</div>

#### Analysis results log `0.log`.

```
 fstr_setup: OK
#### Result step=     0
 ##### Local Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    0.0000E+00         1  0.0000E+00         1
 //U2    0.0000E+00         1  0.0000E+00         1
 //U3    0.0000E+00         1  0.0000E+00         1
 //E11   0.0000E+00         1  0.0000E+00         1
 //E22   0.0000E+00         1  0.0000E+00         1
 //E33   0.0000E+00         1  0.0000E+00         1
 //E12   0.0000E+00         1  0.0000E+00         1
 //E23   0.0000E+00         1  0.0000E+00         1
 //E31   0.0000E+00         1  0.0000E+00         1
 //S11   0.0000E+00         1  0.0000E+00         1
 //S22   0.0000E+00         1  0.0000E+00         1
 //S33   0.0000E+00         1  0.0000E+00         1
 //S12   0.0000E+00         1  0.0000E+00         1
 //S23   0.0000E+00         1  0.0000E+00         1
 //S31   0.0000E+00         1  0.0000E+00         1
 //SMS   0.0000E+00         1  0.0000E+00         1
 ##### Local Summary @Element :Max/IdMax/Min/IdMin####
 //E11   0.0000E+00         1  0.0000E+00         1
 //E22   0.0000E+00         1  0.0000E+00         1
```


