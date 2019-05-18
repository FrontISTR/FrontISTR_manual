## Operating Environment

### Required software

To install this software, the following software programs must have been installed in the environment where this software is to be installed. For information on how to install these software programs, refer to their installation manuals.

#### C, C++ and Fortran90 compilers

C, C++, and Fortran90 compilers are required to install this software.

#### MPI

This software executes parallel processing via MPI and requires an MPI library that compiles wihh the MPI-1 standards. Representative free-of-charge libraries that implement MPI include MPICH and OpenMPI. OpenMPI and MPICH can be downloaded from the following website:

Open MPI: Open Source High Performance Computing

  - [https://www.open-mpi.org/](https://www.open-mpi.org/)

High-Performance Portable MPI

  - [http://www.mpich.org/](http://www.mpich.org/)

#### METIS

The domain decomposition utilities of this software use the METIS libraries to enable domain decomposition using pMETIS and kMETIS. METIS is required to use these domain decomposition functions. Supported versions of METIS are the newest version Ver.5 series and previous version Ver.4 series. 

For environments where METIS is not installed, domain decomposition is still possible using the RCB algorithm.

METIS - Serial Graph Partitioning and Fill-reducing Matrix Ordering

  - [http://glaros.dtc.umn.edu/gkhome/metis/metis/overview](http://glaros.dtc.umn.edu/gkhome/metis/metis/overview)


#### ParMETIS

We plan to use the ParMETIS library as the parallel domain decomposition utilities for this software.

ParMETIS is not required at present.

ParMETIS - Parallel Graph Partitioning and Fill-reducing Matrix Ordering

  - [http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview](http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview)

#### HEC-MW

This software uses the HEC-MW library developed by the "Revolutionary Simulation Software" and "Research and Development of Innovative Simulation Software" projects.

HEC-MW comes bundled with the FrontISTR archive file, and is automatically compiled when this software is installed, so there is no need to install HEC-MW separately.

#### REVOCAP_Refiner

This software is compatible with the REVOCAP_Coupler coupled analysis tool developed by the "Research and Development of Innovative Simulation Software" project.
REVOCAP_Coupler is required to use the coupled analysis function. REVOCAP_Coupler can
be downloaded from the following website:

  - [http://www.multi.k.u-tokyo.ac.jp/FrontISTR/](http://www.multi.k.u-tokyo.ac.jp/FrontISTR/)

#### REVOCAP_Coupler

This software is compatible with the REVOCAP_Coupler coupled analysis tool developed by the "Research and Development of Innovative Simulation Software" project.REVOCAP_Coupler is required to use the coupled analysis function. REVOCAP_Coupler can be downloaded from the following website:

  - [http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php](http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php)

#### LAPACK/BLAS

This software is implemented a function of estimating condition number of preconditioned matrix.

When you use this function, LAPACK and BLAS libraries are required.

Reference implements of LAPACK can be downloaded from the following website:

  - [http://www.netlib.org/lapack/](http://www.netlib.org/lapack/)

Reference implements of BLAS can be downloaded from the following website:

  - [http://www.netlib.org/blas/](http://www.netlib.org/blas/)

OpenBLAS is compatible, fast and Open-Sourced implements of LAPACK/BLAS. OpenBLAS can be downloaded from the following website:

  - [http://www.openblas.net/](http://www.openblas.net/)

If Intel MKL is installed, it is not necessary to install above software.

#### MUMPS

This software is compatible with a public domain parallel direct solver MUMPS (a MUltifrontal Massively Parallel sparse direct Solver). MUMPS is based on public domain software developed during the Esprit IV European project PARASOL (1996-1999). Since this first public domain version in 1999, research and developments have been supported by the following institutions: CERFACS, CNRS, ENS Lyon, INPT(ENSEEIHT)-IRIT, INRIA, and University of Bordeaux. MUMPS can be downloaded from the following website:

  - [http://mumps.enseeiht.fr/](http://mumps.enseeiht.fr/)

#### ScaLAPACK

Therefore this software doesn't use this directly, MUMPS needs ScaLAPACK for compiling. ScaLAPACK can be downloaded from the following website:

  - [http://www.netlib.org/scalapack/](http://www.netlib.org/scalapack/)

If Intel MKL is installed, it is not necessary to install above software.

#### ML

This software is compatible with multigrid preconditioner package ML (Multi-Level Preconditioner). ML is one of the packages developed under Trilinos project at Sandia National Laboratories. ML can be downloaded from the following website:

  - [https://trilinos.org/](https://trilinos.org/)

#### Intel MKL（Math Kernel Library）

The contact analysis module of this software uses Intel MKL. If Intel MKL has not been installed in the environment where this software is to be installed, some of the contact analysis functions cannot be used.

### Operation verification environment

Operations of this software have been verified in the following environment. However, if the software programs (described above) required for installing this software have been installed, this software should operate normally even in environments other than the environment shown below.

#### Operation verification environment

| System               | Operatingsystem                   | CPU                 | Compiler             | Parallel processing<br/>environment |
|----------------------|-----------------------------------|---------------------|----------------------|-------------------------------------|
| K computer           | Linux                             | SPARC64 VIIIfx      | Fujitsu compiler     | Fujitsu MPI                         |
| PRIMEHPC FX100       | Linux                             | SPARC V9 + HPC-ACE2 | Fujitsu compiler     | Fujitsu MPI                         |
| EARTH SIMULATOR(ES3) | SUPER UX                          | SX-ACE              | NEC compiler         | NEC MPI                             |
| UV2000               | Linux (SUSE Linux Enterprise 10)  | Intel Xeon          | Intel compiler       | SGI MPT                             |
| PC cluster           | Linux (CentOS-7)                  | Intel Xeon          | Intel compiler       | Intel MPI                           |
| PC cluster           | Linux (RedHat Enterprise Linux 7) | Intel Xeon          | Intel compiler       | OpenMPI                             |
| Desktop PC           | Linux (ubuntu 16.04)              | AMD Ryzen           | GNU compiler         | OpenMPI                             |
| Desktop PC           | Linux (ubuntu 16.04)              | AMD Ryzen           | PGI compiler         | OpenMPI                             |
| Desktop PC           | Linux (ubuntu 16.04)              | Intel Core-i7       | GNU compiler         | OpenMPI                             |
| Desktop PC           | Windows (7, 10)                   | Intel Core-i7       | GNU compiler (mingw) | Microsoft MPI                       |
| Raspberry PI 3 B+    | Linux (raspbian 32bit)            | ARM Cortex-A53      | GNU compiler         | OpenMPI                             |
| Notebook PC          | macOS Mojave                      | Intel Core i7       | GNU Compiler         | OpenMPI                             |



