# Appendix Example of installation procedure to Ubuntu16.04(Makefile.conf)

We will explain how to install this software and how to build external libraries required this software on Ubuntu16.04.

More information for building each libraries, refer to their installation manuals.

## Preparation

At first, install the basic build toolchains and libraries as follows.

```
$ sudo apt install build-essential gfortran cmake openmpi-bin libopenmpi-dev
```

Please check compilers and compiler wrappers for MPI works propery.

```
$ which gcc g++ gfortran mpicc mpic++ mpifort
/usr/bin/gcc
/usr/bin/g++
/usr/bin/gfortran
/usr/bin/mpicc
/usr/bin/mpic++
/usr/bin/mpifort
```

## Installing libraries

Compile and install required libraries this software. Working directory is `$HOME/work`, destination directory for install is `$HOME/local`.

And add `$HOME/local/bin` to PATH environment variable as follows.


```
$ cd $HOME
$ mkdir work
$ mkdir -p local/bin local/lib local/include
$ export PATH=$HOME/local/bin:$PATH
```

### Downloads

Downloads the following software and save it to working directory `$HOME/work`.

| Software | Link |
|:--|:--|
| REVOCAP\_Refiner-1.1.04.tar.gz | http://www.multi.k.u-tokyo.ac.jp/FrontISTR/ |
| FrontISTR\_V50.tar.gz | http://www.multi.k.u-tokyo.ac.jp/FrontISTR/ |
| OpenBLAS-0.2.20.tar.gz | http://www.openblas.net/ |
| metis-5.1.0.tar.gz | http://glaros.dtc.umn.edu/gkhome/metis/metis/download |
| scalapack-2.0.2.tgz | http://www.netlib.org/scalapack/ |
| MUMPS\_5.1.2.tar.gz | http://mumps.enseeiht.fr/ |
| trilinos-12.12.1-Source.tar.bz2 | https://trilinos.org/download/ |

### Compiling REVOCAP\_Refiner

```
$ cd $HOME/work
$ tar xvf REVOCAP\_Refiner-1.1.04.tar.gz
$ cd REVOCAP\_Refiner-1.1.04
$ make
$ cp lib/x86_64-linux/libRcapRefiner.a $HOME/local/lib
$ cp Refiner/rcapRefiner.h $HOME/local/include
```

### Compiling OpenBLAS

```
$ cd $HOME/work
$ tar xvf OpenBLAS-0.2.20.tar.gz
$ make BINARY=64 NO_SHARED=1 USE_OPENMP=1
$ make PREFIX=$HOME/local install
```

### Compiling METIS

```
$ cd $HOME/work
$ tar xvf metis-5.1.0.tar.gz
$ cd metis-5.1.0
$ make config prefix=$HOME/local cc=gcc openmp=1
$ make
$ make install
```

### Compiling ScaLAPACK

```
$ cd $HOME/work
$ tar xvf scalapack-2.0.2.tgz
$ cd scalapack-2.0.2
$ mkdir build
$ cmake -DCMAKE_INSTALL_PREFIX=$HOME/local \
        -DCMAKE_EXE_LINKER_FLAGS="-fopenmp" \
        -DBLAS_LIBRARIES=$HOME/local/lib/libopenblas.a \
        -DLAPACK_LIBRARIES=$HOME/local/lib/libopenblas.a \
        ..
$ make
$ make install
```

### Compiling MUMPS

```
$ cd $HOME/work
$ tar xvf MUMPS_5.1.2.tar.gz
$ cd MUMPS_5.1.2
$ cp Make.inc/Makefile.inc.generic Makefile.inc
```

Change the following parts of copied `Makefile.inc`.

```
$ vi Makefile.inc
$ cp Make.inc/Makefile.inc.generic Makefile.inc
$ vi Makefile.inc
LMETISDIR = $(HOME)/local
IMETIS    = -I$(LMETISDIR)/include
LMETIS    = -L$(LMETISDIR)/lib -lmetis

ORDERINGSF  = -Dmetis -Dpord

CC      = mpicc -fopenmp
FC      = mpifort -fopenmp
FL      = mpifort -fopenmp

LAPACK = -L$(HOME)/local/lib -lopenblas

SCALAP  = -L$(HOME)/local/lib -lscalapack

INCPAR =

LIBPAR  = $(SCALAP)

LIBBLAS = -L$(HOME)/local/lib -lopenblas
```

Then execute `make`.

```
$ make
$ cp lib/*.a $HOME/local/lib
$ cp include/*.h $HOME/local/include
```

### Compiling Trilinos ML

```
$ cd $HOME/work
$ tar xvf trilinos-12.12.1-Source.tar.gz
$ cd trilinos-12.12.1-Source
$ mkdir build
$ cmake -DCMAKE_INSTALL_PREFIX=$HOME/local \
        -DCMAKE_C_COMPILER=mpicc \
        -DCMAKE_CXX_COMPILER=mpic++ \
        -DCMAKE_Fortran_COMPILER=mpifort \
        -DTPL_ENABLE_MPI=ON \
        -DTPL_ENABLE_LAPACK=ON \
        -DTPL_ENABLE_SCALAPACK=ON \
        -DTPL_ENABLE_METIS=ON \
        -DTPL_ENABLE_MUMPS=ON \
        -DTrilinos_ENABLE_ML=ON \
        -DTrilinos_ENABLE_Zoltan=ON \
        -DTrilinos_ENABLE_OpenMP=ON \
        -DTrilinos_ENABLE_Amesos=ON \
        -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=OFF \
        -DBLAS_LIBRARY_DIRS=$HOME/local/lib \
        -DLAPACK_LIBRARY_DIRS=$HOME/local/lib" \
        -DSCALAPACK_LIBRARY_DIRS=$HOME/local/lib" \
        -DBLAS_LIBRARY_NAMES="openblas" \
        -DLAPACK_LIBRARY_NAMES="openblas" \
        -DSCALAPACK_LIBRARY_NAMES="scalapack" \
        ..
$ make
$ make install
```

## Compiling FrontISTR

Finishing compiling above libraries, compile FrontISTR.

```
$ cd $HOME/work
$ tar xvf FrontISTR_V50.tar.gz
$ cd FrontISTR
```

### Edit Makefile.conf

Copy template as `Makefile.conf.org` to `Makefile.conf`. Then edit `Makefile.conf` as follows.

```
$ cp Makefile.conf.org Makefile.conf
$ vi Makefile.conf
##################################################
#                                                #
#     Setup Configulation File for FrontISTR     #
#                                                #
##################################################

# MPI
MPIDIR         = /usr/lib/openmpi
MPIBINDIR      = /usr/bin
MPILIBDIR      = $(MPIDIR)/lib
MPIINCDIR      = $(MPIDIR)/include
MPILIBS        = -lmpi -lmpi_cxx -lmpi_mpifh

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
MLLIBS         = -lml -lamesos -ltrilinosss -lzoltan -lepetra -lteuchosremainder -lteuchosnumerics -lteuchoscomm -lteuchosparameterlist -lteuchoscore -ldmumps -lmumps_common -lpord -lmetis

# C compiler settings
CC             = mpicc -fopenmp
CFLAGS         =
LDFLAGS        = -lstdc++ -lm
OPTFLAGS       = -O3

# C++ compiler settings
CPP            = mpic++ -fopenmp
CPPFLAGS       =
CPPLDFLAGS     =
CPPOPTFLAGS    = -O3

# Fortran compiler settings
F90            = mpif90 -fopenmp
F90FLAGS       =
F90LDFLAGS     = -lstdc++ -L$(HOME)/local/lib -lopenblas
F90OPTFLAGS    = -O2
F90FPP         = -cpp
F90LINKER      = mpif90 -fopenmp

MAKE           = make
AR             = ar ruv
MV             = mv -f
CP             = cp -f
RM             = rm -f
MKDIR          = mkdir -p
```

### setup.shの実行

編集が完了したら、setup.sh を実行します。

```
$ ./setup.sh -p --with-tools --with-refiner \
             --with-metis --with-mumps --with-lapack --with-ml
```

### Executing make

Execute make command.

```
$ make
```

### Executing `make install`


```
$ make install
```

FrontISTR will be installed to `$(HOME)/FrontISTR/bin`.

### Testing FrontISTR

Run sample case in the `tutorial` directory and check running of FrontISTR.

```
$ cd $HOME/work/FrontISTR/tutorial
$ cd 01_elastic_hinge
$ $HOME/FrontISTR/bin/fistr1
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


