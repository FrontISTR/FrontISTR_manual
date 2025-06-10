## Heat Conduction Analysis

This analysis uses the data of `tutorial/16_heat_block`.

### Analysis target

The analysis target is a perforated block, the geometry is shown in Figure 4.16.1 and the mesh data is shown in Figure 4.16.2.

 | Item              | Description                 | Notes                     | Reference |
 |-------------------|-----------------------------|---------------------------|-----------|
 |Type of analysis   |Heat conduction analysis     |!SOLUTION,TYPE=HEAT        |           |
 |Number of nodes    |37,386                       |                           |           |
 |Number of elements |32,160                       |                           |           |
 |Element type       |Eight node hexahedral element|!ELEMENT,TYPE=361          |           |
 |Material name      |AL                           |!MATERIAL,NAME=AL          |           |
 |Boundary conditions|Prescribed temperature       |!FIXTEMP                   |           |
 |Matrix solution    |CG/SSOR                      |!SOLVER,METHOD=CG,PRECOND=1|           |

![Shape of the perforated block](./media/tutorial16_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.16.1: Shape of the perforated block
</div>

![Mesh data of the perforated block](./media/tutorial16_02.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.16.2: Mesh data of the perforated block
</div>

### Analysis content

Steady-state heat conduction analysis is performed to provide a heat source to the cylindrical inner surface of the object. The analysis control data are shown below.

#### Analysis control data `block.cnt`.

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
## Post Control
!VISUAL,method=PSR
!surface_num=1
!surface 1
!output_type=VTK
!END
```

### Analysis procedure

Execute the FrontISTR execution command `fistr1`.

```
$ cd FrontISTR/tutorial/16_heat_block
$ fistr1 -t 4
(Runs in 4 threads.)
```

### Analysis results

A temperature contour plot was created by REVOCAP_PrePost and is shown in Figure 4.16.3. A part of the analysis results log file is shown below as numerical data for the analysis results.


![Analysis results of temperature](./media/tutorial16_03.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.16.3: Analysis results of temperature
</div>

#### Log file `0.log`.

```
 fstr_setup: OK

 ISTEP =     1
 Time  =     0.000
 Maximum Temperature :   100.000
 Maximum Node No.    :         9
 Minimum Temperature :    20.000
 Minimum Node No.    :        85
 Maximum Temperature(global) :   100.000
 Minimum Temperature(global) :    20.000
```


