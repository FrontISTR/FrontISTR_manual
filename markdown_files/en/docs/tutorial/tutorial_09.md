## Contact Analysis (Part 1)

Data of `tutorial/09_contact_hertz/` is used to implement this analysis.

### Analysis Object

The Hertz contact problem was applied in this analysis. The shape of the analysis object is shown in Figure 4.9.1, and the mesh data is shown in Figure 4.9.2. Hexahedral linear elements are used for the mesh, and the scale of the mesh consists of 168 elements and 408 nodes.

<div style="text-align: center;">
<img src="./media/tutorial09_01.png" width="350px"><br>
Figure 4.9.1: Shape of Analysis Object
</div>

<div style="text-align: center;">
<img src="./media/tutorial09_02.png" width="350px"><br>
Figure 4.9.2: Mesh Data of Analysis Object
</div>

### Analysis Content

An extended Lagrange multiplier method is used to implement the contact analysis where forced displacement is applied to the upper surface of a 1/4 model disc in the compression direction. The analysis control data is shown in the following.

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
  ALL, 3, 3, 0.0
  BOTTOM, 2, 2, 0.0
  CENTER, 1, 1, 0.0
  UPPER, 2, 2, -0.306
!CONTACT_ALGO, TYPE=ALAGRANGE
!CONTACT, GRPID=1
  CP1, 0.0
### STEP
!STEP, SUBSTEPS=5, CONVERG=1.0e-5
  BOUNDARY, 1
  CONTACT, 1
```

### Analysis Results

As analysis results of the 5th sub step, a deformed figure applied with a contour of the displacement in the y direction was created by REVOCAP\_PrePost, and is shown in Figure 4.9.3. Moreover, a portion of the analysis results log file is shown in the following as numeric
data of the analysis results.

<div style="text-align: center;">
<img src="./media/tutorial09_03.png" width="350px"><br>
Figure 4.9.3: Analysis Results of Deformation and y Direction Displacement
</div>

