## Frequency Response Analysis

This analysis uses the data of `tutorial/17_freq_beam`.

### Analysis target

The analysis target is a cantilevered beam, and the geometry is shown in Figure 4.17.1 and the mesh data is shown in Figure 4.17.2.

 | Item              | Description                              | Notes                                     | Reference |
 |-------------------|------------------------------------------|-------------------------------------------|-----------|
 |Type of analysis   |Frequency response analysis               |!SOLUTION,TYPE=EIGEN !SOLUTION,TYPE=DYNAMIC|           |
 |Number of nodes    |55                                        |                                           |           |
 |Number of elements |126                                       |                                           |           |
 |Element type       |Four node tetrahedral element             |!ELEMENT,TYPE=341                          |           |
 |Material name      |Material-1                                |!MATERIAL,NAME=Material-1                  |           |
 |Boundary conditions|Restraint, Concentrated force, eigen value|!EIGENREAD                                 |           |
 |Matrix solution    |CG/SSOR                                   |!SOLVER,METHOD=CG,PRECOND=1                |           |

![Shape of the cantilever](./media/tutorial17_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.17.1 : Shape of the cantilever
</div>

![Mesh data of the cantilever](./media/tutorial17_02.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.17.2 : Mesh data of the cantilever
</div>

### Analysis content

The end of a cantilevered beam to be analyzed is fully constrained, and a frequency response analysis is performed by applying concentrated loads to two nodes at the opposite end.

After analyzing eigenvalues up to the 10th order under the same boundary conditions, the analysis is performed using eigenvalues and eigenvectors up to the 5th order. The analysis control data for frequency response analysis is shown below.

#### Analysis control data `beam_eigen.cnt`.

```
#  Control File for FISTR
!VERSION
 3
!WRITE,RESULT
!WRITE,VISUAL
!SOLUTION, TYPE=EIGEN
!EIGEN
 10, 1.0E-8, 60
!BOUNDARY
_PickedSet4, 1, 3, 0.0
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=NO,TIMELOG=YES
 10000, 1
 1.0e-8, 1.0, 0.0
!VISUAL,metod=PSR
!surface_num=1
!surface 1
!output_type=VTK
!END
```

#### Analysis control data `beam_freq.cnt`.

```
#  Control File for FISTR
!VERSION
 3
!WRITE,RESULT
!WRITE,VISUAL
!SOLUTION, TYPE=DYNAMIC
!DYNAMIC
 11 , 2
 14000, 16000, 20, 15000.0
 0.0, 6.6e-5
 1, 1, 0.0, 7.2E-7
 10, 2, 1
 1, 1, 1, 1, 1, 1
!EIGENREAD
 eigen_0.log
 1, 5
!BOUNDARY
_PickedSet4, 1, 3, 0.0
!FLOAD, LOAD CASE=2
_PickedSet5, 2, 1.
!FLOAD, LOAD CASE=2
_PickedSet6, 2, 1.
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=NO,TIMELOG=YES
 10000, 1
 1.0e-8, 1.0, 0.0
!VISUAL,metod=PSR
!surface_num=1
!surface 1
!output_type=VTK
!END
```

### Analysis procedure

First, change `hecmw_ctrl_eigen.dat` to `hecmw_ctrl.dat` for eigenvalue analysis, and then run eigenvalue analysis.

Next, change `hecmw_ctrl_freq.dat` to `hecmw_ctrl.dat` and `0.log` to `eigen_0.log` (which is specified in the control data for frequency response analysis), and then perform the frequency response analysis.

```
$ cp hecmw_ctrl_eigen.dat hecmw_ctrl.dat
$ fistr1 -t 4
$ mv 0.log eigen_0.log
$ cp hecmw_ctrl_freq.dat hecmw_ctrl.dat
$ fistr1 -t 4
```

### Analysis results

The relationship between the frequency and displacement amplitude of a monitoring node (node number 1) specified in the analysis control data is shown in Figure 4.17.3, created using Microsoft Excel. A part of the analysis result log file is shown below as numerical data for the analysis results.

![Relationship between frequency and displacement amplitude of the monitoring nodes](./media/tutorial17_03.png){.center width="350px"}
<div style="text-align: center;">
Fig.4.17.3 Relationship between frequency and displacement amplitude of the monitoring nodes
</div>

#### Analysis result log `0.log`

```
 fstr_setup: OK
 Rayleigh alpha:   0.0000000000000000
 Rayleigh beta:   7.1999999999999999E-007
 read from=eigen_0.log
 start mode=           1
 end mode=           5
 start frequency:   14000.000000000000
 end frequency:   16000.000000000000
 number of the sampling points          20
 monitor nodeid=           1
   14100.000000000000      [Hz] :    8.3935554530220141E-002
   14100.000000000000      [Hz] :            1 .res
   14200.000000000000      [Hz] :    9.1211083510158913E-002
   14200.000000000000      [Hz] :            2 .res
   14300.000000000000      [Hz] :    9.9579777897537178E-002
   14300.000000000000      [Hz] :            3 .res
   14400.000000000000      [Hz] :   0.10914967595035865
   14400.000000000000      [Hz] :            4 .res
   14500.000000000000      [Hz] :   0.11992223203402431
   14500.000000000000      [Hz] :            5 .res
```


