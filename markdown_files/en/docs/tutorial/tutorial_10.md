## Contact Analysis (Part 2)

This analysis uses the data of `tutorial/10_contact_2tubes`.

### Analysis target

The analysis is a cylindrical indentation problem, and the geometry of the analysis target is shown in Figure 4.10.1 and the mesh data is shown in Figure 4.10.2.

 | Item              | Description                               | Notes                          | Reference |
 |-------------------|-------------------------------------------|--------------------------------|-----------|
 |Type of analysis   |Non-linear static analysis(elastic,contact)|!SOLUTION,TYPE=NLSTATIC !CONTACT|           |
 |Number of nodes    |4,000                                      |                                |           |
 |Number of elements |2,888                                      |                                |           |
 |Element type       |Eight node hexahedral element              |!ELEMENT,TYPE=361               |           |
 |Material name      |M1                                         |!MATERIAL,NAME=M1               |           |
 |Material property  |ELASTIC                                    |!ELASTIC                        |           |
 |Boundary conditions|Restraint,Forced displacement              |                                |           |
 |Matrix solution    |Direct method                              |!!SOLVER,METHOD=MUMPS           |           |

![Shape of the analysis target](./media/tutorial10_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.10.1: Shape of the analysis target
</div>

![Mesh data of the analysis target](./media/tutorial10_02.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.10.2: Mesh data of the analysis target
</div>

### Analysis content

The Lagrangian multiplier method is used to perform contact analysis to give the forced displacement in the push-in direction to the forced surface shown in Figure 4.10.1. The analytical control data is shown below.

#### Analysis control data `2tubes.cnt`.

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
  X0, 1, 3, 0.0
  Y0, 2, 2, 0.0
  Z0, 3, 3, 0.0
!BOUNDARY, GRPID=2
  X1, 1, 1, 0.0
!BOUNDARY, GRPID=3
  X1, 1, 1, -1.0
!CONTACT_ALGO, TYPE=SLAGRANGE
!CONTACT, GRPID=1, INTERACTION=FSLID, NPENALTY=1.0e+2
  CP1, 0.0, 1.0e+5
### STEP
!STEP, SUBSTEPS=4, CONVERG=1.0e-5
 BOUNDARY, 1
 BOUNDARY, 3
 CONTACT, 1
### Material
!MATERIAL, NAME=M1
!ELASTIC
 2.1e+5, 0.3
### Solver Setting
!SOLVER,METHOD=MUMPS
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
$ cd FrontISTR/tutorial/10_contact_2tubes
$ fistr1 -t 4
(Runs in 4 threads.)
```

### Analysis results

The results of the fourth substep are shown in Figure 4.10.3. A deformation diagram with Mises stress contours is created by REVOCAP_PrePost. A part of the analysis results log file is shown below as numerical data for the analysis results.

![Analysis results of deformation and Mises stress](./media/tutorial10_03.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.10.3: Analysis results of deformation and Mises stress
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


