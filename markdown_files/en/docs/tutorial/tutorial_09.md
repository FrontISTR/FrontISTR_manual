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

#### Log file `0.log`.

<div style="height: 400px; overflow-y: scroll;">
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
 ##### Global Summary @Node    :Max/IdMax/Min/IdMin####
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
 ##### Global Summary @Element :Max/IdMax/Min/IdMin####
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

 ...

#### Result step=     5
 ##### Local Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    1.3079E-02        31 -4.1442E-02        54
 //U2    4.9597E-03      1008 -3.0604E-01        69
 //U3    0.0000E+00         1  0.0000E+00         1
 //E11   7.1171E-03      1049 -4.7627E-02         1
 //E22   2.0644E-03      1012 -5.3428E-02        50
 //E33   9.3301E-03        50 -4.0103E-03        54
 //E12   4.3231E-02      1000 -2.7666E-02        54
 //E23   1.3028E-12      1046 -1.2515E-12         2
 //E31   3.5660E-13        48 -2.1028E-12        51
 //S11   7.9455E+00      1049 -4.9987E+01         1
 //S22   2.2819E+00      1012 -5.3282E+01        50
 //S33   1.1359E+01        50 -4.4937E+00        54
 //S12   2.0802E+01      1000 -1.4668E+01        54
 //S23   6.7682E-10      1046 -6.3666E-10         2
 //S31   2.0235E-10        48 -1.1497E-09        51
 //SMS   6.0944E+01      1000  1.0198E-01        69
 ##### Local Summary @Element :Max/IdMax/Min/IdMin####
 //E11   4.6311E-03      1024 -3.5443E-02         8
 //E22   1.7091E-03      1031 -5.4262E-02         8
 //E33   1.5903E-04         7 -1.6631E-05       101
 //E12   1.8590E-02      1009 -2.6073E-02        14
 //E23   1.5204E-13      1000 -4.1521E-13        16
 //E31   1.3902E-13         5 -8.2391E-13         7
 //S11   5.2516E+00      1024 -3.8099E+01         8
 //S22   1.8872E+00      1031 -5.5262E+01         8
 //S33   2.2824E-01         7 -1.8263E-02       101
 //S12   9.8516E+00      1009 -1.3352E+01        14
 //S23   7.8767E-11      1000 -2.1075E-10        16
 //S31   7.7553E-11         5 -4.4780E-10         7
 //SMS   4.9470E+01         8  2.4786E-01      1007
 ##### Global Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    1.3079E-02        31 -4.1442E-02        54
 //U2    4.9597E-03      1008 -3.0604E-01        69
 //U3    0.0000E+00         1  0.0000E+00         1
 //E11   7.1171E-03      1049 -4.7627E-02         1
 //E22   2.0644E-03      1012 -5.3428E-02        50
 //E33   9.3301E-03        50 -4.0103E-03        54
 //E12   4.3231E-02      1000 -2.7666E-02        54
 //E23   1.3028E-12      1046 -1.2515E-12         2
 //E31   3.5660E-13        48 -2.1028E-12        51
 //S11   7.9455E+00      1049 -4.9987E+01         1
 //S22   2.2819E+00      1012 -5.3282E+01        50
 //S33   1.1359E+01        50 -4.4937E+00        54
 //S12   2.0802E+01      1000 -1.4668E+01        54
 //S23   6.7682E-10      1046 -6.3666E-10         2
 //S31   2.0235E-10        48 -1.1497E-09        51
 //SMS   6.0944E+01      1000  1.0198E-01        69
 ##### Global Summary @Element :Max/IdMax/Min/IdMin####
 //E11   4.6311E-03      1024 -3.5443E-02         8
 //E22   1.7091E-03      1031 -5.4262E-02         8
 //E33   1.5903E-04         7 -1.6631E-05       101
 //E12   1.8590E-02      1009 -2.6073E-02        14
 //E23   1.5204E-13      1000 -4.1521E-13        16
 //E31   1.3902E-13         5 -8.2391E-13         7
 //S11   5.2516E+00      1024 -3.8099E+01         8
 //S22   1.8872E+00      1031 -5.5262E+01         8
 //S33   2.2824E-01         7 -1.8263E-02       101
 //S12   9.8516E+00      1009 -1.3352E+01        14
 //S23   7.8767E-11      1000 -2.1075E-10        16
 //S31   7.7553E-11         5 -4.4780E-10         7
 //SMS   4.9470E+01         8  2.4786E-01      1007
```
</div>

