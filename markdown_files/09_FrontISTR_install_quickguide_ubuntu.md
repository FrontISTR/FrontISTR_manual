# FrontISTR v4.5のインストール (ubuntu 16.04 LTS)

ここでは、FrontISTRをUbuntu 16.04 LTSで手軽に構築する方法を紹介します。

FrontISTRを構築するには、様々なライブラリが必要になりますが、バイナリパッケージを利用することで手間を省きます。

ここに書かれている方法は、Ubuntu 16.04 LTSに対応します。

ライブラリをソースから構築する場合は、[【参考】ライブラリを自力で構築する方法](#build-from-source)を参考にしてください。

# はじめに

FrontISTRは[東京大学 奥田研究室](http://www.multi.k.u-tokyo.ac.jp/)で開発されている、本格的な構造解析プログラムです。[FrontISTR研究会](http://www.multi.k.u-tokyo.ac.jp/FrontISTR/)から、研究会の案内や資料、ソフトウェアが入手できます。
スパコンからWindowsパソコンまで動かすことが出来る点が特徴の一つです。

# 準備

予めubuntu 16.04 LTSをインストールし、OSが動作可能な状態にしてください。

# ダウンロード

以下のソフトを入手してください。

ソフトウェア                 | 入手先
---------------------- | --------------------------------------------
FrontISTR_V45.tar.gz   | <http://www.multi.k.u-tokyo.ac.jp/FrontISTR>
REVOCAP_Refiner-1.1.04 | <http://www.multi.k.u-tokyo.ac.jp/FrontISTR>

# 必要なライブラリの導入

## バイナリパッケージの導入

上記以外のソフトはバイナリパッケージから導入します。

```sh
% sudo apt install build-essensial
% sudo apt install libtrilinos-ml-dev
% sudo apt install libtrilinos-aztecoo-dev libtrilinos-zoltan-dev
% sudo apt install libopenblas-dev libmumps-dev libmetis-dev
```

## REVOCAP_Refinerの構築

REVOCAP_Refinerをコンパイルします。

```sh
% tar xvf REVOCAP_Refiner-1.1.04.tar.gz
% cd REVOCAP_Refiner-1.1.04
% make
```

# FrontISTRの構築

必要なライブラリの導入が済んだらFrontISTRを構築します。

FrontISTRで有効にする機能は

- hecmw_part1領域分割ツールなどのツール群生成
- REVOCAP_Refiner (メッシュの細分化機能)
- MPI (PCクラスタ等の並列実行環境）
- OpenMP (マルチコアCPUを利用)
- METIS (メッシュの領域分割のために必要)
- MUMPS (直接法ソルバー)
- LAPACK （CG法やGMRES法を用いた前処理適用後の条件数推定機能を利用）
- Trilinos-ML （代数マルチグリッド法に基づく前処理）

です。これらの機能を有効にしたバイナリを作成します。

```sh
% tar xvf FrontISTR_V45.tar.gz
% cd FrontISTR_V45
```

さらに`Makefile.am`を編集し構築する必要のない部分を除外します。

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

> `hecmw2`および`fistr2`は構築しませんので、コメントアウトしてください。

## Makefile.confの編集

```sh
% cp Makefile.conf.org Makefile.conf
% vi Makefile.conf
```

以下の内容で`Makefile.conf`を編集してください。

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

> この手順で用いるMETISはVersion5.1.0です。`HECMW_METIS_VER = 5`を指定してください。

> gfortranのプリプロセッサ指定は `-cpp`です。`F90FPP = -cpp`を指定してください。

編集が出来たら`setup.sh`を実行してください。

```sh
% ./setup.sh -p --with-tools --with-refiner --with-metis --with-mumps --with-lapack --with-ml
```

`setup.sh`の実行が済んだらコンパイルしてバイナリを作成します。

```sh
% make
% make install
```

構築したバイナリをインストールをすると、`$(HOME)/FrontISTR/bin`以下に

```sh
% ls $HOME/FrontISTR/bin
fistr1  hec2rcap  hecmw_part1  hecmw_vis1  neu2fstr  rconv  rmerge
```

などのバイナリがコピーされ実行できる状態になります。

通常はここまでの手順で十分です。

---

# 【参考】ライブラリを自力で構築する方法　<a name="build-from-source">

FrontISTRを構築するのに必要なライブラリは

- OpenMPI (MPI)
- OpenBLAS (LAPACK）
- Metis
- MUMPS
- Scalapack
- Trilinos ML

です。 Ubuntu-16.04上で構築する例を示します。

ただし、MPIの構築方法については省きます。OS付属のMPIを利用することをおすすめします。

## ダウンロード

ライブラリ名          | ダウンロード先                                           | 備考
--------------- | ------------------------------------------------- | ------------------
OpenBLAS-0.2.18 | <http://www.openblas.net>                         | リファレンスのLAPACKよりも速い
metis-5.1.0     | <http://glaros.dtc.umn.edu/gkhome/metis/metis/download> | scotch-metisも利用可
scalapack-2.0.2 | <http://www.netlib.org/scalapack/>                | MUMPSで利用
MUMPS_5.0.1     | <http://mumps.enseeiht.fr/>                       | 要ユーザ登録
trilinos-12.6.2 | <https://trilinos.org/download/>                  | 要ユーザ登録

## OpenBLASの構築

OpenBLASは、高速なLAPACK/BLASのフリーの実装です。

OpenMPを有効にしたライブラリを構築します。

```sh
% tar xvf OpenBLAS-0.2.18.tar.gz
% cd OpenBLAS-0.2.18
% make BINARY=64 NO_SHARED=1 USE_OPENMP=1
% make PREFIX=$HOME/local install
```

OpenBLASをLAPACKとして利用する場合、`-llapack`の代わりに`-lopenblas`と指定してください。

## METISの構築

グラフパーティショナのライブラリです。この他、Scotchに同梱されるmetis互換層も利用できます。

OpenMPを有効にしたライブラリを構築します。

METISの構築には`cmake`が必要ですので、予めインストールしておいてください。

```sh
% tar xvf metis-5.1.0.tar.gz
% cd metis-5.1.0
```

metisのトップディレクトリにある`CMakeLists.txt`にはバグがありますので、修正をしてください。

```sh
% vi CMakeLists.txt
set(GKLIB_PATH "GKlib" CACHE PATH "path to GKlib")
と書かれている部分を
set(GKLIB_PATH "${CMAKE_SOUCE_DIR}/GKlib" CACHE PATH "path to GKlib")
に修正
```

`CMakeLists.txt`を修正したら`cmake`を実行してライブラリを構築します。

```sh
% cd build
% cmake -DCMAKE_INSTALL_PREFIX=$HOME/local -DCMAKE_BUILD_TYPE="Release" -DOPENMP=ON ..
% make
% make install
```

## Scalapackの構築

scalapackは、この後説明をするMUMPSの構築に必要となります。

また、scalapackの構築には、予めMPIがインストールされている必要があります。

```sh
% tar xvf scalapack-2.0.2.tgz
% cd scalapack-2.0.2
% mkdir build
% cd build
% cmake -DCMAKE_INSTALL_PREFIX=$HOME/local ..
% make
% make install
```

## MUMPSの構築

MUMPSは直接法のソルバです。

```sh
% tar xvf MUMPS_5.0.1.tar.gz
% cd MUMPS_5.0.1
```

`Make.inc`ディレクトリにある、`Makefile.inc.generic`を元に`Makefile.inc`を環境に合わせた内容へ書き換えます。

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

ファイルの修正が済んだらライブラリを構築します。

```sh
% make
```

## Trilinos MLの構築

Trilinosには多くのライブラリ含まれていますが、FrontISTRに必要なのは`ML`と`zoltan`だけです。

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

ここで示した手順では、ライブラリを`$HOME/local`以下にインストールをしました。Ubuntu以外のOSでも基本的には同様に構築することができます。
