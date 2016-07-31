# Operating Environment

## Required software

To install this software, the following software programs must have been
installed in the environment where this software is to be installed. For
information on how to install these software programs, refer to their
installation manuals.

(1) C, C++, and Fortran90 compilers

C, C++, and Fortran90 compilers are required to install this software.

(1) Boost Libraries

Boost Libraries are required to compile the C++ source code of this
software. If Boost Libraries have not been installed in the environment
where this software is to be installed, they can be downloaded from the
following website:

　　<http://www.boost.org/>

(1) Intel MKL (Math Kernel Library)

The contact analysis module of this software uses Intel MKL. If Intel
MKL has not been installed in the environment where this software is to
be installed, some of the contact analysis functions cannot be used.

(1) MPI

This software executes parallel processing via MPI and so requires an
MPI library that complies with the MPI-1 standard. Representative
free-of-charge libraries that implement MPI include MPICH and OpenMPI.
MPICH can be downloaded from the following website:

http://www.mcs.anl.gov/research/projects/mpich2

(1) METIS

The domain decomposition utilities of this software use the METIS
libraries to enable domain decomposition using pMETIS and kMETIS. METIS
is required to use these domain decomposition functions. Supported
versions of METIS are the newest version Ver.5 series and previous
version Ver.4 series. However, if below mentioned MUMPS is to be used,
and METIS is to be used for ordering in MUMPS, Metis Ver.4 series has to
be installed since MUMPS supports only Ver.4 series of METIS. For
environments where METIS is not installed, domain decomposition is still
possible using the RCB algorithm. METIS can be downloaded from the
following website:

http://glaros.dtc.umn.edu/gkhome/views/metis/index.html

(1) ParMETIS

We plan to use the ParMETIS library as the parallel domain decomposition
utilities for this software.

ParMETIS is not required at present.

(1) HEC-MW

This software uses the HEC-MW library developed by the "Revolutionary
Simulation Software" and "Research and Development of Innovative
Simulation Software" projects. HEC-MW comes bundled with the FrontISTR
archive file, and is automatically compiled when this software is
installed, so there is no need to install HEC-MW separately.

(1) REVOCAP\_Refiner

This software is compatible with the "REVOCAP\_Refiner" mesh refinement
tool developed by the "Research and Development of Innovative Simulation
Software" project. REVOCAP\_Refiner is required to use the mesh
refinement function. REVOCAP\_Refiner can be downloaded from the
following website:

http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php

(1) REVOCAP\_Coupler

This software is compatible with the REVOCAP\_Coupler coupled analysis
tool developed by the "Research and Development of Innovative Simulation
Software" project. REVOCAP\_Coupler is required to use the coupled
analysis function. REVOCAP\_Coupler can be downloaded from the following
website:

http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php

\(10) MUMPS

This software is compatible with a public domain parallel direct solver
MUMPS (a MUltifrontal Massively Parallel sparse direct Solver). MUMPS is
based on public domain software developed during the Esprit IV European
project PARASOL (1996-1999). Since this first public domain version in
1999, research and developments have been supported by the following
institutions: CERFACS, CNRS, ENS Lyon, INPT(ENSEEIHT)-IRIT, INRIA, and
University of Bordeaux. MUMPS can be downloaded from the following
website:

http://graal.ens-lyon.fr/MUMPS/

\(11) ML

This software is compatible with multigrid preconditioner package ML
(Multi-Level Preconditioner). ML is one of the packages developed under
Trilinos project at Sandia National Laboratories. ML can be downloaded
from the following website:

<http://trilinos.org/packages/ml/>

## Operation verification environment

Operations of this software have been verified in the following
environment. However, if the software programs (described above)
required for installing this software have been installed, this software
should operate normally even in environments other than the environment
shown below.

Table 1: Operation verification environment

  --------------------------- ------------------ ---------------------------------
  Environment                 Compiler           Parallel processing environment

  (operating system)                             

  K computer                  Fujitsu Compiler   Fujitsu MPI

  EARTH SIMULATOR (ES2)       NEC Compiler       NEC MPI

  Intel Xeon Cluster          Intel Compiler     Intel MPI

  CentOS 5                                       

  AMD Opteron Cluster         Intel Compiler     OpenMPI

  RedHat Enterprise Linux 5                      

  Intel Itanium Cluster       Intel Compiler     Intel MPI

  SUSE Linux Enterprise 10                       

  AMD Opteron Cluster         Intel Compiler     MPICH 1.2.7p1

  CentOS 4.4                                     

  PC                          gnu Compiler       MPICH2-1.3.2p1

  Windows XP, Windows 7                          

  PC                          Intel Compiler     Intel MPI

  Windows XP x64                                 
  --------------------------- ------------------ ---------------------------------
