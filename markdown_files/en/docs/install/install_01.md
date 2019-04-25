
# Operating Environment

## Required software

To install this software, the following software programs must have been installed in the environment where this software is to be installed. For information on how to install these software programs, refer to their installation manuals.

### C, C++ and Fortran90 compilers

C, C++, and Fortran90 compilers are required to install this software.

### MPI

This software executes parallel processing via MPI and requires an MPI library that compiles wihh the MPI-1 standards. Representative free-of-charge libraries that implement MPI include MPICH and OpenMPI. OpenMPI and MPICH can be downloaded from the following website:

Open MPI: Open Source High Performance Computing

  - [https://www.open-mpi.org/](https://www.open-mpi.org/)

High-Performance Portable MPI

  - [http://www.mpich.org/](http://www.mpich.org/)

### METIS

The domain decomposition utilities of this software use the METIS libraries to enable domain decomposition using pMETIS and kMETIS. METIS is required to use these domain decomposition functions. Supported versions of METIS are the newest version Ver.5 series and previous version Ver.4 series. 

For environments where METIS is not installed, domain decomposition is still possible using the RCB algorithm.

METIS - Serial Graph Partitioning and Fill-reducing Matrix Ordering

  - [http://glaros.dtc.umn.edu/gkhome/metis/metis/overview](http://glaros.dtc.umn.edu/gkhome/metis/metis/overview)


### ParMETIS

We plan to use the ParMETIS library as the parallel domain decomposition utilities for this software.

ParMETIS is not required at present.

ParMETIS - Parallel Graph Partitioning and Fill-reducing Matrix Ordering

  - [http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview](http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview)

### HEC-MW

This software uses the HEC-MW library developed by the "Revolutionary Simulation Software" and "Research and Development of Innovative Simulation Software" projects.

HEC-MW comes bundled with the FrontISTR archive file, and is automatically compiled when this software is installed, so there is no need to install HEC-MW separately.

### REVOCAP\_Refiner

This software is compatible with the REVOCAP\_Coupler coupled analysis tool developed by the "Research and Development of Innovative Simulation Software" project.
REVOCAP_Coupler is required to use the coupled analysis function. REVOCAP_Coupler can
be downloaded from the following website:

  - [http://www.multi.k.u-tokyo.ac.jp/FrontISTR/](http://www.multi.k.u-tokyo.ac.jp/FrontISTR/)

### REVOCAP\_Coupler

This software is compatible with the REVOCAP\_Coupler coupled analysis tool developed by the "Research and Development of Innovative Simulation Software" project.REVOCAP\_Coupler is required to use the coupled analysis function. REVOCAP\_Coupler can be downloaded from the following website:

  - [http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php](http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php)

### LAPACK/BLAS

This software is implemented a function of estimating condition number of preconditioned matrix.

When you use this function, LAPACK and BLAS libraries are required.

Reference implements of LAPACK can be downloaded from the following website:

  - [http://www.netlib.org/lapack/](http://www.netlib.org/lapack/)

Reference implements of BLAS can be downloaded from the following website:

  - [http://www.netlib.org/blas/](http://www.netlib.org/blas/)

OpenBLAS is compatible, fast and Open-Sourced implements of LAPACK/BLAS. OpenBLAS can be downloaded from the following website:

  - [http://www.openblas.net/](http://www.openblas.net/)

If Intel MKL is installed, it is not necessary to install above software.

### MUMPS

This software is compatible with a public domain parallel direct solver MUMPS (a MUltifrontal Massively Parallel sparse direct Solver). MUMPS is based on public domain software developed during the Esprit IV European project PARASOL (1996-1999). Since this first public domain version in 1999, research and developments have been supported by the following institutions: CERFACS, CNRS, ENS Lyon, INPT(ENSEEIHT)-IRIT, INRIA, and University of Bordeaux. MUMPS can be downloaded from the following website:

  - [http://mumps.enseeiht.fr/](http://mumps.enseeiht.fr/)

### ScaLAPACK

Therefore this software doesn't use this directly, MUMPS needs ScaLAPACK for compiling. ScaLAPACK can be downloaded from the following website:

  - [http://www.netlib.org/scalapack/](http://www.netlib.org/scalapack/)

If Intel MKL is installed, it is not necessary to install above software.

### ML

This software is compatible with multigrid preconditioner package ML (Multi-Level Preconditioner). ML is one of the packages developed under Trilinos project at Sandia National Laboratories. ML can be downloaded from the following website:

  - [https://trilinos.org/](https://trilinos.org/)

### Intel MKL（Math Kernel Library）

The contact analysis module of this software uses Intel MKL. If Intel MKL has not been installed in the environment where this software is to be installed, some of the contact analysis functions cannot be used.

## Operation verification environment

Operations of this software have been verified in the following environment. However, if the software programs (described above) required for installing this software have been installed, this software should operate normally even in environments other than the environment shown below.

### Operation verification environment

| Environment<br/>(operating system) | Compiler | Parallel processing<br/>environment |
|:--|:--|:--|
| K computer | Fujitsu Compiler | Fujitsu MPI |
| EARTH SIMULATOR (ES3) | NEC Compiler | NEC MPI |
| Intel Xeon Cluster<br> CentOS 7 | Intel Compiler | Intel MPI |
| Intel Xeon Cluster<br> RedHat Enterprise Linux 7 | Intel Compiler | OpenMPI |
| Intel Xeon Cluster<br> SUSE Linux Enterprise 10 | Intel Compiler | SGI MPT |
| AMD Ryzen PC<br> ubuntu 16.04 | GNU Compiler | OpenMPI-1.10.2|
| AMD Ryzen PC<br> ubuntu 16.04 | PGI Compiler | OpenMPI-1.10.2|
| AMD Ryzen PC<br> ubuntu 18.04 | GNU Compiler | OpenMPI-2.1.1|
| Intel Core i7 PC<br> ubuntu 16.04 | GNU Compiler | OpenMPI-1.10.2|
| Intel Core i7 PC<br> ubuntu 18.04 | GNU Compiler | OpenMPI-2.1.1|
| PC<br> Windows 7 <br> Windows 10 | GNU Compiler | Microsoft MPI-8.1 |
| SBC<br> Raspberry Pi 3| GNU Compiler | OpenMPI-2.0.2 |

