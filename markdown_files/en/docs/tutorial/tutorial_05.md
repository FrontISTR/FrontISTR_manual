## Non-linear Static Analysis (Elastoplastic, Part 1)

This analysis uses the data of `tutorial/05_plastic_cylinder`.

### Analysis target

The object of analysis is the same round bar 1/8 model as in the [Non-linear Static Analysis (Hyperelasticity, Part 1)](tutorial_03.md).

 | Item             | Description                              | Remarks                   | Refernce |
 |------------------|------------------------------------------|---------------------------|----------|
 |Type of analysis  |Non-linear static analysis (elastoplastic)|!SOLUTION,TYPE=NLSTATIC    |          |
 |Number of nodes   |629                                       |                           |          |
 |Number of elements|432                                       |                           |          |
 |Element type      |Eight node hexahedral element             |!ELEMENT,TYPE=361          |          |
 |Material name     |MAT1                                      |!MATERICAL,NAME=MAT1       |          |
 |Material property |ELASTIC,PLASTIC                           |!ELASTIC !PLASTIC          |          |
 |Boundary condition|Restraint, Force displacement             |                           |          |
 |Matrix solver     |CG/SSOR                                   |!SOLVER,METHOD=CG,PRECOND=1|          |

### Analysis content

The necking phenomenon of a round bar due to plastic deformation is analyzed. The Mises model is used for the yield function. The analytical control data is shown below.

#### Analysis control data `necking.cnt`

```
#  Control File for FISTR
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
 FIX,   3, 3, 0.0
 XSYMM, 1, 1, 0.0
 YSYMM, 2, 2, 0.0
### STEP
!STEP, SUBSTEPS=40, CONVERG=1.0e-3
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
 2000, 1
 1.0e-8, 1.0, 0.0
## Post Control
!VISUAL,method=PSR
!surface_num=1
!surface 1
!output_type=VTK
!END
```

### Analysis procedure

Execute the FrontISTR execution command `fistr1`.

```
$ cd FrontISTR/tutorial/05_plastic_cylinder
$ fistr1 -t 4
(Runs in 4 threads.)
```

### Analysis results

The results of the 35th substep are shown in Figure 4.5.1. A deformation diagram with the Mises stress contours added is created by REVOCAP_PrePost. A part of the analysis results log file is shown below as numerical data for the analysis results.

![Analysis results of deformation and Mises stress](./media/tutorial05_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.5.1: Analysis results of deformation and Mises stress
</div>

#### Log file `0.log`

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

#### Result step=    40
 ##### Local Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    0.0000E+00         1 -3.4606E+00         7
 //U2    0.0000E+00         1 -3.4606E+00        13
 //U3    0.0000E+00         1 -7.0000E+00        38
 //E11  -3.8922E-02        38 -6.4666E-01        14
 //E22  -3.8922E-02        50 -6.4666E-01         6
 //E33   1.2914E+00         1  7.8682E-02        44
 //E12   2.5910E-01        10 -1.1813E-02       387
 //E23   9.7554E-03        91 -1.1753E+00        13
 //E31   9.7554E-03        88 -1.1753E+00         7
 //S11   2.6632E+02         1 -3.6916E+02       192
 //S22   2.6632E+02         1 -3.6916E+02       192
 //S33   1.0471E+03         1 -4.1469E+01       191
 //S12   7.2338E-01        53 -1.3479E+02       387
 //S23   5.9172E+01       191 -2.5727E+02        89
 //S31   5.9172E+01       191 -2.5727E+02        90
 //SMS   7.9063E+02        13  2.4706E+02       190
 ##### Local Summary @Element :Max/IdMax/Min/IdMin####
 //E11  -3.9027E-02       750 -5.5060E-01       345
 //E22  -3.9027E-02       750 -5.5060E-01       345
 //E33   1.1045E+00       345  7.8722E-02       750
 //E12   1.7067E-01       361 -1.6134E-02       414
 //E23  -2.0595E-05       756 -9.6480E-01       363
 //E31  -2.0595E-05       748 -9.6480E-01       354
 //S11   2.6751E+02       345 -3.9312E+02       399
 //S22   2.6751E+02       345 -3.9312E+02       399
 //S33   1.0447E+03       345 -4.7069E+01       426
 //S12   1.4870E+01       361 -1.4324E+02       442
 //S23   4.0405E+01       478 -2.8018E+02       393
 //S31   4.0405E+01       486 -2.8018E+02       380
 //SMS   7.7935E+02       345  2.3268E+02       480
 ##### Global Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    0.0000E+00         1 -3.4606E+00         7
 //U2    0.0000E+00         1 -3.4606E+00        13
 //U3    0.0000E+00         1 -7.0000E+00        38
 //E11  -3.8922E-02        38 -6.4666E-01        14
 //E22  -3.8922E-02        50 -6.4666E-01         6
 //E33   1.2914E+00         1  7.8682E-02        44
 //E12   2.5910E-01        10 -1.1813E-02       387
 //E23   9.7554E-03        91 -1.1753E+00        13
 //E31   9.7554E-03        88 -1.1753E+00         7
 //S11   2.6632E+02         1 -3.6916E+02       192
 //S22   2.6632E+02         1 -3.6916E+02       192
 //S33   1.0471E+03         1 -4.1469E+01       191
 //S12   7.2338E-01        53 -1.3479E+02       387
 //S23   5.9172E+01       191 -2.5727E+02        89
 //S31   5.9172E+01       191 -2.5727E+02        90
 //SMS   7.9063E+02        13  2.4706E+02       190
 ##### Global Summary @Element :Max/IdMax/Min/IdMin####
 //E11  -3.9027E-02       750 -5.5060E-01       345
 //E22  -3.9027E-02       750 -5.5060E-01       345
 //E33   1.1045E+00       345  7.8722E-02       750
 //E12   1.7067E-01       361 -1.6134E-02       414
 //E23  -2.0595E-05       756 -9.6480E-01       363
 //E31  -2.0595E-05       748 -9.6480E-01       354
 //S11   2.6751E+02       345 -3.9312E+02       399
 //S22   2.6751E+02       345 -3.9312E+02       399
 //S33   1.0447E+03       345 -4.7069E+01       426
 //S12   1.4870E+01       361 -1.4324E+02       442
 //S23   4.0405E+01       478 -2.8018E+02       393
 //S31   4.0405E+01       486 -2.8018E+02       380
 //SMS   7.7935E+02       345  2.3268E+02       480
```
</div>


