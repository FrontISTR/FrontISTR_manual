## Static Analysis (Hyperelasticity, Part 1)

This analysis uses the data of `tutorial/03_hyperelastic_cylinder`.

### Analysis target

The target of this analysis is a 1/8 model of a round bar whose shape and mesh data are shown in Figs. 4.3.1 and 4.3.2, respectively. The mesh is a hexahedral primary element with 432 elements and 629 nodes.

![Shape of the round bar (1/8 model)](./media/tutorial03_01.png){: .center width="350px"}
<div style="text-align: center;">
Fig. 4.3.1 : Shape of the round bar (1/8 model)
</div>

![Shape of the round bar (1/8 model)](./media/tutorial03_02.png){: .center width="350px"}
<div style="text-align: center;">
Fig. 4.3.2: Shape of the round bar (1/8 model)
</div>

### Analysis content

In this stress analysis, an axial tensile displacement is given to a round bar. The Mooney–Rivlin model was used in the material constitutive equation of hyperelasticity. The analysis control data are presented below.

```
# Control File for FISTR
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
  FIX, 3, 3, 0.0
  XSYMM, 1, 1, 0.0
  YSYMM, 2, 2, 0.0
### STEP
!STEP, SUBSTEPS=5, CONVERG=1.0e-5
  BOUNDARY, 1
### Material
!MATERIAL, NAME=MAT1
!HYPERELASTIC, TYPE=MOONEY-RIVLIN
  0.1486, 0.4849, 0.0789
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=YES,TIMELOG=YES
  10000, 2
  1.0e-8, 1.0, 0.0
```

### Analysis results

The analysis results of the fifth sub-step are shown in Fig. 4.3.3 as a deformation diagram with a Mises stress contour created with REVOCAP_PrePost. Furthermore, a part of the log files of the analysis results is shown below as numerical data of the analysis.

![Analysis results of deformation and Mises stress](./media/tutorial03_03.png){: .center width="350px"}
<div style="text-align: center;">
Fig. 4.3.3: Analysis results of deformation and Mises stress
</div>

```
#### Result step=     5
 ##### Local Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    0.0000E+00         1 -6.7545E-01         7
 //U2    0.0000E+00         1 -6.7545E-01        13
 //U3    0.0000E+00         1 -7.0000E+00        38
 //E11  -9.6951E-02        38 -1.0235E-01         7
 //E22  -9.6951E-02        50 -1.0235E-01        13
 //E33   3.0654E-01        13  2.8765E-01        50
 //E12   6.9286E-04        53 -7.0533E-04        10
 //E23   5.2256E-08        39 -3.2649E-03        86
 //E31   5.2256E-08        49 -3.2649E-03        93
 //S11   6.0251E-03        38 -6.6494E-03         7
 //S22   6.0251E-03        50 -6.6495E-03        13
 //S33   5.3529E-01        35  5.2006E-01        72
 //S12   1.5458E-03        53 -1.6315E-03        10
 //S23   1.5325E-07        38 -2.1554E-03        86
 //S31   1.5325E-07        50 -2.1554E-03        93
 //SMS   5.3730E-01        10  5.1836E-01        53
```


