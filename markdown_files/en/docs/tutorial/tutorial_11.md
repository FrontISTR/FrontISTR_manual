## Contact Analysis (Part 3)

This analysis uses the data of `tutorial/11_contact_2beam`.

### Analysis target

The analysis is a contact problem between two beams, and an overview of the analytical model is shown in Figure 4.11.1.

 | Item              | Description                                     | Notes                          | Reference |
 |-------------------|-------------------------------------------------|--------------------------------|-----------|
 |Type of analysis   |Non-linear static analysis(elastoplastic,contact)|!SOLUTION,TYPE=NLSTATIC !CONTACT|           |
 |Number of nodes    |252                                              |                                |           |
 |Number of elements |80                                               |                                |           |
 |Element type       |Eight node hexahedral element                    |!ELEMENT,TYPE=361               |           |
 |Material name      |M1                                               |!MATERIAL,NAME=M1               |           |
 |Material property  |ELASTIC,PLASTIC                                  |!ELASTIC !PLASTIC               |           |
 |Boundary conditions|Restraint,Force displacement                     |                                |           |
 |Matrix solution    |Direct method                                    |!SOLVER,METHOD=MUMPS            |           |

![Outline of Analysis Model](./media/tutorial11_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.11.1 Outline of Analysis Model
</div>

### Analysis contents

The Lagrangian multiplier method is used to perform a contact analysis to give a forced displacement to the top surface of the upper beam. The analysis control data is shown below.

#### Analysis control data `2beams.cnt`.

```
!!
!! Control File for FISTR
!!
!VERSION
 3
!SOLUTION, TYPE=NLSTATIC
!WRITE,RESULT
!WRITE,VISUAL
!BOUNDARY, GRPID=1
  ng1, 1, 3, 0.0
  ng2, 1, 3, 0.0
  ng3, 3, 3, -3.0
!CONTACT_ALGO, TYPE=SLAGRANGE
!CONTACT, GRPID=1, INTERACTION=FSLID
  CP1, 0.0, 1.0e+5
!STEP, SUBSTEPS=100, CONVERG=1.0e-4, MAXITER=1000
 BOUNDARY, 1
 CONTACT, 1
!MATERIAL, NAME=M1
!ELASTIC
 2.1e+5, 0.3
!PLASTIC,YIELD=MISES
 500.0, 10.0
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
$ cd FrontISTR/tutorial/11_contact_2beam
$ fistr1 -t 4
(Runs in 4 threads.)
```

### Analysis results

The results of the 100th substep are shown in Figure 4.11.2. A deformation diagram with the Mises stress contours added is created by REVOCAP_PrePost. A part of the analysis results log file is shown below as numerical data for the analysis results.

![Analysis results of deformation and Mises stress](./media/tutorial11_02.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.11.2: Analysis results of deformation and Mises stress
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


