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

#### Result step=    10
 ##### Local Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    0.0000E+00         1 -7.4530E-01        91
 //U2    0.0000E+00         1 -7.4530E-01        88
 //U3    0.0000E+00         1 -7.0000E+00        38
 //E11  -1.2136E-01        38 -1.2719E-01         7
 //E22  -1.2136E-01        50 -1.2719E-01        13
 //E33   2.3670E-01         7  2.2951E-01        50
 //E12   1.2005E-03        53 -1.2295E-03        10
 //E23   1.2987E-04        72 -2.5210E-03        83
 //E31   1.2987E-04        64 -2.5210E-03        96
 //S11   1.3771E+02        13 -1.3366E+02        50
 //S22   1.3771E+02         7 -1.3366E+02        38
 //S33   6.3193E+04         7  5.9532E+04        50
 //S12   3.5416E+01        53 -3.5955E+01        10
 //S23   1.0704E+01        35 -2.1669E+02        83
 //S31   1.0704E+01        31 -2.1669E+02        96
 //SMS   6.3093E+04         7  5.9628E+04        50
 ##### Local Summary @Element :Max/IdMax/Min/IdMin####
 //E11  -1.2167E-01       759 -1.2687E-01       354
 //E22  -1.2167E-01       768 -1.2687E-01       363
 //E33   2.3619E-01       354  2.3001E-01       768
 //E12   1.1247E-03       765 -1.1492E-03       360
 //E23  -8.9560E-06       758 -2.4072E-03       552
 //E31  -8.9560E-06       771 -2.4072E-03       543
 //S11   1.0437E+02       363 -1.0216E+02       768
 //S22   1.0437E+02       354 -1.0216E+02       759
 //S33   6.2914E+04       354  5.9795E+04       768
 //S12   3.3111E+01       765 -3.3459E+01       360
 //S23  -7.6469E-01       758 -2.0669E+02       552
 //S31  -7.6469E-01       771 -2.0669E+02       543
 //SMS   6.2843E+04       354  5.9864E+04       768
 ##### Global Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    0.0000E+00         1 -7.4530E-01        91
 //U2    0.0000E+00         1 -7.4530E-01        88
 //U3    0.0000E+00         1 -7.0000E+00        38
 //E11  -1.2136E-01        38 -1.2719E-01         7
 //E22  -1.2136E-01        50 -1.2719E-01        13
 //E33   2.3670E-01         7  2.2951E-01        50
 //E12   1.2005E-03        53 -1.2295E-03        10
 //E23   1.2987E-04        72 -2.5210E-03        83
 //E31   1.2987E-04        64 -2.5210E-03        96
 //S11   1.3771E+02        13 -1.3366E+02        50
 //S22   1.3771E+02         7 -1.3366E+02        38
 //S33   6.3193E+04         7  5.9532E+04        50
 //S12   3.5416E+01        53 -3.5955E+01        10
 //S23   1.0704E+01        35 -2.1669E+02        83
 //S31   1.0704E+01        31 -2.1669E+02        96
 //SMS   6.3093E+04         7  5.9628E+04        50
 ##### Global Summary @Element :Max/IdMax/Min/IdMin####
 //E11  -1.2167E-01       759 -1.2687E-01       354
 //E22  -1.2167E-01       768 -1.2687E-01       363
 //E33   2.3619E-01       354  2.3001E-01       768
 //E12   1.1247E-03       765 -1.1492E-03       360
 //E23  -8.9560E-06       758 -2.4072E-03       552
 //E31  -8.9560E-06       771 -2.4072E-03       543
 //S11   1.0437E+02       363 -1.0216E+02       768
 //S22   1.0437E+02       354 -1.0216E+02       759
 //S33   6.2914E+04       354  5.9795E+04       768
 //S12   3.3111E+01       765 -3.3459E+01       360
 //S23  -7.6469E-01       758 -2.0669E+02       552
 //S31  -7.6469E-01       771 -2.0669E+02       543
 //SMS   6.2843E+04       354  5.9864E+04       768
```
</div>


