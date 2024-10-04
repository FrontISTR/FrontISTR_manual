<!-- include, libの順に記載する -->

## Appendix

### List of `Makefile.conf` Variables

#### Setting related to MPI

| Variable name | Description                                     | Default |
|---------------|-------------------------------------------------|---------|
| MPIDIR        | This variable specifies the path to the directory where MPI has been installed. If an MPI compatible compiler automatically refers to the path, there is no need to set this variable together with the following variables.| None |
| MPIBINDIR     | This variable specifies the path to the directory where MPI executable files have been installed.| None |
| MPIINCDIR     | This variable specifies the path to the directory where MPI header files have been installed.|.|
| MPILIBDIR     | This variable specifies the path to the directory where MPI libraries have been installed.|.|
| MPILIBS       | This variable specifies the MPI library that will be linked to C and Fortran90 object files.|None|

#### Setting related to the installation directory

| Variable name | Description                                      | Default     |
|---------------|--------------------------------------------------|-------------|
| PREFIX        | This variable specifies the path to the directory where this software is to be installed. | `$(HOME)/FrontISTR` |
| BINDIR        | This variable specifies the path to the directory where the executable files of this software are to be installed. | `$(PREFIX)/bin` |
| INCLUDEDIR    | This variable specifies the path to the directory where the header files of this software are to be installed. Normally, there is no need to change the value of this variable from the default value. | `$(PREFIX)/include` |
| LIBDIR        | This variable specifies the path to the directory where the libraries of this software are to be installed. Normally, there is no need to change the value of this variable from the default value. | `$(PREFIX)/lib` |

#### Settings related to METIS

| Variable name | Description                                      | Default      |
|---------------|--------------------------------------------------|--------------|
| METISDIR      | This variable specifies the path to the directory where METIS has been installed. | `$(HOME)/metis` |
| METISINCDIR   | This variable specifies the path to the directory where the header files (such as `metis.h`) of METIS have been installed. Normally, there is no need to change the value of this variable from the default value. | `$(METISDIR)/include` |
| METISLIBDIR   | This variable specifies the path to the directory where the library (`libmetis.a`) of METIS has been installed. Normally, ther is no need to change the value of this variable from the default value.| `$(METISDIR)/lib` |

#### Settings related to REVOCAP_Refiner

| Variable name | Description                                        | Default                 |
|---------------|----------------------------------------------------|-------------------------|
| REFINERDIR | This variable specifies the path to the directory where REVOCAP_Refiner has been installed. | `$(HOME)/REVOCAP_Refiner` |
| REFINERINCDIR | This variable specifies the path to the directory where REVOCAP_Refiner header files have been installed. Normally, there is no need to change the value of this variable from the default value. | `$(REFINERDIR)/include` |
| REFINERLIBDIR | This variable specifies the path to the directory where REVOCAP_Refiner libraries have been installed. Normally, there is no need to change the value of this variable from the default value.| `$(REFINERDIR)/lib` |

#### Settings related to REVOCAP_Coupler

| Variable name | Description                                        | Default                |
|---------------|----------------------------------------------------|------------------------|
| REVOCAPDIR | This variable specifies the path to the directory where REVOCAP_Coupler has been installed. | `$(HOME)/REVOCAP_Coupler` |
| REVOCAPINCDIR | This variable specifies the path to the directory where REVOCAP_Coupler header files have been installed. Normally, there is no need to change the value of this variable from the default value. | `$(REVOCAPDIR)/include` |
| REVOCAPLIBDIR | This variable specifies the path to the directory where REVOCAP_Coupler libraries have been installed. Normally, there is no need to change the value of this variable from the default value. | `$(REVOCAPDIR)/lib` |

#### Settings related to MUMPS

| Variable name | Description                                        | Default                 |
|---------------|----------------------------------------------------|-------------------------|
| MUMPSDIR | This variable specifies the path to the directory where MUMPS has been installed. | `$(HOME)/MUMPS` |
| MUMPSINCDIR | This variable specifies the path to the directory where MUMPS header files have been installed. Normally, there is no need to change the value of this variable from the default value. | `$(MUMPSDIR)/include` |
| MUMPSLIBDIR | This variable specifies the path to the directory where MUMPS libraries have been installed. Normally, there is no need to change the value of this variable from the default value. | `$(MUMPSDIR)/lib` |

#### Settins related to ML

| Variable name | Description                                          | Default                |
|---------------|------------------------------------------------------|------------------------|
| MLDIR | This variable specifies the path to the directory where ML is installed. | `$(HOME)/trilinos` |
| MLINCDIR | This variable specivies the path to the directory where ML header files are installed. Normally, there is no need to change the value of this variable from the default value. | `$(MLDIR)/include` |
| MLLIBDIR | This variable specivies the path to the directory where ML libraries are installed. Normally, there is no need to change the value of this variable from the default value. | `$(MLDIR)/lib` |

#### Settings related to the C compiler

| Variable name | Description                                         | Default               |
|---------------|-----------------------------------------------------|-----------------------|
| CC | This variable specifies the C compiler start command | `mpicc` |
| CFLAGS | This variable specifies the option to be assigned to the C compiler.  Normally, there is no need to change the value of this variable from the default value. | なし |
| LDFLAGS | This variable specifies the option to be assigned to the C linker.  Normally, there is no need to change the value of this variable from the default value.  However, when REVOCAP_Refiner (written in C++) is to be used and C compiler is used for linking C programs, C++ standard library (e.g. -lstdc++) needs to be specified here. | `-lm` |
| OPTFLAGS | This variable specifies the optimization option (or another option) to be assigned to the C compiler.| `-O3` |
| CLINKER | This variable specifies the linker command for C program. This is used when, for example, REVOCAP_Refiner (written in C++) is to be used and C++ compiler needs to be used for linking C programs with C++ libraries.| `$(CC)` |

#### Settings related to the C++ compiler

| Variable name | Description                                       | Default                  |
|---------------|---------------------------------------------------|--------------------------|
| CPP | This variable specifies the C++ compiler start command. | `mpic++` |
| CPPFLAGS | This variable specifies the option to be assigned to the C++ compiler.  Normally, there is no need to change the value of this variable from the default value.  However, if Boost Libraries are not automatically referenced from the C++ compiler, use the -I option to specify the directory that contains the include files.| `-DMPICH_IGNORE_CXX_SEEK` (Note: This is required for Intel compilers.) |
| CPPLDFLAGS | This variable specifies the option to be assigned to the C++ linker. Normally, there is no need to change the value of this variable from the default value.| None |
| CPPOPTFLAGS | This variable specifies the optimization option (or another option) to be assigned to the C++ compiler. | `-O3` |

#### Settings related to Fortran90 compiler

| Variable name | Description                                         | Default                 |
|---------------|-----------------------------------------------------|-------------------------|
| F90 | This variable specifies the Fortran90 compiler start command. | `mpif90` |
| F90FLAGS | This variable specifies the option to be assigned to the Fortran90 compiler. Normally, there is no need to change the value of this variable from the default value. | `-DMPICH_IGNORE_CXX_SEEK` |
| F90LDFLAGS | This variable specifies the option to be assigned to the Fortran90 linker.  Normally, there is no need to change the value of this variable from the default value.  However, if Intel MKL is used, specify its link option. Also, when REVOCAP_Refiner (written in C++) is to be used and Fortran90 compiler is used for linking Fortran90 programs, C++ standard library (e.g. -lstdc++) needs to be specified here. | None |
| F90OPTFLAGS | This variable specifies the optimization option (or another option) to be assigned to the Fortran90 compiler. | `-O2` |
| F90LINKER | This variable specifies the linker command for Fortran90 program. This is used when, for example, REVOCAP_Refiner (written in C++) is to be used and C++ compiler needs to be used for linking Fortran90 programs with C++ libraries. (E.g. on K-computer, “mpiFCCpx --linkfortran” needs to be specified.)| `$(F90)` |

#### Settings related to UNIX commands

| Variable name | Description                                        | Default                 |
|---------------|----------------------------------------------------|-------------------------|
| MAKE | This variable specifies the make start command. If options are required, specify them together. Normally, there is no need to change the value of this variable from the default value. | `make` |
| AR | This variable specifies the command for creating or changing an archive file. If options are required, specify them together. Normally, there is no need to change the value of this variable from the default value. | `ar ruv` |
| CP | This variable specifies the command for copying files or directories. If options are required, specify them together. Normally, there is no need to change the value of this variable from the default value. | `cp -f` |
| RM | This variable specifies the command for deleting files or directories. If options are required, specify them together. Normally, there is no need to change the value of this variable from the default value. | `rm -f` |
| MKDIR | This variable specifies the command for creating directories. If options are required, specify them together. Normally, there is no need to change the value of this variable from the default value. | `mkdir -p` |
| MV | This variable specifies the command for moving files or directories. If options are required, specify them together. Normally, there is no need to change the value of this variable from the default value. | `mv` |

### Example of Makefile.conf

```
# MPI
MPIDIR    =
MPIBINDIR =
MPILIBDIR =
MPIINCDIR =
MPILIBS   =

# for install option only
PREFIX     = $(HOME)/FrontISTR
BINDIR     = $(PREFIX)/bin
LIBDIR     = $(PREFIX)/lib
INCLUDEDIR = $(PREFIX)/include

# Metis
METISDIR    = $(HOME)/Metis-4.0
METISLIBDIR = $(METISDIR)
METISINCDIR = $(METISDIR)/Lib

# Refiner
REFINERDIR    = $(HOME)/REVOCAP_Refiner-1.1.0
REFINERINCDIR = $(REFINERDIR)/Refiner
REFINERLIBDIR = $(REFINERDIR)/lib/x86_64-linux

# Coupler
REVOCAPDIR    = $(HOME)/REVOCAP_Coupler-1.6.2
REVOCAPINCDIR = $(REVOCAPDIR)/librcap
REVOCAPLIBDIR = $(REVOCAPDIR)/librcap

# MUMPS
MUMPSDIR    = $(HOME)/MUMPS_4.10.0
MUMPSINCDIR = $(MUMPSDIR)/include
MUMPSLIBDIR = $(MUMPSDIR)/lib

# ML
MLDIR    = $(HOME)/trilinos/11.8.1/ml
MLINCDIR = $(MLDIR)/include
MLLIBDIR = $(MLDIR)/lib

# C compiler settings
CC       = mpiicc
CFLAGS   =
LDFLAGS  = -lm
OPTFLAGS = -O3
CLINKER  = mpiicc

# C++ compiler settings
CPP         = mpiicpc
CPPFLAGS    = -DMPICH_IGNORE_CXX_SEEK -I$(HOME)/include
CPPLDFLAGS  =
CPPOPTFLAGS = -O3

# Fortran compiler settings
F90         = mpiifort
F90FLAGS    =
F90LDFLAGS  = -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -liomp5
F90OPTFLAGS = -O2
F90LINKER   = mpiifort
```

### Notes on K-computer and Fujitsu FX10

This version includes tuned codes for K-computer and Fujitsu FX10. However, in order to maximize the performance, a part of the source code needs to be changed for corresponding environment.

File to be changed:

`hecmw1/src/solver/solver_33/hecmw_tuning_fx.f90`

Changes:

Set the value of parameter `TotalSectorCacheSize` defined in the file to

- 12 on K-computer,
- 24 on FX10.

Initially, the parameter is set for K-computer.
