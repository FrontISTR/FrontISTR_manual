## Non-Linear Static Analysis (Creep)

This analysis uses the data of `tutorial/08_creep_cylinder`.

### Analysis target

The analysis targets are the same round bar 1/8 model as in the [Non-Linear Static Analysis (Hyperelasticity, part 1)](tutorial_03.md) in section 4.3.

 | Item              | Description                 | Notes                     | Reference |
 |-------------------|-----------------------------|---------------------------|-----------|
 |Type of analysis   |Non-linear static analysis   |!SOLUTION,TYPE=NLSTATIC    |           |
 |Number of nodes    |629                          |                           |           |
 |Number of elements |432                          |                           |           |
 |Element type       |Eight node hexahedral element|!ELEMENT,TYPE=361          |           |
 |Material name      |MAT1                         |!MATERICAL,NAME=MAT1       |           |
 |Material property  |ELASTIC,CREEP                |!ELASTIC !CREEP,TYPE=NORTON|           |
 |Boundary conditions|Restraint,Forced displacement|                           |           |
 |Matrix solution    |CG/SSOR                      |!SOLVER,METHOD=CG,PRECOND=1|           |

### Analysis content

Creep behavior analysis is performed by applying tensile displacement in the axial direction to a round bar. The analysis control data is shown below.

#### Analysis control data `cylinder.cnt`.

```
#  Control File for FISTR
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
 FIX,   3, 3, 0.0
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

Execute the FrontISTR execution command fistr1.

```
$ cd FrontISTR/tutorial/08_creep_cylinder
$ fistr1 -t 4
(Runs in 4 threads.)
```

### Analysis results

The results of the 5th substep are shown in Figure 4.8.1. A deformation diagram with Mises stress contours is created by REVOCAP_PrePost. A part of the analysis results log file is shown below as numerical data for the analysis results.

![Analysis results of deformation and Mises stress](./media/tutorial08_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.8.1: Analysis results of deformation and Mises stress
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

