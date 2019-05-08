## Appendix : Example of installation procedure to Windows10(Makefile.conf)

We will explain how to install this software and how to build external libraries required this software on Windows10.

More information for building each libraries, refer to their installation manuals.

### Preparation

At first, install the basic build toolchains and libraries as follows.

#### Installation of compilers and toolchains for Windows

First, install development environment. Development environment uses MSYS2 in this example.

[https://www.msys2.org](https://www.msys2.org/)

Download 64bit installer named `msys2-x86_64-xxxxxxxx.exe` (xxxxxxxx is version number) and install it.

#### Installing binary package

Finished to install above software, run windows command prompt named `MSYS2 MinGW 64-bit`, then install other required software.

```
(MINGW64) pacman -S base-devel mingw-w64-x86_64-toolchain \
            mingw-w64-x86_64-cmake \
            mingw-w64-x86_64-binutils \
            mingw-w64-x86_64-perl \
            git
```

Please check compilers works propery as follows.

```
(MINGW64) which gcc g++ gfortran
/mingw64/bin/gcc
/mingw64/bin/g++
/mingw64/bin/gfortran
```

### Installing libraries


Compile and install required libraries this software. Working directory is `$HOME/work`, destination directory for install is `$HOME/local`.

And add `$HOME/local/bin` to PATH environment variable as follows.


```
(MINGW64) cd $HOME
(MINGW64) mkdir work
(MINGW64) mkdir -p local/bin local/lib local/include
(MINGW64) export PATH=$HOME/local/bin:$PATH
```

#### Installing MPI

In this example, MPI libraries and runtime uses Microsoft MPI.

You can download runtime (`msmpisetup.exe`) and SDK (`msmpisdk.msi`) from the following URL.

[Download Microsoft MPI v10.0](https://www.microsoft.com/en-us/download/details.aspx?id=57467)

##### Generating .a format library file


To link Microsoft MPI with gcc/gfortran provided from MinGW-w64, convert library format from DLL to .a.

```
(MINGW64) cd $HOME/local/lib
(MINGW64) gendef /c/Windows/System32/msmpi.dll
(MINGW64) dlltool -d msmpi.def -l libmsmpi.a -D /c/Windows/System32/msmpi.dll
(MINGW64) ls
libmsmpi.a msmpi.def
```

##### Modifying header files provided from MS-MPI

Copy original header files from installation directory to current directory.

```
(MINGW64) cd $HOME/local/include
(MINGW64) cp /c/Program\ Files\ \(x86\)/Microsoft\ SDKs/MPI/Include/*.h .
(MINGW64) cp /c/Program\ Files\ \(x86\)/Microsoft\ SDKs/MPI/Include/x64/*.h .
(MINGW64) ls
mpi.h  mpif.h  mpifptr.h  mpio.h  mspms.h  pmidbg.h
```


#### Downloads

Downloads the following software and save it to working directory `$HOME/work`.

| Software | Link |
|:--|:--|
| REVOCAP\_Refiner-1.1.04.tar.gz | https://www.frontistr.com/ |
| FrontISTR\_V50.tar.gz | https://www.frontistr.com/ |
| OpenBLAS-0.2.20.tar.gz | http://www.openblas.net/ |
| metis-5.1.0.tar.gz | http://glaros.dtc.umn.edu/gkhome/metis/metis/download |
| scalapack-2.0.2.tgz | http://www.netlib.org/scalapack/ |
| MUMPS\_5.1.2.tar.gz | http://mumps.enseeiht.fr/ |
| trilinos-12.14.1-Source.tar.bz2 | https://trilinos.org/download/ |

#### Compiling REVOCAP\_Refiner

```
(MINGW64) cd $HOME/work
(MINGW64) tar xvf REVOCAP\_Refiner-1.1.04.tar.gz
(MINGW64) cd REVOCAP\_Refiner-1.1.04
(MINGW64) make
(MINGW64) cp lib/x86\_64-linux/libRcapRefiner.a $HOME/local/lib
(MINGW64) cp Refiner/rcapRefiner.h $HOME/local/include
```

#### Installing OpenBLAS

```
(MINGW64) pacman -S mingw-w64-x86_64-openblas
```

#### Compiling METIS

```
(MINGW64) cd $HOME/work
(MINGW64) tar xvf metis-5.1.0.tar.gz
(MINGW64) cd metis-5.1.0
```

Correct the following file to fit MinGW environment.

- Makefile
- GKlib/gk_arch.h
- GKlib/getopt.c

```
% vim Makefile
line:60 change from
cd $(BUILDDIR) && cmake $(CURDIR) $(CONFIG_FLAGS)
to
cd $(BUILDDIR) && cmake -G "MSYS Makefiles" $(CURDIR) $(CONFIG_FLAGS)
```

```
(MINGW64) vim GKlib/gk_arch.h
line:44 remove
  #include <sys/resource.h>
```

```
(MINGW64) vim GKlib/gk_getopt.h
line:54 remove following lines
/* Function prototypes */
extern int gk_getopt(int __argc, char **__argv, char *__shortopts);
extern int gk_getopt_long(int __argc, char **__argv, char *__shortopts,
              struct gk_option *__longopts, int *__longind);
extern int gk_getopt_long_only (int __argc, char **__argv,
              char *__shortopts, struct gk_option *__longopts, int *__longind);
```

```
(MINGW64) make config prefix=$HOME/local/ cc=gcc openmp=1
(MINGW64) make
(MINGW64) make install
```

#### Compiling ScaLAPACK

```
(MINGW64) cd $HOME/work
(MINGW64) tar xvf scalapack-2.0.2.tgz
(MINGW64) cd scalapack-2.0.2
```

Copy template `SLmake.inc.example` to `SLmake.inc`. Then edit `SLmake.inc` as follows.

```
(MINGW64) cp SLmake.inc.example SLmake.inc
(MINGW64) vi SLmake.inc

#
#  The fortran and C compilers, loaders, and their flags
#

FC            = gfortran -fno-range-check
CC            = gcc
NOOPT         = -O0
FCFLAGS       = -O3 -I$(HOME)/local/include
CCFLAGS       = -O3 -I$(HOME)/local/include
FCLOADER      = $(FC)
CCLOADER      = $(CC)
FCLOADFLAGS   = $(FCFLAGS) -L$(HOME)/local/lib -lmsmpi
CCLOADFLAGS   = $(CCFLAGS) -L$(HOME)/local/lib -lmsmpi

#
#  BLAS, LAPACK (and possibly other) libraries needed for linking test programs
#

BLASLIB       = -lopenblas
LAPACKLIB     = -lopenblas
LIBS          = $(LAPACKLIB) $(BLASLIB)
```

```
(MINGW64) make
(MINGW64) cp libscalapack.a $HOME/local/lib
```
Finished to make, then copy libray.

Although an error is displayed at the end of compilation, ignore it.

#### Compiling MUMPS

```
(MINGW64) cd $HOME/work
(MINGW64) tar xvf MUMPS_5.1.2.tar.gz
(MINGW64) cd MUMPS_5.1.2
(MINGW64) cp Make.inc/Makefile.inc.generic Makefile.inc
```

Change the following parts of copied `Makefile.inc`.

```
(MINGW64) vi Makefile.inc
(MINGW64) cp Make.inc/Makefile.inc.generic Makefile.inc
(MINGW64) vi Makefile.inc
LMETISDIR = $(HOME)/local
IMETIS    = -I$(LMETISDIR)/include
LMETIS    = -L$(LMETISDIR)/lib -lmetis

ORDERINGSF  = -Dmetis -Dpord

CC      = gcc
FC      = gfortran -fno-range-check
FL      = gfortran

LAPACK = -lopenblas

SCALAP  = -L$(HOME)/local/lib -lscalapack

INCPAR = -I$(HOME)/local/include

LIBPAR  = $(SCALAP) $(LAPACK) -L$(HOME)/local/lib -lmsmpi

LIBBLAS = -lopenblas

LIBOTHERS = -lpthread -fopenmp
```

Then execute `make`.

```
(MINGW64) make
(MINGW64) cp lib/*.a $HOME/local/lib
(MINGW64) cp include/*.h $HOME/local/include
```

#### Compiling Trilinos ML

```
(MINGW64) cd $HOME/work
(MINGW64) tar xvf trilinos-12.14.1-Source.tar.gz
(MINGW64) cd trilinos-12.14.1-Source
(MINGW64) mkdir build
(MINGW64) cmake -G "MSYS Makefiles" \
        -DCMAKE_INSTALL_PREFIX="$HOME/local" \
        -DCMAKE_CXX_FLAGS="-I$HOME/local/include" \
        -DCMAKE_C_FLAGS="-I$HOME/local/include" \
        -DBLAS_LIBRARY_NAMES="openblas" \
        -DLAPACK_LIBRARY_NAMES="openblas" \
        -DMPI_USE_COMPILER_WRAPPERS=OFF \
        -DMPI_C_HEADER_DIR="$HOME/local/include" \
        -DMPI_CXX_HEADER_DIR="$HOME/local/include" \
        -DTPL_ENABLE_MPI=ON \
        -DTrilinos_ENABLE_OpenMP=ON \
        -DTrilinos_ENABLE_ML=ON \
        -DTrilinos_ENABLE_Zoltan=ON \
        -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=OFF \
        ..
(MINGW64) make
(MINGW64) make install
```

### Compiling FrontISTR

Finishing compiling above libraries, compile FrontISTR.

```
(MINGW64) cd $HOME/work
(MINGW64) tar xvf FrontISTR_V50.tar.gz
(MINGW64) cd FrontISTR
```

#### Editing Makefile.conf

Copy template as `Makefile.conf.org` to `Makefile.conf`. Then edit `Makefile.conf` as follows.

```
(MINGW64) cp Makefile.conf.org Makefile.conf
(MINGW64) vi Makefile.conf
##################################################
#                                                #
#     Setup Configulation File for FrontISTR     #
#                                                #
##################################################

# MPI
MPIDIR         = $(HOME)/local
MPIBINDIR      = "/c/Program\ Files/Microsoft\ MPI/Bin/"
MPILIBDIR      = $(MPIDIR)/lib
MPIINCDIR      = $(MPIDIR)/include
MPILIBS        = -lmsmpi

# for install option only
PREFIX         = $(HOME)/FrontISTR
BINDIR         = $(PREFIX)/bin
LIBDIR         = $(PREFIX)/lib
INCLUDEDIR     = $(PREFIX)/include

# Metis
METISDIR       = $(HOME)/local
METISLIBDIR    = $(METISDIR)/lib
METISINCDIR    = $(METISDIR)/include
HECMW_METIS_VER= 5

# ParMetis
PARMETISDIR    = $(HOME)/local
PARMETISLIBDIR = $(PARMETISDIR)/lib
PARMETISINCDIR = $(PARMETISDIR)/include

# Refiner
REFINERDIR     = $(HOME)/local
REFINERINCDIR  = $(REFINERDIR)/include
REFINERLIBDIR  = $(REFINERDIR)/lib

# Coupler
REVOCAPDIR     = $(HOME)/local
REVOCAPINCDIR  = $(REVOCAPDIR)/include
REVOCAPLIBDIR  = $(REVOCAPDIR)/lib

# MUMPS
MUMPSDIR       = $(HOME)/local
MUMPSINCDIR    = $(MUMPSDIR)/include
MUMPSLIBDIR    = $(MUMPSDIR)/lib
MUMPSLIBS      = -ldmumps -lmumps_common -lpord -L$HOME/local/lib -lscalapack

# MKL PARDISO
MKLDIR     = $(HOME)/
MKLINCDIR  = $(MKLDIR)/include
MKLLIBDIR  = $(MKLDIR)/lib

# ML
MLDIR          = $(HOME)/local
MLINCDIR       = $(MLDIR)/include
MLLIBDIR       = $(MLDIR)/lib
MLLIBS         = -lml -lzoltan -lws2_32

# C compiler settings
CC             = gcc -fopenmp
CFLAGS         = -D_WINDOWS
LDFLAGS        = -lstdc++ -lm
OPTFLAGS       = -O3

# C++ compiler settings
CPP            = g++ -fopenmp
CPPFLAGS       = -D_WINDOWS
CPPLDFLAGS     =
CPPOPTFLAGS    = -O3

# Fortran compiler settings
F90            = gfortran -fopenmp -fno-range-check
F90FLAGS       =
F90LDFLAGS     = -lstdc++ -lopenblas
F90OPTFLAGS    = -O2
F90FPP         = -cpp
F90LINKER      = gfortran -fopenmp

MAKE           = make
AR             = ar ruv
MV             = mv -f
CP             = cp -f
RM             = rm -f
MKDIR          = mkdir -p
```

#### Executing setup.sh

Finished to edit `Makefile.conf`, then execute `setup.sh`.

```
(MINGW64) ./setup.sh -p --with-tools --with-refiner \
             --with-metis --with-mumps --with-lapack --with-ml
```

#### Executing make

Execute make command.

```
(MINGW64) make
```

#### Executing `make install`


```
(MINGW64) make install
```

FrontISTR will be installed to `$(HOME)/FrontISTR/bin`.

#### Testing FrontISTR

Run sample case in the `tutorial` directory and check running of FrontISTR.

```
(MINGW64) cd $HOME/work/FrontISTR/tutorial
(MINGW64) cd 01_elastic_hinge
(MINGW64$) $HOME/FrontISTR/bin/fistr1
 Step control not defined! Using default step=1
 fstr_setup: OK
 Start visualize PSF 1 at timestep 0
 
 loading step=    1
 sub_step= 1,   current_time=  0.0000E+00, time_inc=  0.1000E+01
 loading_factor=    0.0000000   1.0000000
### 3x3 BLOCK CG, SSOR, 1
      1    1.903375E+00
      2    1.974378E+00
      3    2.534627E+00
      4    3.004045E+00
      5    3.202633E+00
      6    3.203864E+00
...
...
```

When finished analysis, displayed message as follows.

```
...
...
   2966    1.143085E-08
   2967    1.078272E-08
   2968    1.004759E-08
   2969    9.372882E-09
### Relative residual = 9.39169E-09

### summary of linear solver
      2969 iterations      9.391687E-09
    set-up time      :     4.108060E-01
    solver time      :     6.506822E+01
    solver/comm time :     4.342469E-01
    solver/matvec    :     1.923199E+01
    solver/precond   :     2.688405E+01
    solver/1 iter    :     2.191587E-02
    work ratio (%)   :     9.933263E+01

 Start visualize PSF 1 at timestep 1
### FSTR_SOLVE_NLGEOM FINISHED!

 ====================================
    TOTAL TIME (sec) :     74.93
           pre (sec) :      1.86
         solve (sec) :     73.07
 ====================================
 FrontISTR Completed !!
```

#### Supplement

To run in an environment where MinGW is not installed, you need to place following files in the same directory as FrontISTR `fistr1.exe`.

- libwinpthread-1.dll
- libgfortran-3.dll
- libgcc_s_seh-1.dll
- libgomp-1.dll
- libstdc++-6.dll
- libquadmath-0.dll

You can find these libraries from 

```
C:\\mingw64\bin
```

You also need to setup Microsoft MPI runtime (`MSMpiSetup.exe`).
