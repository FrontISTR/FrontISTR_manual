# Introduction

## Position of this Manual

This manual describes the data input method regarding the analysis range
applicable to FrontISTR, and the execution procedures of FrontISTR.

## Purpose of this Manual

The purpose of this manual is to describe the basic contents of the data
structure peculiar to the programs and the analysis functions, in order
for the user to execute FrontISTR. Regarding the analysis execution
control in FrontISTR, it is necessary to specify the overall control
data and computing control data. Moreover, analysis of the mesh data is
executed by inputting the distributed mesh file. The details of the
relationships between the input methods and input data of these control
data are described from the following Chapter.

## What’s new in Ver.3.6

The following functionalities are updated:

-   Input/Output

    -   Speed-up in file input

    -   Change of output when 761 or 781 shell element is used

    -   Removal of debug messages

-   Refiner

    -   Fix when constant value is specified in !EQUATION

-   Analysis

    -   Fix in frequency response snslysis

    -   Fix in thermal stress analysis when !SOLUTION,TYPE=STATIC is
        specified

    -   Fix in updating normal direction for pressure when
        !SOLUTION,TYPE=NLSTATIC is specified

    -   Fix in subroutine getContactStiffness

-   Elements

    -   OpenMP parallelization of element loops

    -   Fix in B-bar element (solid element)

    -   Fix in shell element

    -   Fix in truss element

    -   Fix of invalid memory access when shell, beam, truss and solid
        elements exist

-   Material

    -   Fix in orthotropic elastic material

-   Linear solver

    -   Fix in matrix dumping

    -   Memory reduction in 3x3 ILU preconditioner

    -   Added 4x4 CG solver

    -   Added 6x6 CG solver

    -   Estimating condition number of preconditioned matrix with 3x3 CG
        / GMRES (experimental)

    -   Added divergence check in 3x3 CG solver

    -   Recycle of setup information of preconditioners when 3x3 solver
        is used

    -   Interface for external AMG preconditioner (ML) for 3x3
        solvers (experimental)

    -   Communication hiding in matrix-vector multiplication in 3x3
        solvers (experimental)

    -   Explicit master-slave elimination for imposing multipoint
        constraints

    -   Iterative linear solver available for contact
        analysis (experimental)

-   Partitioner

    -   Speed-up in file input

    -   Extended logging

    -   OpenMP parallelization of the loop for generating distributed
        mesh

## What’s new in Ver.3.5

The following functionalities are updated:

-   Analysis functionality

    -   Analysis of mixed element type models of beam / shell elements
        and solid elements (see 3.74.16.3(3))

    -   Orthotropic material for shell elements (see 4.2.2(3))

    -   Multiple layered shell analysis (see 4.2.2(3))

    -   Pressure load follows the deformation in finite deformation
        analysis (see 7.4.2(14))

    -   Dynamic analysis with beam elements (see 3.7)

    -   Monitoring of multiple nodes in dynamic analysis (see 7.4.5(1))

    -   Monitoring of nodal stress and strain in dynamic analysis
        (see 7.4.5(1))

    -   Applying window function on input fluid tranction in coupling
        analysis (see 7.4.5(4))

-   Partitioner

    -   Drastic speed-up when partitioning into large number of
        subdomains

    -   Metis Ver.5 series support (see Installation Manual)

-   Mesh refinement

    -   Refinement of models with multiple element types

    -   Interpolation of input nodal temperature based on refinement
        information

-   Linear solver (see 7.4.6(1))

    -   Multi-color ordering in SSOR preconditioner and hybrid parallel
        computation

    -   Ordering for vector processors

    -   More combination of preconditioner and iterative methods for
        3-dof problems

    -   Matrix dumping

Also, Ver.3.5 includes the following fixes:

-   Fix of drilling DOF in shell elements

-   Fix in convergence check in nonlinear analysis

-   Fix of time in output files in restarted linear dynamic analysis

-   Fix of node IDs in message files in coupling analysis

-   Fix of ILU preconditioner

-   Avoid erroneous behavior when compiled by some compilers with
    optimization flags
