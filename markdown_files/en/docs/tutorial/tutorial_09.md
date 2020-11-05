## Contact Analysis (Part 1)

This analysis uses the data of `tutorial/09_contact_hertz`.

### Analysis target

The analysis is a Hertz contact problem and the geometry to be analyzed is shown in Figure 4.9.1 and the mesh data is shown in Figure 4.9.2.

 | Item              | Description                               | Notes                           | Reference |
 |-------------------|-------------------------------------------|---------------------------------|-----------|
 |Typo of analysis   |Non-linear static analysis(elastic,contact)|!SOLUTION,TYPE=NLSTATIC  !CONTACT|           |
 |Number of nodes    |408                                        |                                 |           |
 |Number of elements |168                                        |                                 |           |
 |Element type       |Eight node hexahedral element              |!ELEMENT,TYPE=361                |           |
 |Material name      |MAT1                                       |!MATERIAL,NAME=MAT1              |           |
 |Material property  |ELASTIC                                    |!ELASTIC                         |           |
 |Boundary conditions|Restraint,Forced displacement              |                                 |           |
 |Matrix solution    |CG/SSOR                                    |!SOLVER,METHOD=CG,PRECOND=1      |           |

![Shape of the analysis target](./media/tutorial09_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.9.1: Shape of the analysis target
</div>

![Mesh data of the analysis target](./media/tutorial09_02.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.9.2: Mesh data of the analysis target
</div>

### Analysis content

The extended Lagrangian multiplier method is used to perform a contact analysis in which a forced displacement in the compressive direction is applied to the upper surface of a 1/4 disc model. The analytical control data are shown below.

#### Analysis control data `cgs3.cnt`.

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
 ALL, 3, 3, 0.0
 BOTTOM, 2, 2, 0.0
 CENTER, 1, 1, 0.0
 UPPER,  2, 2, -0.306
!CONTACT_ALGO, TYPE=ALAGRANGE
!CONTACT, GRPID=1
 CP1, 0.0
### STEP
!STEP, SUBSTEPS=5, CONVERG=1.0e-5
 BOUNDARY, 1
 CONTACT,  1
### Material
!MATERIAL, NAME=MAT1
!ELASTIC
 1100.0, 0.0
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=YES,TIMELOG=YES
 1000, 1
 1.0e-10, 1.0, 0.0
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
$ cd FrontISTR/tutorial/09_contact_hertz
$ fistr1 -t 4
(Runs in 4 threads.)
```

### Analysis results

The results of the 5th substep are shown in Figure 4.9.3. A deformation diagram with contours of the y-direction displacement is created by REVOCAP_PrePost. A part of the analysis results log file is shown below as numerical data for the analysis results.

![Analysis results of deformation and y-direction displacement](./media/tutorial09_03.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.9.3: Analysis results of deformation and y-direction displacement
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

