## Linear Static Analysis (Elasticity, Parallel)

To run 4 parallel static analysis(elasticity), and you can use the data in `tutorial/02_elastic_hinge_parallel`.

### Analysis target

 | Item                | Description                           | Notes                     | Reference   |
 |---------------------|---------------------------------------|---------------------------|-------------|
 | Type of analysis    | Linear static analysis                |!SOLUTION,TYPE=STATIC      |             |
 | Number of nodes     | 84,056                                |                           |             |
 | Number of elements  | 49,871                                |                           |             |
 | Element type        | 10-node tetrahedron quadratic element |!ELEMNT,TYPE=342           |[Element Library](../analysis/analysis_02.html#element-library) |
 | Material name       | STEEL                                 |!MATERIAL,NAME=STEEL       |[Material Data](../analysis/analysis_02.html#material-data)|
 | Material property   | ELASTIC                               |!ELASTIC                   |             |
 | Boundary conditions | Restraint, Concentrated force         |                           |             |
 | Matrix solution     | CG/SSOR                               |!SOLVER,METHOD=CG,PRECOND=1|             |

![Analysis area of each node](./media/tutorial02_01.png){.center width="350px"}

<div style="text-align: center;"> 
Fig. 4.2.1 : Analysis area of each node
</div>

### Analysis

Extract the code FrontISTR code and go to the directory in this example to check if you have the files necessary for analysis.

 | File name             | Type                  | Role |
 |-----------------------|-----------------------|------|
 | `hecmw_ctrl.dat`      | Global control data   |      |
 | `hinge.cnt`           | Analysis control data |      |
 | `hinge.msh`           | Mesh data             |      |
 | `hecmw_part_ctrl.dat` | Domain segmentation control data | Control data to divide the mesh data into regions by `hecmw_part1` |

``` 
$ tar xvf FrontISTR.tar.gz
$ cd FrontISTR/tutorial/02_elastic_hinge_parallel
$ ls
hecmw_ctrl.dat  hecmw_part_ctrl.dat  hinge.cnt  hinge.msh
``` 

A stress analysis is performed to constrain the displacement of the constrained surface and add concentrated loads to the forced surface.

The overall control data, analysis control data and domain division control data are shown below.

#### Global control data `hecmw_ctrl.dat`

```
#
# for partitioner
#
!MESH, NAME=part_in,TYPE=HECMW-ENTIRE # The original mesh data to be split in hecmw_part1
 hinge.msh
!MESH, NAME=part_out,TYPE=HECMW-DIST  # File name after splitting by hecmw_part1
 hinge_4
#
# for solver
#
!MESH, NAME=fstrMSH, TYPE=HECMW-DIST  # Specify the mesh data to be split
 hinge_4
!CONTROL, NAME=fstrCNT                # Specify analysis control data
 hinge.cnt
!RESULT, NAME=fstrRES, IO=OUT         # Specify the result data
 hinge.res
!RESULT, NAME=vis_out, IO=OUT         # Specify the visualization data
 hinge_vis
```

#### Analysis control data `hinge.cnt`

```
#  Control File for FISTR
## Analysis Control
!VERSION                   # Specify the version of the file format
 3
!SOLUTION, TYPE=STATIC     # Specify the type of analysis
!WRITE,RESULT              # Specification of the result data output
!WRITE,VISUAL              # Specify the output of visualization data
## Solver Control
### Boundary Conditon
!BOUNDARY
 BND0, 1, 3, 0.000000      # Restrained surface 1
!BOUNDARY
 BND1, 1, 3, 0.000000      # Restrained surface 2
!CLOAD
 CL0, 1, 0.01000           # Specify a forced surface
### Material
!MATERIAL, NAME=STEEL      # Specify material properties
!ELASTIC                   # Definition of elastic substances
 210000.0, 0.3
!DENSITY                   # Definition of mass density
 7.85e-6
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=YES,TIMELOG=YES  # Solver control
 10000, 2
 1.0e-08, 1.0, 0.0
## Post Control
!VISUAL,metod=PSR          # Specify the visualization methods
!surface_num=1             # Number of surfaces in a surface rendering
!surface 1                 # Specify the contents of the surface
!output_type=VTK           # Specify the type of the visualization file
!END                       # Indicates the end of the analysis control data
```

#### Domain division control data `hecmw_part_ctrl.dat`

```
!PARTITION,TYPE=NODE-BASED,METHOD=PMETIS,DOMAIN=4,UCD=part.inp
```

#### Analysis procedure

In order to run FrontISTR at MPI, the mesh data `hinge.msh` is first divied into four regions.

```
$ hecmw_part1
Oct 07 11:04:52 Info: Reading mesh file...
Oct 07 11:04:52 Info: Starting domain decomposition...
Oct 07 11:04:52 TH(0/8) Info: Creating local mesh for domain #0 ...
Oct 07 11:04:52 TH(2/8) Info: Creating local mesh for domain #1 ...
Oct 07 11:04:52 TH(6/8) Info: Creating local mesh for domain #2 ...
Oct 07 11:04:52 TH(7/8) Info: Creating local mesh for domain #3 ...
Oct 07 11:04:52 Info: Domain decomposition done
```

New files called hinge_4.x and part.inp will be generated.

```
$ ls
hecmw_ctrl.dat  hecmw_part_ctrl.dat  hinge.msh  hinge_4.1  hinge_4.3
hecmw_part.log  hinge.cnt            hinge_4.0  hinge_4.2  part.inp
```

Next, you will execute the FrontISTR command `fistr1` with MPI.

```
$ mpirun -np 4 fistr1 -t 1
(MPI 4 parallel, 1 OpenMP thread)
```

```
##################################################################
#                         FrontISTR                              #
##################################################################
---
version:    5.1.0
git_hash:   acab000c8c633b7b9d596424769e14363f720841
build:
  date:     2020-10-05T07:39:55Z
  MPI:      enabled
  OpenMP:   enabled
  option:   "-p --with-tools --with-refiner --with-metis --with-mumps --with-lapack --with-ml --with-mkl "
  HECMW_METIS_VER: 5
execute:
  date:       2020-10-07T11:07:21+0900
  processes:  4
  threads:    1
  cores:      4
  host:
    0: flow-p06
    1: flow-p06
    2: flow-p06
    3: flow-p06
---
...
 Step control not defined! Using default step=1
 fstr_setup: OK
 Start visualize PSF 1 at timestep 0

 loading step=    1
 sub_step= 1,   current_time=  0.0000E+00, time_inc=  0.1000E+01
 loading_factor=    0.0000000   1.0000000
### 3x3 BLOCK CG, SSOR, 2
      1    2.183567E+00
      2    2.423900E+00
      3    2.939117E+00
...
   2084    1.158654E-08
   2085    1.032414E-08
   2086    9.436273E-09
### Relative residual = 9.43589E-09

### summary of linear solver
      2086 iterations      9.435886E-09
    set-up time      :     4.695220E-02
    solver time      :     7.103976E+01
    solver/comm time :     1.929294E+01
    solver/matvec    :     1.544405E+01
    solver/precond   :     3.243278E+01
    solver/1 iter    :     3.405549E-02
    work ratio (%)   :     7.284205E+01

 Start visualize PSF 1 at timestep 1
### FSTR_SOLVE_NLGEOM FINISHED!

 ====================================
    TOTAL TIME (sec) :     72.42
           pre (sec) :      0.29
         solve (sec) :     72.13
 ====================================
 FrontISTR Completed !!
```

The analysis is completed when `FrontISTR Completed!!` is displayed, the analysis is done.

### Analysis Results

Once the analysis is complete, several new files will be created.

```
$ ls
0.log       FSTR.dbg.3           hinge.cnt      hinge.res.2.1  hinge_vis_psf.0000
1.log       FSTR.msg             hinge.msh      hinge.res.3.0  hinge_vis_psf.0000.pvtu
2.log       FSTR.sta             hinge.res.0.0  hinge.res.3.1  hinge_vis_psf.0001
3.log       hecmw_ctrl.dat       hinge.res.0.1  hinge_4.0      hinge_vis_psf.0001.pvtu
FSTR.dbg.0  hecmw_part.log       hinge.res.1.0  hinge_4.1      part.inp
FSTR.dbg.1  hecmw_part_ctrl.dat  hinge.res.1.1  hinge_4.2
FSTR.dbg.2  hecmw_vis.ini        hinge.res.2.0  hinge_4.3
```

The `*.res.*` is the result data, which contains results of analysis of each MPI node of FrontISTR.

The `*_vis_*` is called visualization data, and can be displayed by general-purpose visualization software. In this example, the data is output in VTK format and can be displayed using ParaView or other visualization software.


![Analysis of Mises Stress (Displayed in VTK)](./media/tutorial02_02.png){.center width="350px"}
<div style="text-align: center;">
Fig. 4.2.2 Analytical results for Mises stress(displayed in VTK)
</div>
