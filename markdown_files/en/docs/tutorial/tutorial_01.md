## Static Analysis (Elasticity)

Data of `tutorial/01_elastic_hinge/` is used for the implementation of this analysis.

### Analysis Object

A hinge component is the object of the analysis. The shape is shown in Figure 4.1.1, and the mesh data is shown in Figure 4.1.2. Quadratic tetrahedral elements are used for the mesh,and the scale of the mesh consists of 49,871 elements and 84,056 nodes.

<div style="text-align: center;">
<img src="./media/tutorial01_01.png" width="350px"><br>
Figure 4.1.1 : Shape of Hinge Component
</div>

<div style="text-align: center;">
<img src="./media/tutorial01_02.png" width="350px"><br>
Figure 4.1.2 : Mesh Data of Hinge Component
</div>

### Analysis Contents

A stress analysis is implemented, where the displacement of the restrained surface shown in Figure 4.1.1 is restrained, and a concentrated load is applied to the forced surface. The analysis control data is shown in the following.

```
# Control File for FISTR
## Analysis Control
!VERSION
                  3
!SOLUTION, TYPE=STATIC
!WRITE,RESULT
!WRITE,VISUAL
## Solver Control
### Boundary Conditon
!BOUNDARY
  BND0, 1, 3, 0.000000
!BOUNDARY
  BND1, 1, 3, 0.000000
!CLOAD
  CL0, 1, 1.00000
### Material
!MATERIAL, NAME=STEEL
!ELASTIC
  210000.0, 0.3
!DENSITY
  7.85e-6
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=YES,TIMELOG=YES
  10000, 2
  1.0e-8, 1.0, 0.0
```

### Analysis Results

A contour figure of the Mises stress was created by REVOCAP_PrePost, and is shown in Figure 4.1.3. Moreober, a portion of the analysis results log file is shown in the following as numeric data of the analysis results.

<div style="text-align: center;">
<img src="./media/tutorial01_03.png" width="350px"><br>
Figure 4.1.3 : Analysis Results of Mises Stress
</div>

```
#### Result step=     1
 ##### Local Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    3.9115E+00     82452 -7.1083E-02     65233
 //U2    7.4504E-03       354 -5.8813E-02       696
 //U3    5.9493E-02        84 -5.8751E-01     61080
 //E11   1.3777E-01       130 -1.3653E-01     77625
 //E22   4.9199E-02        61 -5.4370E-02       102
 //E33   6.8634E-02     51036 -6.1176E-02     30070
 //E12   7.1556E-02     27808 -6.8093E-02     27863
 //E23   5.3666E-02        56 -5.4347E-02        82
 //E31   7.2396E-02     36168 -9.6621E-02       130
 //S11   3.8626E+04       130 -3.6387E+04     28580
 //S22   1.6628E+04       130 -1.5743E+04     28580
 //S33   1.6502E+04     30033 -1.5643E+04     28580
 //S12   5.7795E+03     27808 -5.4998E+03     27863
 //S23   4.3345E+03        56 -4.3896E+03        82
 //S31   5.8474E+03     36168 -7.8040E+03       130
 //SMS   2.8195E+04     77625  1.2755E+00     75112
```

