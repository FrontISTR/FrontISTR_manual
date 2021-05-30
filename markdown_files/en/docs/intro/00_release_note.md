## Release Note

### Contents updated in Ver. 5.2

- Improvements
    - issue 079: Output of contact normal force and friction force per unit area
    - issue 142: Specify num of parts in hecmw_part1 command line argument
    - issue 218: Describe the result (res) file format in the documentation.
    - issue 298: Cluster Paradiso support for Docker containers.
    - issue 303: Make Metis ordering available in internal direct method
    - issue 305: Enable RCM ordering with internal direct method.
    - issue 313: JAD SpMV is not OpenMP parallelized
    - issue 314: BLAS Lv.1 operations are not OpenMP parallelized
    - issue 315: Apply parallelized BLAS Lv.1 functions to CG methods
    - issue 324: Anisotropic hyperelasticity
- Specification changes
    - issue 239: Different format of build date and execute date in standard output.
    - issue 262: Exclude result output for internal patch elements created by contact and MPC.
    - issue 274: Fix INFINITE to INFINITESIMAL.
    - issue 302: Refactoring the internal direct method solver
    - issue 307: Update mingw build image for Windows binary creation
    - issue 309: FATAL error is too severe when you have MUMPS and no scalapack
    - issue 326: Remove unnecessary or unimportant version notations
- Bugs fixed
    - issue 045: Weird behavior of internal direct method?
    - issue 111: AMPLITUDE boundary condition can be specified with other than AMP=.
    - issue 280: Can't compile on FrontISTR-5.1 or master branch with Trilinos-13.0.0.
    - issue 290: The version number at runtime is different from the actual version.
    - issue 292: The link to the manual in README.md has not been updated.
    - issue 300: Bugin DLOAD when multiple face groups are set.
    - issue 304: Fix for RCM ordering.
    - issue 306: msmpi.dll is not shipped.
    - issue 327: Bug fix for DEBUG build not going through.
    - issue 328: Error when specifying ISTRESS/ISTRAIN output when defining SURF-SURF contact.
    - issue 332: Couldn't build with setup.sh anymore.

### Contents updated in Ver. 5.1.1

- Improvements
    - issue 108: Output a time to VTK
- Specification changes
    - issue 156: Make test error detection relative to the reference.
    - issue 237: add cmake rules for new MUMPS version
    - issue 247: Fix autoinc example
    - issue 282: Massive error messages when running MPI in parallel with Docker container-provided FrontISTR.
    - issue 284: Support DAG feature in Gitlab CI/CD.
    - issue 288: Find Intel MKL with cmake.
- Bug fixes
    - issue 026: ELEMCHECK Sparsity Overflow
    - issue 052: Delete compile warnings (ongoing)
    - issue 244: Compiling error by gfortran-10
    - issue 245: bug : unable to compile in setup.sh
    - issue 259: fix a bug in Positive DOF elimination with MPC
    - issue 278: Minor bug fixes
    - issue 279: mkl not found in cmake
    - issue 281: Spelling mistakes
    - issue 283: Minor fixes to the Fbar element
    - issue 285: The 741 Shell eigenvalue parsing may fail.
    - issue 287: Unable to run tests in bash on the mac
    - issue 289: heat/exU2 sometimes fails on test_hybrid due to numerical error

### Contents updated in Ver. 5.1

- Improvement
    - issue 207: Add build date output
    - issue 204: Add samples for unsteady heat transfer analysis
    - issue 195: Refiner-related debug output
    - issue 194: Positive DOF elimination is now available when refining models with MPCs
    - issue 183: Clean up and extend the ML interface
    - issue 169: linux binary distribution
    - issue 143: Add a conrod model to tutorial
    - issue 140: Manuals Generation by CI
    - issue 136: Test support for OpenMP thread and MPI parallelism
    - issue 132: Outputting the number of cores used when using OpenMP thread and MPI in parallel.
    - issue 067: Elastoplastic consistent tangential stiffness implementation (Mises only)
    - issue 036: Interpolation using time information in reading heat transfer result files for automatic time increments
- External specification changes
    - issue 131: Removing the FrontISTR starter
- Internal Specifications Change
    - issue 158: Changed internally generated nodal group naming convention when entering a contact surface-surface pair
    - issue 122: Enhanced Testing
    - issue 121: gitlab-ci fix (extended testing)
    - issue 107: Implementing FILM and RADIATE functions using HCEMW
    - issue 056: Duplicate code removed: fistr1/src/lib/physics/ElasticNeoHooke.f90
    - issue 046: Check programmer information
    - issue 044: Output integration (static and dynamic)
    - issue 037: Change the res_bin_io.inc and res_txt_io.inc extensions.
- Bug Fixes
    - issue 203: 611 Fixed a bug in a beam element and added a test example
    - issue 185: Fix bug in eigenvalue analysis result file (.res)
    - issue 184: Linear Dynamic Analysis (Implicit Method) for Linear Analysis
    - issue 181: 541 Fixing the mass sequence when using interface elements
    - issue 159: Improve readability of internal variables (e.g. DISTCLR_CONT)
    - issue 123: Fixed a bug in applying ML preprocessing to heat transfer analysis.
    - issue 114: Fixed a bug when setting a subdirectory to output VTK files.
    - issue 113: Fixed some output issues
    - issue 055: Initializing the variable iexit in subroutine fstr_solve_dynamic_nlimplicit
    - issue 054: Fix the fstr_ctrl_get_data_array_ex argument used in the read_user_matl function
    - issue 053: Dynamic nonlinear parallelism with memory leak correction (combined with SOR preprocessing)
    - issue 026: Fix ELEMCHECK sparsity value


### Contents updated in Ver. 5.0

The following functions were added in FrontISTR Ver. 5.0.

### Contents updated in Ver. 3.8

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

### Contents updated in Ver. 3.7

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

### Contents updated in Ver. 3.6

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

### Contents updated in Ver. 3.5

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


