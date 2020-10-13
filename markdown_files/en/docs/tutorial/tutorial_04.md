## Non-linear Static Analysis (Hyperelasticity, Part 2)

This analysis uses the data of `tutorial/04_hyperelastic_spring`.

### Analysis target

The spring is the object of the analysis, the geometry is shown in Figure 4.4.1 and the mesh data is shown in Figure 4.4.2.

 |Item               |Description                           |Notes                          |Reference |
 |-------------------|--------------------------------------|-------------------------------|----------|
 |Typo of analysis   |Non-linear static analysis            |!SOLUTION,TYPE=NLSTATIC        |          |
 |Number of nodes    |78,771                                |                               |          |
 |Number of elements |46,454                                |                               |          |
 |Element type       |Ten node tetrahedral quadratic element|!ELEMENT,TYPE=342              |          |
 |Material name      |MAT1                                  |!MATERIAL,NAME=MAT1            |          |
 |Material property  |HYPERELASTIC                          |!HYPERELASTIC,TYPE=ARRUDA-BOYCE|          |
 |Boundary conditions|Restraint, Concentrated force         |                               |          |
 |Matrix solution    |CG/SSOR                               |!SOLVER,METHOD=CG,PRECOND=1    |          |

![Shape of the spring](./media/tutorial04_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.4.1: Shape of the spring
</div>

![Mesh data of the spring](./media/tutorial04_02.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.4.2: Mesh data of the spring
</div>

### Analysis content

In this stress analysis, the displacement of the constrained surface shown in Fig. 4.4.1 is restrained, and the displacement is given to the forced surface. The Arruda–Boyce model was used in the material constitutive equation of hyperelasticity. The analysis control data are presented below.

#### Analysis control data `spring.cnt`

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
 LOADS, 2, 2, -5.0
 FIX,   1, 3, 0.0
### STEP
!STEP, SUBSTEPS=1, CONVERG=1.0e-5
 BOUNDARY, 1
### Material
!MATERIAL, NAME=MAT1
!HYPERELASTIC, TYPE=ARRUDA-BOYCE
 0.71, 1.7029, 0.1408
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
$ cd FrontISTR/tutorial/04_hyperelastic_spring
$ fistr1 -t 4
(Runs in 4 threads.)
```

### Analysis results

A deformation diagram with a contoured displacement is created by REVOCAP_PrePost and shown in Figure 4.4.3. A part of the log file is shown below as numerical data for the analysis results.

![Analysis results of deformation and displacement](./media/tutorial04_03.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.4.3: Analysis results of deformation and displacement
</div>

#### Analysis results log `0.log`

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

