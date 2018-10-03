## Frequency Response Analysis

Use the files in the directory, `tutorial/17_freq_beam/`, in order to reproduce the test. The analysis consists of two steps; 1st Eigenvalue analysis, 2nd Frequency response analysis. For the 1s step, the following name change is required.

```
    hecmw_ctrl_eigen.dat -> hecmw_ctrl.dat
```

After changing the name of file, eigenvalues analysis should be executed. You will get 0.log as the result of eigenvalue analysis. The file name should be changed as follows.

```
    0.log -> eigen_0.log
```

Then start frequency response analysis.

### Analysis Object

The analysis model is shown in Fig. 4.17.1 and the discretized mesh is shown in Fig.4.17.2.  The model is mesh with Element Type 341 (Number of Elements: 126, Number of Nodes: 55).

<div style="text-align: center;">
<img src="./media/tutorial17_01.png" width="350px"><br>
Fig. 4.17.1 : The analysis model
</div>

<div style="text-align: center;">
<img src="./media/tutorial17_02.png" width="350px"><br>
Fig. 4.17.2 : The mesh
</div>

### Analysis Content

One of the cantilever beam end was fixed and the other is applied load as nodal force on two nodes. The eigenvalues up to 10th mode are computed and the resulting eigenvalues and eigenvectors up to 5th mode are used for frequency response analysis。The analysis control data shown below.

```
# Control File for FISTR
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
  10000, 2
  1.0e-8, 1.0, 0.0
```

### Analysis Results

The frequency dependency of amplitude of displacement at a monitoring node(Node ID 1) specified in the analysis control data is shown in Fig. 4.17.3. A portion of a log file is shown below to show the numerical data obtained by the frequency response analysis.

<div style="text-align: center;">
<img src="./media/tutorial17_03.png" width="350px"><br>
Fig.4.17.3 Frequency dependency of amplitude of displacement at a monitoring node
</div>

```
 Rayleigh alpha:   0.0000000000000000
 Rayleigh beta:   7.1999999999999999E-007
 read from=eigen_0.log
 start mode=           1
 end mode=           5
 start frequency:   14000.000000000000
 end frequency:   16000.000000000000
 number of the sampling points          20
 monitor nodeid=           1
   14100.000000000000      [Hz] :    8.3957630463152688E-002
   14100.000000000000      [Hz] :            1 .res
   14200.000000000000      [Hz] :    9.1237051959262350E-002
   14200.000000000000      [Hz] :            2 .res
   14300.000000000000      [Hz] :    9.9610213760033539E-002
   14300.000000000000      [Hz] :            3 .res
   14400.000000000000      [Hz] :   0.10918495323840580
   14400.000000000000      [Hz] :            4 .res
   14500.000000000000      [Hz] :   0.11996212788265602
   14500.000000000000      [Hz] :            5 .res
   14600.000000000000      [Hz] :   0.13169277524043285
   14600.000000000000      [Hz] :            6 .res
   14700.000000000000      [Hz] :   0.14365135321213662
   14700.000000000000      [Hz] :            7 .res
   14800.000000000000      [Hz] :   0.15439888482329628
   14800.000000000000      [Hz] :            8 .res
   14900.000000000000      [Hz] :   0.16182392983620905
   14900.000000000000      [Hz] :            9 .res

```
