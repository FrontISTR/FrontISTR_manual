## Non-Linear Dynamic Analysis

This analysis uses the data of `tutorial/13_dynamic_beam_nonlinear`.

### Analysis target

The target of the analysis is the same cantilevered beam as the [Linear Dynamic Analysis](tutorial_12.md) in the previous section.

 | Item              | Description                          | Notes                                        | Reference |
 |-------------------|--------------------------------------|----------------------------------------------|-----------|
 |Type of analysis   |Nonlinear dynamic analysis            |!SOLUTION,TYPE=DYNAMIC !DYNAMIC,TYPE=NONLINEAR|           |
 |Number of nodes    |525                                   |                                              |           |
 |Number of elements |240                                   |                                              |           |
 |Element type       |Ten node tetrahedral quadratic element|!ELEMENT,TYPE=342                             |           |
 |Material name      |M1                                    |!MATERIAL,NAME=M1                             |           |
 |Boundary conditions|Restraint,Concentrated force          |!CLOAD                                        |           |
 |Matrix solution    |CG/SSOR                               |!SOLVER,METHOD=CG,PRECOND=1                   |           |

### Analysis content

A nonlinear dynamic analysis is performed after the displacement of the constrained surface shown in Figure 4.12.1 is constrained and a concentrated load is applied to the load nodes. The analytical control data are shown below.

#### Analysis control data `beam.cnt`.

```
#  Control File for FISTR
## Analysis Control
!VERSION
 3
!WRITE,RESULT,FREQUENCY=100
!SOLUTION, TYPE=DYNAMIC
!DYNAMIC, TYPE=NONLINEAR
 1 , 1
 0.0, 0.1, 100000, 1.0000e-8
 0.5, 0.25
 1, 1, 0.0, 0.0
 1000, 3121, 100
 1, 1, 1, 1, 1, 1
## Solver Control
### Boundary Conditon
!BOUNDARY, GRPID=1, AMP=AMP1
 FIX, 1, 3, 0.0
!CLOAD, GRPID=1, AMP=AMP1
 CL1,    3,    -1.0
### STEP
!STEP, CONVERG=1.0e-3
 BOUNDARY, 1
 LOAD,     1
### Material
!DENSITY
 1.0e-8
!HYPERELASTIC, TYPE=NEOHOOKE
 1000.0, 0.00005
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=NO,TIMELOG=NO
 10000, 1
 1.0e-06, 1.0, 0.0
!END
```

### Analysis procedure

Execute the FrontISTR execution command `fistr1`.

```
$ cd FrontISTR/tutorial/13_dynamic_beam_nonlinear
$ fistr1 -t 4
(Runs in 4 threads.)
```

### Analysis results

A time series of the displacement of a monitoring node (load node, node number 3121) specified in the analysis control data is shown in Figure 4.13.1, created by Microsoft Excel. A part of the monitoring node displacement output file (dyna_disp_3121.txt) is shown below as numerical data for the analysis results.

![Time-series displacement of monitoring nodes](./media/tutorial13_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.13.1: Time-series displacement of monitoring nodes
</div>

#### Displacement of monitoring nodes `dyna_disp_3121.txt`.

```
       100  1.0000E-006      3121  7.6885E-005 -7.3733E-005 -6.0988E-004
       200  2.0000E-006      3121  3.3089E-005 -7.5879E-006 -8.2481E-004
       300  3.0000E-006      3121  8.9272E-005 -5.6180E-005 -1.2550E-003
       400  4.0000E-006      3121  5.8434E-005 -2.9113E-005 -1.9326E-003
       500  5.0000E-006      3121  3.3598E-005 -3.7069E-005 -2.6955E-003
       600  6.0000E-006      3121  9.2438E-005 -2.9415E-005 -3.4297E-003
       700  7.0000E-006      3121  4.4742E-005 -1.9064E-005 -4.2128E-003
       800  8.0000E-006      3121  4.2702E-005 -3.7315E-005 -5.2563E-003
       900  9.0000E-006      3121  7.9468E-005  4.8283E-006 -6.1239E-003
      1000  1.0000E-005      3121  2.5902E-005 -3.1393E-005 -7.1463E-003
      1100  1.1000E-005      3121  6.9365E-005 -1.1486E-005 -8.3515E-003
```

