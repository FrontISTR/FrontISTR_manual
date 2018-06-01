# Release Note

## What's new in Ver.3.8

The following functionalities are updated:

- Analysis
    - Added boundary condition setting of rotational displacement
    - Added boundary condition setting of torque
    - changed calculation of reaction force in 3D linear static analysis
    - Added an incompressive flow analysis
- Element
    - Added tetrahedral element for incompressive flow (3414 element)
    - Fixed stress calculation procedure of layerd shell element
- Material
    - Optimization in input functions for material definitions
    - Added material database for imcompressive flow
- Solver
    - Added verbose card when using MUMPS
    - Fixed 4&times;4 CG solver
    - Fixed 6&times;6 CG solver
- Refiner
    - Fixed a refine function in large-scale problem
- Others
    - Fixed an eigenvalue analysis considering the result of nonlinear static analysis
    - Fixed `scan_contact_state` function in contact analysis
    - Fixed some program which leads warning when compiling
    - Changed header section in program files
    - Changed LICENSE file

## What's new in Ver.3.7

The following functionalities are updated:

  - Input/Output
    - Fix in stress computation in 6x6 solver
    - Added output function of principal stress and principal strain
    - Fix in output function of laminated shell elements
    - Added !INCLUDE function in analysis (.cnt) files
    - Added LINK card in !EQUATION (MPC input)
    - Output material ID in UCD output
    - Added STEPLOG function in !SOLVER
    - Added output function of non-zero element of stiffness matrix
    - Added MONITOR output in !SUBDIR
    - Output participate factor and efficient mass (eigenvalue analysis)
    - Fix in some functions to handle for large-scale mesh input
    - Added TYPE=TIMEVALUE option in !AMPLITUDE input
    - Improved input function of Abacus files
    - Fix in name search function of MATERIALs’ group name
    - Fix in logfile output
    - Fix in global summary output
  - Refiner
    - Added refine functions for contact problems
    - Fixed in UCD output of Refiner
  - Analysis
    - Fix in functions of spring boundary conditions
    - Speed-up of search algorithm for contact pair in contact analysis<br/>(Update of Algorithm and OpenMP parallelization)
  - Elements
    - Added TLOAD_C3D8IC element (thermal stress analysis)
    - Added in parallel contact analysis function for truss element (301 element) and tetrahedron (341 element)
  - Material
    - Fix in computation of elasto-plastic materials when OpenMP is enabled
  - Analysis functionality
    - Fix in flush test
  - Linear Solver
    - Added ISAINV and IRIF preconditioner
    - Added Intel PARDISO interface
    - Fix in OpenMP atomic pragma
    - Fix in USEJAD card in !SOLVER
    - Added interface for METIS ver. 5.0
    - Fix in hecmw_solver_direct routine
    - Fix in SSOR preconditioner when OpenMP=1
    - Added function for rigid-body mode of mixed DOF element in ML preconditioner
  - Examples/Tutorials
    - Added examples of mixed DOF shell element (761 element and 781element)
    - Added examples of spring boundary conditions
    - Confirmed that all tutorial examples are executed successfully
  - Partitioner
    - Fix in computation of elasto-plastic materials when OpenMP is enabled
    - Fix in output of 1 domain distributed mesh in partitioner
  - Others
    - Fix in initialization in fstr_setup_util.f90
    - Fix in intent option

## What's new in Ver.3.6

The following functionalities are updated:

  - Input/Output
    - Speed-up in file input
    - Change of output when 761 or 781 shell element is used
    - Removal of debug messages
  - Refiner
    - Fix when constant value is specified in `!EQUATION`
  - Analysis
    - Fixed in frequency response snslysis
    - Fixed in thermal stress analysis when `!SOLUTION,TYPE=STATIC` is specified
    - Fixed in updating normal direction for pressure when `!SOLUTION,TYPE=NLSTATIC` is specified
    - Fixed in subroutine `getContactStiffness`
  - Elements
    - OpenMP parallelization of element loops
    - Fixed in B-bar element (solid element)
    - Fixed in shell element
    - Fixed in truss element
    - Fixed of invalid memory access when shell, beam, truss and solid elements exist
  - Material
    - Fixed in orthotropic elastic material
  - Linear solver
    - Fix in matrix dumping
    - Memory reduction in 3x3 ILU preconditioner
    - Added 4x4 CG solver
    - Added 6x6 CG solver
    - Estimating condition number of preconditioned matrix with 3x3 CG / GMRES (experimental)
    - Added divergence check in 3x3 CG solver
    - Recycle of setup information of preconditioners when 3x3 solver is used
    - Interface for external AMG preconditioner (ML) for 3x3 solvers (experimental)
    - Communication hiding in matrix-vector multiplication in 3x3 solvers (experimental)
    - Explicit master-slave elimination for imposing multipoint constraints
    - Iterative linear solver available for contact analysis (experimental)
- Partitioner
    - Speed-up in file input
    - Extended logging
    - OpenMP parallelization of the loop for generating distributed mesh

## What's new in Ver.3.5

The following functionalities are updated:

  - Analysis functionality
    - Analysis of mixed element type models of beam / shell elements and solid elements (see 3.74.16.3(3))
    - Orthotropic material for shell elements (see 4.2.2(3))
    - Multiple layered shell analysis (see 4.2.2(3))
    - Pressure load follows the deformation in finite deformation analysis (see 7.4.2(15))
    - Dynamic analysis with beam elements (see 3.7)
    - Monitoring of multiple nodes in dynamic analysis (see 7.4.5(1))
    - Monitoring of nodal stress and strain in dynamic analysis (see 7.4.5(1))
    - Applying window function on input fluid tranction in coupling analysis (see 7.4.5(4))
- Partitioner
    - Drastic speed-up when partitioning into large number of subdomains
    - Metis Ver.5 series support (see Installation Manual)
- Mesh refinement
    - Refinement of models with multiple element types
    - Interpolation of input nodal temperature based on refinement information
- Linear solver (see 7.4.6(1))
    - Multi-color ordering in SSOR preconditioner and hybrid parallel computation
    - Ordering for vector processors
    - More combination of preconditioner and iterative methods for 3-dof problems
    - Matrix dumping
- Others
    - Fix of drilling DOF in shell elements
    - Fix in convergence check in nonlinear analysis
    - Fix of time in output files in restarted linear dynamic analysis
    - Fix of node IDs in message files in coupling analysis
    - Fix of ILU preconditioner
    - Avoid erroneous behavior when compiled by some compilers with optimization flags



