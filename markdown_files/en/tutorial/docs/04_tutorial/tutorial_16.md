## Heat Conduction Analysis

Data of `tutorial/16_heat_block/` is used to implement this analysis.

### Analysis Object

A block with a hole is the object of the analysis. The shape is shown in Figure 4.16.1, and the mesh data is shown in Figure 4.16.2. Hexahedral linear elements are used for the mesh, and the scale of the mesh consists of 32,160 elements and 37,386 nodes.

<div style="text-align: center;">
<img src="../media/image16_01.png" width="350px"><br>
Figure 4.16.1: Shape of Block with Hole
</div>

<div style="text-align: center;">
<img src="../media/image16_02.png" width="350px"><br>
Figure 4.16.2: Mesh Data of Block with Hole
</div>

### Analysis Content

A steady heat conduction analysis is implemented, where a heat source is applied to the cylindrical inner surface of the analysis object. The analysis control data is shown in the following.

```
#  Control File for FISTR
## Analysis Control
!VERSION
 3
!SOLUTION, TYPE=HEAT
!HEAT
 0.0
!WRITE,RESULT
!WRITE,VISUAL
## Solver Control
### Boundary Conditon
!FIXTEMP
 FTMPC,  100.0
 FTMPS1, 20.0
 FTMPS2, 20.0
 FTMPS3, 20.0
 FTMPS4, 20.0
### Material
# define in mesh file
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=YES,TIMELOG=YES
 100, 1
 1.0e-8, 1.0, 0.0
```

### Analysis Results

A temperature contour figure was created by REVOCAP\_PrePost, and is shown in Figure 4.16.3. Moreover, a portion of the analysis results log file is shown in the following as numeric
data of the analysis results.

<div style="text-align: center;">
<img src="../media/image16_03.png" width="350px"><br>
Figure 4.16.3: Temperature Analysis Results
</div>

```
 ISTEP =     1
 Time  =     0.000
 Maximum Temperature :   100.000
 Maximum Node No.    :         9
 Minimum Temperature :    20.000
 Minimum Node No.    :        85
```
