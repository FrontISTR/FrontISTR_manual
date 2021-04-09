## Non-Linear Contact Dynamic Analysis

This analysis uses the data of `tutorial/14_dynamic_plate_contact`.

### Analysis target

The object of the analysis was the fall impact analysis of a square material on a floor surface, and the geometry is shown in Fig. 4.14.1 and the mesh data is shown in Fig. 4.14.2.

 | Item              | Description                      | Notes                                                 | Reference |
 |-------------------|----------------------------------|-------------------------------------------------------|-----------| 
 |Type of analysis   |Nonlinear contact dynamic analysis|!SOLUTION,TYPE=DYNAMIC !DYNAMIC,TYPE=NONLINEAR !CONTACT|           |
 |Number of nodes    |10,712                            |
 |Number of elements |8,232                             |
 |Element type       |Eight node hexahedral element     |!ELEMENT,TYPE=361
 |Material name      |M1, M2                            |!MATERIAL,NAME=M1 !MATERIAL,NAME=M2
 |Material property  |ELASTIC, PLASTIC                  |!ELASTIC !PLASTIC
 |Boundary conditions|Restraint, Initial velocity       |!VELOCITY,TYPE=INITIAL
 |Matrix solution    |Direct method                     |!SOLVER,METHOD=MUMPS

![Shape of the floor surface and square material](./media/tutorial14_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.14.1: Shape of the floor surface and square material
</div>

![Mesh data of the floor surface and square material](./media/tutorial14_02.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.14.2: Mesh data of the floor surface and square material
</div>

### Analysis content

The initial speed of 4427 mm/s is set for the square material to be analyzed, and the contact motion analysis is performed. The analysis control data is shown below.

#### Analysis control data `plateToGround.cnt`.

```
!!
!! Control File for FISTR
!!
!VERSION
 3
!WRITE,LOG,FREQUENCY=10
!WRITE,RESULT,FREQUENCY=10
!SOLUTION, TYPE=DYNAMIC
!DYNAMIC, TYPE=NONLINEAR
 1 , 1
 0.0, 1.0, 200, 1.0000e-8
 0.65, 0.330625
 1, 1, 0.0, 0.0
 20, 2621, 1
 1, 1, 1, 1, 1, 1
!BOUNDARY, GRPID = 1
  bottom, 1, 3, 0.0
!VELOCITY, TYPE = INITIAL
  plate, 3, 3, -4427.0
!CONTACT_ALGO, TYPE=SLAGRANGE
!CONTACT, GRPID=1, INTERACTION=FSLID
  CP1, 0.0, 1.0e+5
!STEP, CONVERG=1.0e-8, ITMAX=100
 BOUNDARY, 1
 CONTACT, 1
!MATERIAL, NAME = M1
!ELASTIC
2.00000e+5, 0.3
!PLASTIC
 1.0e+8, 0.0
!MATERIAL, NAME = M2
!ELASTIC
 1.16992e+5, 0.3
!PLASTIC
 70.0, 0.0
!SOLVER,METHOD=MUMPS
!END
```

### Analysis Results

A contour diagram of the Mises stresses during the fall impact is shown in Figure 4.14.3. In addition, a portion of the energy output file (dyna_energy.txt) for the monitoring nodes is shown below as numerical data for the analysis results.

![ Mises stress of the falling impact](./media/tutorial14_03.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.14.3: Mises stress of the falling impact
</div>

#### Displacement of monitoring nodes `dyna_energy.txt`.

```
  time step     time      kinetic energy   strain energy   total energy
         0  0.0000E+000     9.7816E-003     0.0000E+000     9.7816E-003
         1  1.0000E-008     9.7756E-003     4.9470E-006     9.7806E-003
         2  2.0000E-008     9.7654E-003     1.4636E-005     9.7800E-003
         3  3.0000E-008     9.7566E-003     2.2609E-005     9.7792E-003
         4  4.0000E-008     9.7505E-003     3.7965E-005     9.7884E-003
         5  5.0000E-008     9.7425E-003     6.4932E-005     9.8074E-003
         6  6.0000E-008     9.7214E-003     8.4571E-005     9.8060E-003
         7  7.0000E-008     9.7139E-003     9.0613E-005     9.8045E-003
         8  8.0000E-008     9.7184E-003     1.0958E-004     9.8280E-003
         9  9.0000E-008     9.7175E-003     1.5717E-004     9.8747E-003
        10  1.0000E-007     9.6909E-003     1.7998E-004     9.8709E-003
        11  1.1000E-007     9.6917E-003     1.9733E-004     9.8890E-003
        12  1.2000E-007     9.7137E-003     2.2403E-004     9.9377E-003
        13  1.3000E-007     9.6813E-003     2.4397E-004     9.9253E-003
```

