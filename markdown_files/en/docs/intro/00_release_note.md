
# Release Note

## Contents updated in Ver. 5.0

The following functions were added in FrontISTR Ver. 5.0.

## Contents updated in Ver. 3.8

The following functions were added in FrontISTR Ver. 3.8:

  - Analysis function and algorithm
    - Implementation of the boundary conditions of rotational displacement
    - Implementation of the boundary conditions of torque
    - Change in the method of calculation of the reaction force of three-dimensional linear static analysis
    - Introduction of incompressible fluid analysis function (RC version)

  - Elements
    - Addition of tetrahedral elements for incompressible fluid analysis (3414 elements)
    - Correction of the calculation of the stress value of (laminated) shell elements

  - Materials
    - Faster loading of material definition parts inside mesh files
    - Faster loading of material definition parts inside analysis control files
    - Addition of properties of materials for incompressible fluid analysis

  - Linear solvers 
    - Subdivision of log output methods when using MUMPS
    - Correction of 4×4 CG solver
    - Correction of 6×6 CG solver

  - Meshing and refining-related
    - Correction of errors when large-scale models are refined

  - Furthermore, the following corrections were made:
    - Correction of errors of element definition with eigenvalue analysis (!STATICEIGEN) that acquires the results of non-linear static analysis
    - Correction of the memory leak of the scan_contact_state function in contact analysis
    - Correction of the warning sign displayed during compilation
    - Change in the header of the program code top
    - Change in LICENSE files

## Contents updated in Ver. 3.7

The following functions were added in FrontISTR Ver. 3.7:

  - Input/output
    - Correction of the calculation of stress value in the six degree-of-freedoms (DOFs) solver
    - Addition of calculation function for main stress and strain 
    - Correction of output part of laminated shell elements 
    - Addition of the INCLUDE function of the analysis files (cnt files)
    - Addition of the LINK card to the MPC input of !EQUATION
    - Change to provide Material ID (element shape ID) as output at the UCD output
    - Addition of the STEPLOG function to !SOLVER
    - Addition of the non-zero elements plot function in matrices
    - Addition of the MONITOR output function of the !SUBDIR flag
    - Addition of the output function of stimulation coefficient and valid mass (eigenvalue analysis)
    - Compatibility to large-scale meshes
    - Addition of TYPE=TIMEVALUE when !AMPLITUDE is input
    - Improvement of input function for Abaqus
    - Correction of the name search part of the MATERIAL function configured to the analysis files (cnt files)
    - Correction of the logfile output
    - Correction of global summary

  - Refiner
    - Addition of the refine function to the contact problem
    - Correction of the UCD output when refining

  - Analysis
    - Correction of the spring boundary conditions function
    - Faster contact pair search in contact analysis (algorithm update and OpenMP parallelism applied)

  - Elements
    - Addition of the TLOAD_C3D8IC function (addition of the thermal stress load)
    - Compatibility of the truss elements (301 elements) and tetrahedral primary elements (341 elements) with parallel contact analysis

  - Materials
    - Correction of errors related to the calculation of elastoplastic material when OpenMP is active

  - Functions
    - Correction of the flush test

  - Linear solver
    - Addition of ISAINV and IRIF preprocessing
    - Addition of the Intel PARDISO interface
    - Error correction of the part related to the OpenMP atomic descriptor
    - Error correction of the USEJAD card of !SOLVER
    - Compatibility with METIS ver. 5.0
    - Correction of the hecmw_solver_direct routine
    - Error correction of SSOR preprocessing when OpenMP = 1
    - Compatibility with elements with mixed DOFs of the calculated part of rigid body mode of ML preprocessing

  - Examples and tutorials 
    - Addition of examples of the shell elements for mixed DOFs (elements 761 and 781) 
    - Addition of examples of the spring boundary conditions function 
    - Confirmation that all the examples in the attached tutorial can be executed correctly

  - Partitioner 
    - The partitioner now creates the dispersion mesh of a single area correctly

  - Other minor corrections 
    - Initialization of fstr_setup_util.f90 
    - Correction of the intent sentence

## Contents updated in Ver. 3.6

The following functions were added in FrontISTR Ver. 3.6:

  - Input/output 
    - Faster file loading 
    - Output change when the 781 and 761 shell elements are used
    - Debug message deleted

  - Refiner
    - Correction of the refinement error when the constant of the right side was configured in the definition of !EQUATION

  - Analysis
    - Corrections related to frequency response analysis
    - Corrections related to thermal stress analysis when going through !SOLUTION,TYPE=STATIC
    - Corrections related to pressure normal direction update when going through !SOLUTION,TYPE=NLSTATIC
    - Correction of the getContactStiffness subroutine of contact stiffness matrix

  - Elements
    - OpenMP parallelization of the element loop
    - Corrections related to the B-bar element (solid element)
    - Corrections related to the shell elements
    - Corrections related to the truss elements
    - Correction of the invalid memory when shell, beam, truss, and solid were mixed

  - Material
    - Corrections related to orthotropic elastic bodies

  - Linear solver 
    - Correction of the matrix dump function
    - Memory saving in 3×3 ILU preprocessing
    - Addition of the 4×4 CG solver
    - Addition of the 6×6 CG solver
    - Number of conditions of the matrix after the application of preprocessing by 3×3 CG and GMRES solver (experimental)
    - Addition of divergence check to the 3×3 CG solver
    - Reutilization of preprocessing setup information when using the 3×3 solver
    - Interface to the external AMG preprocessing library (ML) for the 3×3 solver (experimental)
    - Communication concealment with matrix vector product of the 3×3 solver (experimental)
    - Multipoint constraint processing by the explicit DOF elimination method
    - Use of the iteration method solver in contact analysis (experimental)

  - Updates related to partitioner
    - Faster file input
    - Expansion of the log output function
    - OpenMP parallelization of the dispersion mesh creation loop

## Contents updated in Ver. 3.5

The following functions were added in FrontISTR Ver. 3.5:

  - Analysis function-related
    - Compatibility with analysis of a mixture of shell/beam elements and solid elements (See 3.7, 4.1, 6.3 (3))
    - Compatibility with orthotropic materials in the shell elements (See 4.2.2(3))
    - Compatibility with laminated shells (See 4.2.2(3))
    - The FOLLOW function of pressure load in large deformation analysis (See 7.4.2(14))
    - Compatibility with dynamic analysis of beam elements (See 3.7)
    - Monitoring of multiple nodes in dynamic analysis (See 7.4.5(1))
    - Monitoring of nodes stress and nodes strain in dynamic analysis (See 7.4.5(1))
    - Application of the window function to the input fluid force in coupled analysis (See 7.4.5(4))

  - Partitioner-related updates
    - Significant speed increase
    - Compatibility with the Metis Ver. 5 system (see installation manual)

  - Mesh and refining-related updates
    - Compatibility with the refining of models with mixed element types
    - Compatibility with interpolation based on refining information of the input temperature data

  - Linear solver-related updates (See 7.4.6(1))
    - Compatibility with multicolor processing and hybrid parallelism in preprocessing
    - Ordering for vector computers
    - More combinations of preprocessing and iterative solutions that can be used in problems with three DOFs
    - The dump function of the matrix data

  - The following corrections were also applied:
    - Correction of the Drilling DOF of the shell elements
    - Correction of convergence judgment in non-linear analysis
    - Correction of the restart time of linear dynamic analysis
    - Correction of the node number display in the message of coupled analysis
    - Correction of ILU preprocessing
    - Error prevention during optimization with some compilers

