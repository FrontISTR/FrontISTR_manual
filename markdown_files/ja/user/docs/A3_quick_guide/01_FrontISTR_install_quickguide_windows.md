# FrontISTR v4.6のインストール
## (Windows10 - MinGW-w64)

ここでは、Windowsで動くFrontISTRの構築方法を紹介します。

Windowsの場合、開発環境を整えるところから始める必要があります。また、FrontISTRを構築するのに必要な各種ライブラリがバイナリで提供されていない事が多いため、これらライブラリもソースから構築する必要があります。

比較的面倒なため、FrontISTRを直ぐに使いたい方は [FrontISTR研究会](http://www.multi.k.u-tokyo.ac.jp/FrontISTR/) から提供されている **バイナリ版** または **REVOCAP_PrePost** をダウンロードしてください。

REVOCAP_PrePost は、FrontISTR等で使えるプリポスト用のソフトウェアでFrontISTRが同梱されています。

## Git for windows SDK を用いたMSYS2のインストール

windows用の開発環境として、Git for windows SDKのMinGW-w64を用います。

<https://github.com/git-for-windows/build-extra/releases>

から `git-sdk-installer-1.0.3-64.7z.exe` をダウンロードして、インストールしてください。

インストールの最後に

~~~txt
Generating catalog po/ru.msg
msgfmt --statistics --tcl po/ru.po -l ru -d po/
307 ﾂﾌ|bZ[W.
make[1]: *** [Makefile:76: po/ru.msg] エラー 1
make: *** [Makefile:1656: all] エラー 2
続行するには何かキーを押してください . . .
~~~

というエラーが出ますが、これは無視して構いません。

インストールが終了すると、デスクトップに「Git SDK 64-bit」というアイコンが現れます。

以前は、MSYS2を直接インストールする方法を書いていましたが、Git for windows SDKを使った方が簡単に環境整備が出来ることが分かりました。

次に、コンパイルに必要なパッケージをインストールします。

~~~txt
(MSYS) pacman -S mingw-w64-x86_64-cmake mingw-w64-x86_64-qt5
~~~

`cmake-gui`を使う場合、`mingw-w64-x86_64-qt5`パッケージもインストールしてください。

Tips : `mingw-w64-x86_64-qt5` のインストールは必ずしも必要ありませんが、`cmake`でライブラリが見つからないなどのトラブルがあるとき、`cmake-gui`が役立ちます。

これでコンパイラなどがインストールされますので、念のため確認をして下さい。

~~~txt
(MSYS) gcc -v
(MSYS) gfortran -v
(MSYS) cmake --version
~~~

作業に先立ち、ディレクトリを作成してください。 作業ディレクトリは`$HOME/work`とし、ライブラリは`$HOME/local`以下にインストールします。

~~~txt
(MSYS) mkdir $HOME/work
(MSYS) mkdir -p $HOME/local/lib
(MSYS) mkdir $HOME/local/include
~~~

## Microsoft MPIのインストール

MPIにはMicrosoft MPIを使います。

[Download Microsoft MPI v8.1 from Official Microsoft Download Center](https://www.microsoft.com/en-us/download/details.aspx?id=55494)

から、SDKの`msmpisdk.msi`とランタイムの`MSMpiSetup.exe`をダウンロードしインストールをしてください。

### Microsoft MPIをリンクするための準備

Microsoft MPIをMinGW-w64の`gcc`や`gfortran`でリンクするための作業をします。

~~~txt
(MINGW64) cd $HOME/local/lib/
(MINGW64) gendef /c/Windows/System32/msmpi.dll
(MINGW64) dlltool -d msmpi.def -l libmsmpi.a -D /c/Windows/System32/msmpi.dll
(MINGW64) ls
libmsmpi.a  msmpi.def
~~~

MinGW-w64環境でリンクできるMicrosoft MPIのライブラリが作成されました。

次にヘッダファイルをコピーします。

~~~txt
(MINGW64) cd $HOME/local/include
(MINGW64) cp /c/Program\ Files\ \(x86\)/Microsoft\ SDKs/MPI/Include/*.h .
(MINGW64) cp /c/Program\ Files\ \(x86\)/Microsoft\ SDKs/MPI/Include/x64/*.h .
(MINGW64) ls
mpi.h  mpif.h  mpifptr.h  mpio.h  mspms.h  pmidbg.h
~~~

`mpi.h`に変更を加えます。

~~~txt
(MINGW64) vi mpi.h

#ifndef MPI_INCLUDED
#define MPI_INCLUDED
のすぐ下に
#include <stdint.h>
を追加する。
~~~

更に`mpif.h`に変更を加えます。

~~~txt
(MINGW64) vi mpif.h

407行目
PARAMETER (MPI_ADDRESS_KIND=INT_PTR_KIND())
を
PARAMETER (MPI_ADDRESS_KIND=8)
へ変更する。
~~~

以上でMicrosoft MPIをMinGW-w64でリンクする準備が出来ました。

## ライブラリの構築

FrontISTRで有効にする機能は

- hecmw_part1領域分割ツールなどのツール群生成
- REVOCAP_Refiner (メッシュの細分化機能)
- MPI (PCクラスタ等の並列実行環境）
- OpenMP (マルチコアCPUを利用)
- METIS (メッシュの領域分割のために必要)
- MUMPS (直接法ソルバー)
- LAPACK （CG法やGMRES法を用いた前処理適用後の条件数推定機能を利用）
- Trilinos-ML （代数マルチグリッド法に基づく前処理）

です。

### ダウンロード

FrontISTRと必要なライブラリをダウンロードしてください。

ライブラリ名                 | ダウンロード先                                                 | 備考
---------------------- | ------------------------------------------------------- | ----------------
FrontISTR_V46.tar.gz   | <http://www.multi.k.u-tokyo.ac.jp/FrontISTR>            | 要ユーザ登録
REVOCAP_Refiner-1.1.04 | <http://www.multi.k.u-tokyo.ac.jp/FrontISTR>            | 要ユーザ登録
OpenBLAS-0.2.19        | <http://www.openblas.net>                               | ソースをダウンロード
metis-5.1.0            | <http://glaros.dtc.umn.edu/gkhome/metis/metis/download> | scotch-metisも利用可
scalapack-2.0.2        | <http://www.netlib.org/scalapack/>                      | MUMPSで利用
MUMPS_5.1.1            | <http://mumps.enseeiht.fr/>                             | 要ユーザ登録
trilinos-12.10.1        | <https://trilinos.org/download/>                        | 要ユーザ登録

ダウンロードしたファイルは`$HOME/work`に置いてください。

「MinGW-w64 Win64 Shell」上で構築していきます。

### OpenBLASの構築

OpenBLASは、高速なLAPACK/BLASのフリーの実装です。OpenMPを有効にしたライブラリを構築します。

~~~txt
(MINGW64) cd $HOME/work
(MINGW64) tar xvf OpenBLAS-0.2.18.tar.gz
(MINGW64) cd OpenBLAS-0.2.18
(MINGW64) make BINARY=64 NO_SHARED=1 USE_OPENMP=1
(MINGW64) make PREFIX=$HOME/local install
~~~

`make install`をすると、

~~~txt
cp: cannot stat 'libopenblas.dll': No such file or directory
make[1]: [Makefile.install:52: install] Error 1 (ignored)
cp: cannot stat 'libopenblas.dll.a': No such file or directory
make[1]: [Makefile.install:53: install] Error 1 (ignored)
~~~

というエラーが表示されますが、今回はDLLを作成していないので無視してください。

OpenBLASにはLAPACKも含まれます。リンクするには `-llapack`の代わりに`-lopenblas`を指定してください。

### METISの構築

グラフパーティショナのライブラリです。この他、Scotchに同梱されるmetis互換層も利用できます。

OpenMPを有効にしたライブラリを構築します。

~~~txt
(MINGW64) tar xvf metis-5.1.0.tar.gz
(MINGW64) cd metis-5.1.0
~~~

#### ファイルの修正

コンパイルをする前に

- CMakeLists.txt
- GKlib/gk_arch.h
- GKlib/gk_getopt.h

をMinGW-w64用の修正をします。

##### CMakeLists.txt

~~~txt
(MINGW64) vi CMakeLists.txt
set(GKLIB_PATH "GKlib" CACHE PATH "path to GKlib")
と書かれている部分を
set(GKLIB_PATH "${CMAKE_SOUCE_DIR}/GKlib" CACHE PATH "path to GKlib")
に修正
~~~

##### GKlib/gk_arch.h

~~~txt
(MINGW64) vi GKlib/gk_arch.h
#include <sys/resource.h>
を削除
~~~

##### GKlib/gk_getopt.h

~~~txt
/* Function prototypes */
extern int gk_getopt(int __argc, char **__argv, char *__shortopts);
extern int gk_getopt_long(int __argc, char **__argv, char *__shortopts,
              struct gk_option *__longopts, int *__longind);
extern int gk_getopt_long_only (int __argc, char **__argv,
              char *__shortopts, struct gk_option *__longopts, int *__longind);
を削除
~~~

#### コンパイル

ファイルを修正したら`cmake`を実行してライブラリを構築します。

~~~txt
(MINGW64) cd build
(MINGW64) cmake -G "MSYS Makefiles" -DCMAKE_INSTALL_PREFIX=$HOME/local \
            -DCMAKE_BUILD_TYPE="Release" -DOPENMP=ON ..
(MINGW64) make
(MINGW64) make install
~~~

### Scalapackの構築

scalapackは、この後説明をするMUMPSの構築に必要となります。

~~~txt
(MINGW64) cd $HOME/work
(MINGW64) tar xvf scalapack-2.0.2.tgz
(MINGW64) cd scalapack-2.0.2
~~~

サンプルの`SLmake.inc.example`を`SLmake.inc`としてコピーして書き換えます。

~~~txt
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

BLASLIB       = -L$(HOME)/local/lib -lopenblas
LAPACKLIB     =
LIBS          = $(LAPACKLIB) $(BLASLIB)
~~~

書き換えが済んだらライブラリを構築します。

~~~txt
(MINGW64) make
~~~

`make`をするとエラーが出ますが、`BLACS/TESTING`のエラーなので無視します。

~~~txt
(MINGW64) cp libscalapack.a $HOME/local/lib
~~~

### MUMPSの構築

MUMPSは直接法のソルバです。

~~~txt
(MINGW64) cd $HOME/work
(MINGW64) tar xvf MUMPS_5.0.1.tar.gz
(MINGW64) cd MUMPS_5.0.1
~~~

`Make.inc`ディレクトリにある、`Makefile.inc.generic`を元に`Makefile.inc`を環境に合わせた内容へ書き換えます。

~~~txt
(MINGW64) cp Make.inc/Makefile.inc.generic Makefile.inc
(MINGW64) vi Makefile.inc

LMETISDIR = $(HOME)/local
IMETIS    = -I$(LMETISDIR)/include
LMETIS    = -L$(LMETISDIR)/lib -lmetis

ORDERINGSF  = -Dmetis -Dpord

CC      = gcc -fopenmp
FC      = gfortran -fopenmp -fno-range-check
FL      = gfortran -fopenmp

SCALAP  = -L$(HOME)/local/lib -lscalapack

INCPAR = -I$(HOME)/local/include

LIBPAR  = $(SCALAP) -L$(HOME)/local/lib -lmsmpi

LIBBLAS = -L$(HOME)/local/lib -lopenblas

LIBOTHERS = -lpthread -fopenmp

OPTF    = -O -DMUMPS_OPENMP
OPTC    = -O -I. -DMUMPS_OPENMP
OPTL    = -O
~~~

ファイルの修正が済んだらライブラリを構築します。

~~~txt
(MINGW64) make
~~~

### Trilinos MLの構築

Trilinosには多くのライブラリ含まれていますが、FrontISTRに必要なのは`ML`と`zoltan`だけです。

~~~txt
(MINGW64) cd $HOME/work
(MINGW64) tar xvf trilinos-12.10.1-Source.tar.gz
(MINGW64) cd trilinos-12.10.1-Source
(MINGW64) mkdir build
(MINGW64) cd build
(MINGW64) cmake \
            -G "MSYS Makefiles" \
            -DCMAKE_INSTALL_PREFIX=$HOME/local \
            -DCMAKE_C_FLAGS="-DNO_TIMES" \
            -DCMAKE_CXX_FLAGS="-DNO_TIMES" \
            -DTrilinos_ENABLE_ML=ON \
            -DTrilinos_ENABLE_Zoltan=ON \
            -DTrilinos_ENABLE_OpenMP=ON \
            -DTrilinos_ENABLE_ALL_OPTIONAL_PACKAGES=OFF \
            -DTPL_BLAS_LIBRARIES=$HOME/local/lib/libopenblas.a \
            -DTPL_LAPACK_LIBRARIES=$HOME/local/lib/libopenblas.a \
            -DTPL_ENABLE_MPI=ON \
            -DML_ENABLE_MPI=ON \
            -DMPI_CXX_COMPILER=g++ \
            -DMPI_CXX_INCLUDE_PATH=$HOME/local/include \
            -DMPI_CXX_LIBRARIES=$HOME/local/lib/libmsmpi.a \
            -DMPI_C_COMPILER=gcc \
            -DMPI_C_INCLUDE_PATH=$HOME/local/include \
            -DMPI_C_LIBRARIES=$HOME/local/lib/libmsmpi.a \
            ..
(MINGW64) make
(MINGW64) make install
~~~

### REVOCAP_Refinerの構築

REVOCAP_Refinerをコンパイルします。

~~~txt
(MINGW64) cd $HOME/work
(MINGW64) tar xvf REVOCAP_Refiner-1.1.04.tar.gz
(MINGW64) cd REVOCAP_Refiner-1.1.04
(MINGW64) make
~~~

## FrontISTRの構築

必要なライブラリの導入が済んだらFrontISTRを構築します。

~~~txt
(MINGW64) cd $HOME/work
(MINGW64) tar xvf FrontISTR_V46.tar.gz
(MINGW64) cd FrontISTR-4.6
~~~

サンプルの`Makefile.conf.org`を`Makefile.conf`としてコピーして書き換えます。

~~~txt
(MINGW64) cp Makefile.conf.org Makefile.conf
(MINGW64) vi Makefile.conf
~~~

以下の内容で`Makefile.conf`を編集してください。

~~~
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
PARMETISDIR    = $(HOME)/ParMetis-3.1
PARMETISLIBDIR = $(PARMETISDIR)
PARMETISINCDIR = $(PARMETISDIR)/ParMETISLib

# Refiner
REFINERDIR     = $(HOME)/work/REVOCAP_Refiner-1.1.04
REFINERINCDIR  = $(REFINERDIR)/Refiner
REFINERLIBDIR  = $(REFINERDIR)/lib/x86_64-linux

# Coupler
REVOCAPDIR     = $(HOME)/REVOCAP_Coupler
REVOCAPINCDIR  = $(REVOCAPDIR)/librcap
REVOCAPLIBDIR  = $(REVOCAPDIR)/librcap

# MUMPS
MUMPSDIR       = $(HOME)/work/MUMPS_5.0.1
MUMPSINCDIR    = $(MUMPSDIR)/include
MUMPSLIBDIR    = $(MUMPSDIR)/lib
MUMPSLIBS      = -ldmumps -lmumps_common -lpord -L$(HOME)/local/lib -lscalapack

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
F90FLAGS       = -D_WINDOWS
F90LDFLAGS     = -lstdc++ -L$(HOME)/local/lib -lopenblas
F90OPTFLAGS    = -O2
F90FPP         = -cpp
F90LINKER      = gfortran -fopenmp

MAKE           = make
AR             = ar ruv
MV             = mv -f
CP             = cp -f
RM             = rm -f
MKDIR          = mkdir -p
~~~

- この手順で用いるMETISはVersion5.1.0です。`HECMW_METIS_VER = 5`を指定してください。
- gfortranのプリプロセッサ指定は `-cpp`です。`F90FPP = -cpp`を指定してください。
- `REFINERLIBDIR`に`x86_64-linux`と書かれていますが、間違いではありません?

さらに`Makefile.am`を編集し構築する必要のない部分を除外します。

~~~txt
(MINGW64) vi Makefile.am

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
~~~

`hecmw2`および`fistr2`は構築しませんので、コメントアウトしてください。

編集が出来たら`setup.sh`を実行してください。

~~~txt
(MINGW64) ./setup.sh -p --with-tools --with-refiner --with-metis --with-mumps --with-lapack --with-ml
~~~

`setup.sh`の実行が住んだらコンパイルしてバイナリを作成します。

~~~txt
(MINGW64) make
(MINGW64) make install
~~~

構築したバイナリをインストールをすると、`$(HOME)/FrontISTR/bin`以下に

~~~txt
(MINGW64) ls $HOME/FrontISTR/bin
fistr1.exe    hecmw_part1.exe  neu2fstr.exe  rmerge.exe
hec2rcap.exe  hecmw_vis1.exe   rconv.exe
~~~

などのバイナリがコピーされます。

作成されたバイナリは、MSYS2やMinGWが無くても動作しますが、各種DLLをコピーして`PATH`を通しておく必要があります。

必要なDLLは

~~~txt
libwinpthread-1.dll
libgfortran-3.dll
libgcc_s_seh-1.dll
libgomp-1.dll
libstdc++-6.dll
libquadmath-0.dll
~~~

と`msmpi.dll`および`mpiexec.exe`になりますが、これらはインストーラで`MSMpiSetup.exe` を実行した時点で`PATH`が通っています。
