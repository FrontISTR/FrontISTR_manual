## Static Analysis (Elastoplasticity Part 2)

Data of `tutorial/06_plastic_can/` is used to implement this analysis.

### Analysis Object

The object for analysis is a 1/2 model of a can. The shape is shown in Figure 4.6.1, and the mesh data is shown in Figure 4.6.2. Quadratic tetrahedral elements are used for the mesh, and the scale of the mesh consists of 7,236 elements and 14,119 nodes.

<div style="text-align: center;">
<img src="./media/image06_01.png" width="350px"><br>
Figure 4.6.1: Shape of Can
</div>

<div style="text-align: center;">
<img src="./media/image06_02.png" width="350px"><br>
Figure 4.6.2: Mesh Data of Can
</div>

### Analysis Content

A stress analysis is implemented, where the displacement of the restrained surface shown in Figure 4.6.1 is restrained, and a distributed load was applied to the forced surface inside of the can. The Drucker-Prager model is used for the yield function. The analysis control data is shown in the following.

```
# Control File for FISTR
## Analysis Control
!VERSION
  3
!SOLUTION, TYPE=NLSTATIC
## Solver Control
### Boundary Conditon
!BOUNDARY, GRPID=1
  BND0, 3, 3, 0.000000
!BOUNDARY, GRPID=1
  BND1, 1, 1, 0.000000
  BND1, 2, 2, 0.000000
  BND1, 3, 3, 0.000000
!DLOAD,GRPID=1
  DL0, S, 1.0
!DLOAD,GRPID=1
  DL1, S, 1.0
!DLOAD,GRPID=1
  DL2, S, 0.5
### STEP
!STEP, SUBSTEPS=10, CONVERG=1.0e-5
  BOUNDARY, 1
  LOAD, 1
### Material
!MATERIAL, NAME=M1
!ELASTIC
  24000.0, 0.2
!PLASTIC, YIELD = DRUCKER-PRAGER
  500.0, 20.0, 0.0
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=NO,TIMELOG=YES
  20000, 2
  1.0e-8, 1.0, 0.0
```

### Analysis Results

As analysis results of the 10th sub step, a deformed figure applied with a contour of the Mises stress was created by REVOCAP\_PrePost, and is shown in Figure 4.6.3. The deformation magnification is set to 30. Moreover, a portion of the analysis results log file is shown in the following as numeric data of the analysis results.

<div style="text-align: center;">
<img src="./media/image06_03.png" width="350px"><br>
Figure 4.6.3: Analysis Results of Deformation and Mises Stress
</div>

```
#### Result step=    10
 ##### Local Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    1.6169E+00      1600 -1.6123E+00     11901
 //U2    1.9278E+01      6877 -4.5292E-01      7096
 //U3    1.6086E+00      7016 -1.5103E+00      6934
 //E11   9.9223E-04     11242 -6.5878E-04      1404
 //E22   1.5016E-03     13972 -5.4206E-04      2367
 //E33   9.8440E-04      6833 -6.4767E-04      7000
 //E12   1.6817E-03      2698 -1.7171E-03     11906
 //E23   1.7077E-03      6749 -1.4466E-03     13509
 //E31   1.2095E-03     12475 -1.1185E-03     11342
 //S11   2.7784E+01      1086 -1.9437E+01      2363
 //S22   3.7880E+01     13972 -1.4554E+01      2367
 //S33   2.7338E+01      1086 -1.9739E+01     13082
 //S12   1.6819E+01      2698 -1.7172E+01     11906
 //S23   1.7079E+01      6749 -1.4466E+01     13509
 //S31   1.2089E+01     12475 -1.1180E+01     11342
 //SMS   3.7455E+01      2834  2.7593E-04      7333
```
