# FrontISTR v4.5�̃C���X�g�[�� (ubuntu 16.04 LTS)

�����ł́AFrontISTR��Ubuntu 16.04 LTS�Ŏ�y�ɍ\�z������@���Љ�܂��B

FrontISTR���\�z����ɂ́A�l�X�ȃ��C�u�������K�v�ɂȂ�܂����A�o�C�i���p�b�P�[�W�𗘗p���邱�ƂŎ�Ԃ��Ȃ��܂��B

�����ɏ�����Ă�����@�́AUbuntu 16.04 LTS�ɑΉ����܂��B

���C�u�������\�[�X����\�z����ꍇ�́A[�y�Q�l�z���C�u���������͂ō\�z������@](#build-from-source)���Q�l�ɂ��Ă��������B

# �͂��߂�

FrontISTR��[������w ���c������](http://www.multi.k.u-tokyo.ac.jp/)�ŊJ������Ă���A�{�i�I�ȍ\����̓v���O�����ł��B[FrontISTR������](http://www.multi.k.u-tokyo.ac.jp/FrontISTR/)����A������̈ē��⎑���A�\�t�g�E�F�A������ł��܂��B
�X�p�R������Windows�p�\�R���܂œ��������Ƃ��o����_�������̈�ł��B

# ����

�\��ubuntu 16.04 LTS���C���X�g�[�����AOS������\�ȏ�Ԃɂ��Ă��������B

# �_�E�����[�h

�ȉ��̃\�t�g����肵�Ă��������B

�\�t�g�E�F�A                 | �����
---------------------- | --------------------------------------------
FrontISTR_V45.tar.gz   | <http://www.multi.k.u-tokyo.ac.jp/FrontISTR>
REVOCAP_Refiner-1.1.04 | <http://www.multi.k.u-tokyo.ac.jp/FrontISTR>

# �K�v�ȃ��C�u�����̓���

## �o�C�i���p�b�P�[�W�̓���

��L�ȊO�̃\�t�g�̓o�C�i���p�b�P�[�W���瓱�����܂��B

```sh
% sudo apt install build-essensial
% sudo apt install libtrilinos-ml-dev
% sudo apt install libtrilinos-aztecoo-dev libtrilinos-zoltan-dev
% sudo apt install libopenblas-dev libmumps-dev libmetis-dev
```

## REVOCAP_Refiner�̍\�z

REVOCAP_Refiner���R���p�C�����܂��B

```sh
% tar xvf REVOCAP_Refiner-1.1.04.tar.gz
% cd REVOCAP_Refiner-1.1.04
% make
```

# FrontISTR�̍\�z

�K�v�ȃ��C�u�����̓������ς񂾂�FrontISTR���\�z���܂��B

FrontISTR�ŗL���ɂ���@�\��

- hecmw_part1�̈敪���c�[���Ȃǂ̃c�[���Q����
- REVOCAP_Refiner (���b�V���̍ו����@�\)
- MPI (PC�N���X�^���̕�����s���j
- OpenMP (�}���`�R�ACPU�𗘗p)
- METIS (���b�V���̗̈敪���̂��߂ɕK�v)
- MUMPS (���ږ@�\���o�[)
- LAPACK �iCG�@��GMRES�@��p�����O�����K�p��̏���������@�\�𗘗p�j
- Trilinos-ML �i�㐔�}���`�O���b�h�@�Ɋ�Â��O�����j

�ł��B�����̋@�\��L���ɂ����o�C�i�����쐬���܂��B

```sh
% tar xvf FrontISTR_V45.tar.gz
% cd FrontISTR_V45
```

�����`Makefile.am`��ҏW���\�z����K�v�̂Ȃ����������O���܂��B

```sh
% vi Makefile.am
PREFIX     = @prefix@
BINDIR     = @bindir@
LIBDIR     = @libdir@
INCLUDEDIR = @includedir@

MAKE       = @make@
AR         = @ar@
CP         = @cp@
RM         = @rm@
MV         = @mv@
RANLIB     = @ranlib@
MKDIR      = @mkdir@

all:
        @cd hecmw1 && $(MAKE)
        @cd fistr1 && $(MAKE)
#       @cd hecmw2 && $(MAKE)
#       @cd fistr2 && $(MAKE)
        @cd fistr  && $(MAKE)

clean:
        @cd hecmw1 && $(MAKE) clean
        @cd fistr1 && $(MAKE) clean
#       @cd hecmw2 && $(MAKE) clean
#       @cd fistr2 && $(MAKE) clean
        @cd fistr  && $(MAKE) clean

distclean:
        @cd hecmw1 && $(MAKE) distclean
        @cd fistr1 && $(MAKE) distclean
#       @cd hecmw2 && $(MAKE) distclean
#       @cd fistr2 && $(MAKE) distclean
        @cd fistr  && $(MAKE) distclean
        - $(RM) ./bin/*

install:
        if [ ! -d $(PREFIX) ]; then \
                $(MKDIR) $(PREFIX); \
        fi
        if [ ! -d $(BINDIR) ]; then \
                $(MKDIR) $(BINDIR); \
        fi
        @cd hecmw1 && $(MAKE) install
        @cd fistr1 && $(MAKE) install
#       @cd hecmw2 && $(MAKE) install
#       @cd fistr2 && $(MAKE) install
        @cd fistr  && $(MAKE) install
```

> `hecmw2`�����`fistr2`�͍\�z���܂���̂ŁA�R�����g�A�E�g���Ă��������B

## Makefile.conf�̕ҏW

```sh
% cp Makefile.conf.org Makefile.conf
% vi Makefile.conf
```

�ȉ��̓��e��`Makefile.conf`��ҏW���Ă��������B

```
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
MPILIBS        = -lmpi -lmpi_mpifh

# for install option only
PREFIX         = $(HOME)/FrontISTR
BINDIR         = $(PREFIX)/bin
LIBDIR         = $(PREFIX)/lib
INCLUDEDIR     = $(PREFIX)/include

# Metis
METISDIR       = /usr/lib/x86_64-linux-gnu
METISLIBDIR    = $(METISDIR)
METISINCDIR    = /usr/include
HECMW_METIS_VER= 5

# ParMetis
PARMETISDIR    = $(HOME)/ParMetis-3.1
PARMETISLIBDIR = $(PARMETISDIR)
PARMETISINCDIR = $(PARMETISDIR)/ParMETISLib

# Refiner
REFINERDIR     = $(HOME)/Software/REVOCAP_Refiner-1.1.04
REFINERINCDIR  = $(REFINERDIR)/Refiner
REFINERLIBDIR  = $(REFINERDIR)/lib/x86_64-linux

# Coupler
REVOCAPDIR     = $(HOME)/REVOCAP_Coupler
REVOCAPINCDIR  = $(REVOCAPDIR)/librcap
REVOCAPLIBDIR  = $(REVOCAPDIR)/librcap

# MUMPS
MUMPSDIR       = /usr
MUMPSINCDIR    = $(MUMPSDIR)/include
MUMPSLIBDIR    = $(MUMPSDIR)/lib

# MKL PARDISO
MKLDIR     = $(HOME)/
MKLINCDIR  = $(MKLDIR)/include
MKLLIBDIR  = $(MKLDIR)/lib

# ML
MLDIR          = /usr
MLINCDIR       = $(MLDIR)/include/trilinos
MLLIBDIR       = $(MLDIR)/lib/x86_64-linux-gnu
MLLIBS         = -ltrilinos_ml -ltrilinos_zoltan

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
F90LDFLAGS     = -lstdc++ -lopenblas
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

> ���̎菇�ŗp����METIS��Version5.1.0�ł��B`HECMW_METIS_VER = 5`���w�肵�Ă��������B

> gfortran�̃v���v���Z�b�T�w��� `-cpp`�ł��B`F90FPP = -cpp`���w�肵�Ă��������B

�ҏW���o������`setup.sh`�����s���Ă��������B

```sh
% ./setup.sh -p --with-tools --with-refiner --with-metis --with-mumps --with-lapack --with-ml
```

`setup.sh`�̎��s���ς񂾂�R���p�C�����ăo�C�i�����쐬���܂��B

```sh
% make
% make install
```

�\�z�����o�C�i�����C���X�g�[��������ƁA`$(HOME)/FrontISTR/bin`�ȉ���

```sh
% ls $HOME/FrontISTR/bin
fistr1  hec2rcap  hecmw_part1  hecmw_vis1  neu2fstr  rconv  rmerge
```

�Ȃǂ̃o�C�i�����R�s�[������s�ł����ԂɂȂ�܂��B

�ʏ�͂����܂ł̎菇�ŏ\���ł��B

---

# �y�Q�l�z���C�u���������͂ō\�z������@�@<a name="build-from-source">

FrontISTR���\�z����̂ɕK�v�ȃ��C�u������

- OpenMPI (MPI)
- OpenBLAS (LAPACK�j
- Metis
- MUMPS
- Scalapack
- Trilinos ML

�ł��B Ubuntu-16.04��ō\�z�����������܂��B

�������AMPI�̍\�z���@�ɂ��Ă͏Ȃ��܂��BOS�t����MPI�𗘗p���邱�Ƃ��������߂��܂��B

## �_�E�����[�h

���C�u������          | �_�E�����[�h��                                           | ���l
--------------- | ------------------------------------------------- | ------------------
OpenBLAS-0.2.18 | <http://www.openblas.net>                         | ���t�@�����X��LAPACK��������
metis-5.1.0     | <http://glaros.dtc.umn.edu/gkhome/metis/metis/download> | scotch-metis�����p��
scalapack-2.0.2 | <http://www.netlib.org/scalapack/>                | MUMPS�ŗ��p
MUMPS_5.0.1     | <http://mumps.enseeiht.fr/>                       | �v���[�U�o�^
trilinos-12.6.2 | <https://trilinos.org/download/>                  | �v���[�U�o�^

## OpenBLAS�̍\�z

OpenBLAS�́A������LAPACK/BLAS�̃t���[�̎����ł��B

OpenMP��L���ɂ������C�u�������\�z���܂��B

```sh
% tar xvf OpenBLAS-0.2.18.tar.gz
% cd OpenBLAS-0.2.18
% make BINARY=64 NO_SHARED=1 USE_OPENMP=1
% make PREFIX=$HOME/local install
```

OpenBLAS��LAPACK�Ƃ��ė��p����ꍇ�A`-llapack`�̑����`-lopenblas`�Ǝw�肵�Ă��������B

## METIS�̍\�z

�O���t�p�[�e�B�V���i�̃��C�u�����ł��B���̑��AScotch�ɓ��������metis�݊��w�����p�ł��܂��B

OpenMP��L���ɂ������C�u�������\�z���܂��B

METIS�̍\�z�ɂ�`cmake`���K�v�ł��̂ŁA�\�߃C���X�g�[�����Ă����Ă��������B

```sh
% tar xvf metis-5.1.0.tar.gz
% cd metis-5.1.0
```

metis�̃g�b�v�f�B���N�g���ɂ���`CMakeLists.txt`�ɂ̓o�O������܂��̂ŁA�C�������Ă��������B

```sh
% vi CMakeLists.txt
set(GKLIB_PATH "GKlib" CACHE PATH "path to GKlib")
�Ə�����Ă��镔����
set(GKLIB_PATH "${CMAKE_SOUCE_DIR}/GKlib" CACHE PATH "path to GKlib")
�ɏC��
```

`CMakeLists.txt`���C��������`cmake`�����s���ă��C�u�������\�z���܂��B

```sh
% cd build
% cmake -DCMAKE_INSTALL_PREFIX=$HOME/local -DCMAKE_BUILD_TYPE="Release" -DOPENMP=ON ..
% make
% make install
```

## Scalapack�̍\�z

scalapack�́A���̌����������MUMPS�̍\�z�ɕK�v�ƂȂ�܂��B

�܂��Ascalapack�̍\�z�ɂ́A�\��MPI���C���X�g�[������Ă���K�v������܂��B

```sh
% tar xvf scalapack-2.0.2.tgz
% cd scalapack-2.0.2
% mkdir build
% cd build
% cmake -DCMAKE_INSTALL_PREFIX=$HOME/local ..
% make
% make install
```

## MUMPS�̍\�z

MUMPS�͒��ږ@�̃\���o�ł��B

```sh
% tar xvf MUMPS_5.0.1.tar.gz
% cd MUMPS_5.0.1
```

`Make.inc`�f�B���N�g���ɂ���A`Makefile.inc.generic`������`Makefile.inc`�����ɍ��킹�����e�֏��������܂��B

```sh
% cp Make.inc/Makefile.inc.generic Makefile.inc
% vi Makefile.inc
LMETISDIR = $(HOME)/local
IMETIS    = -I$(LMETISDIR)/include
LMETIS    = -L$(LMETISDIR)/lib -lmetis

ORDERINGSF  = -Dmetis -Dpord

CC      = gcc -fopenmp
FC      = gfortran -fopenmp
FL      = gfortran -fopenmp

SCALAP  = -L$(HOME)/local/lib -lscalapack

INCPAR = -I/usr/lib/openmpi/include

LIBPAR  = $(SCALAP) -L/usr/lib/openmpi -lmpi -lmpi_mpifh

OPTF    = -O -DMUMPS_OPENMP
OPTC    = -O -I. -DMUMPS_OPENMP
OPTL    = -O
```

�t�@�C���̏C�����ς񂾂烉�C�u�������\�z���܂��B

```sh
% make
```

## Trilinos ML�̍\�z

Trilinos�ɂ͑����̃��C�u�����܂܂�Ă��܂����AFrontISTR�ɕK�v�Ȃ̂�`ML`��`zoltan`�����ł��B

```sh
% tar xvf trilinos-12.6.5-Source.tar.gz
% cd trilinos-12.6.5-Source
% mkdir build
% cd build
% cmake \
  -DCMAKE_INSTALL_PREFIX=$HOME/local \
  -DTrilinos_ENABLE_ML=ON \
  -DTrilinos_ENABLE_Zoltan=ON \
  -DTrilinos_ENABLE_OpenMP=ON \
  -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=OFF \
  -DTPL_BLAS_LIBRARIES=$HOME/local/lib/libopenblas.a \
  -DTPL_LAPACK_LIBRARIES=$HOME/local/lib/libopenblas.a \
  -DTPL_ENABLE_MPI=ON \
  ..
% make
% make install
```

�����Ŏ������菇�ł́A���C�u������`$HOME/local`�ȉ��ɃC���X�g�[�������܂����BUbuntu�ȊO��OS�ł���{�I�ɂ͓��l�ɍ\�z���邱�Ƃ��ł��܂��B
