
## Static Analysis (Hyperelasticity, Part 2)

This analysis uses the data of `tutorial/04_hyperelastic_spring`.

### Analysis target

The target of this analysis is a spring whose shape and mesh data are shown in Figs. 4.4.1 and 4.4.2, respectively. The mesh is a tetrahedral secondary element with 46454 elements and 78771 nodes.

<div style="text-align: center;">
<img src="./media/tutorial04_01.png" width="350px"><br>
Fig. 4.4.1: Shape of the spring
</div>

<div style="text-align: center;">
<img src="./media/tutorial04_02.png" width="350px"><br>
Fig. 4.4.2: Mesh data of the spring
</div>

### Analysis content

In this stress analysis, the displacement of the constrained surface shown in Fig. 4.4.1 is restrained, and the displacement is given to the forced surface. The Arruda–Boyce model was used in the material constitutive equation of hyperelasticity. The analysis control data are presented below.

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
  LOADS, 2, 2, -5.0
  FIX, 1, 3, 0.0
### STEP
!STEP, SUBSTEPS=1, CONVERG=1.0e-5
  BOUNDARY, 1
### Material
!MATERIAL, NAME=MAT1
!HYPERELASTIC, TYPE=ARRUDA-BOYCE
  0.71, 1.7029, 0.1408
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=YES,TIMELOG=YES
  10000, 2
  1.0e-8, 1.0, 0.0
```

### Analysis results

A deformation diagram with a displacement contour created with REVOCAP_PrePost is shown in Fig. 4.4.3. Furthermore, a part of the log files of the analysis results is shown below as numerical data of the analysis.

<div style="text-align: center;">
<img src="./media/tutorial04_03.png" width="350px"><br>
Fig. 4.4.3: Analysis results of deformation and displacement
</div>

```
#### Result step= 1
 ##### Local Summary :Max/IdMax/Min/IdMin####
   //U1   2.8588E-01     42179 -2.6512E-01     22274
   //U2   2.2657E-02      6381 -5.0291E+00     22825
   //U3   7.4573E-02      7058 -9.5095E-01     48324
   //E11  4.8291E-03      2851 -4.2788E-03      3429
   //E22  2.4161E-03     55960 -1.4539E-03     44761
   //E33  5.3256E-03     25260 -4.6858E-03     27938
   //E12  1.3574E-02     56003 -1.3081E-02     45120
   //E23  2.8679E-02     48353 -1.8970E-02     48322
   //E13  1.0897E-02     47938 -9.1054E-03     27344
   //S11  5.1605E-02      2814 -5.0895E-03     10408
   //S22  5.0635E-02     55965 -3.6174E-03     45307
   //S33  4.9662E-02     39836 -5.1017E-03      4949
   //S12  1.2059E-02     56003 -1.1865E-02     45120
   //S23  2.6123E-02     48353 -1.7281E-02     56868
   //S13  1.0133E-02     47938 -8.2330E-03     27344
   //SMS  4.9365E-02     48353 3.2148E-04      64553
```

