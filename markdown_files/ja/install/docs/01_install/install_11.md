# 参考 Windows10へのインストール手順例(Makefile.conf)

Windows10上へ、本ソフトウェアとそれに必要な外部ライブラリの構築手順の例を示します。他の環境へのインストールの参考にしてください。

また、各ライブラリの詳細な構築方法は、それぞれのドキュメントを参考にしてください。

## 準備

最初に本ソフトウェアをコンパイルするのに必要なツールやパッケージをインストールしてください。

### 開発環境の準備
はじめに開発環境をインストールします。使用する開発環境は MSYS2 です。Git for Windows SDKから導入します。

[https://github.com/git-for-windows/build-extra/releases](https://github.com/git-for-windows/build-extra/releases)

下記URLから64ビット版のインストーラ`git-sdk-installer-X.X.X-64.7z.exe`(X.X.Xはバージョン番号)をダウンロードしインストールします。

### パッケージのインストール

インストールが完了したら`git for windows`と書かれたコマンドプロンプトを立ち上げコンパイルに必要なパッケージをインストールします。

```
$ pacman -S base-devel mingw-w64-x86_64-toolchain \
            mingw-w64-x86_64-cmake \
            mingw-w64-x86_64-extra-cmake-module \
            mingw-w64-x86_64-perl
```

gcc/g++/gfortranが正しくインストールされているか確認してください。

```
$ which gcc g++ gfortran
/mingw64/bin/gcc
/mingw64/bin/g++
/mingw64/bin/gfortran
```

## ライブラリのインストール

本ソフトウェアに必要なライブラリをインストールします。作業ディレクトリは`$HOME/work` 、インストール先のディレクトリは`$HOME/local`とします。

各ディレクトリを作成し、`$HOME/local/bin`をPATH環境変数に追加します。

```
$ cd $HOME
$ mkdir work
$ mkdir -p local/bin local/lib local/include
$ export PATH=$HOME/local/bin:$PATH
```

### MPIのインストール

この例では、MPIとしてMicrosoft社のMPIを利用します。

下記URLからランタイム(`msmpisetup.exe`)とSDK(`msmpisdk.msi`)がダウンロードできます。

[https://msdn.microsoft.com/ja-jp/library/windows/desktop/bb524831](https://msdn.microsoft.com/ja-jp/library/windows/desktop/bb524831)

#### .aライブラリの作成

インストールしたライブラリをMinGW-w64のgccやgfortranでリンクできるように変更を加えます。

インストールした .dll から .a を生成します。

```
$ cd $HOME/local/lib
$ gendef /c/Windows/System32/msmpi.dll
$ dlltool -d msmpi.def -l libmsmpi.a -D /c/Windows/System32/msmpi.dll
$ ls
libmsmpi.a msmpi.def
```

#### ヘッダファイルの修正

次にヘッダファイルをコピーします。

```
$ cd $HOME/local/include
$ cp /c/Program\ Files\ \(x86\)/Microsoft\ SDKs/MPI/Include/*.h .
$ cp /c/Program\ Files\ \(x86\)/Microsoft\ SDKs/MPI/Include/x64/*.h .
$ ls
mpi.h  mpif.h  mpifptr.h  mpio.h  mspms.h  pmidbg.h
```

この中の`mpi.h`を以下のように変更します。

```
$ vi mpi.h

#ifndef MPI_INCLUDE
#define MPI_INCLUDE
のすぐ下に
#include <stdint.h>
を追加
```

次に`mpif.h`も以下のように変更します。

```
$ vi mpif.h

409行目
PARAMETER (MPI_ADDRESS_KIND=INT_PTR_KIND())
を
PARAMETER (MPI_ADDRESS_KIND=8)
に変更
```

### ダウンロード

その他のソフトウェアをダウンロードし、作業ディレクトリ`$HOME/work`へ保存します。

| ソフトウェア名 | ダウンロード先 |
|:--|:--|
| REVOCAP_Refiner-1.1.04.tar.gz | http://www.multi.k.u-tokyo.ac.jp/FrontISTR/ |
| FrontISTR_V50.tar.gz | http://www.multi.k.u-tokyo.ac.jp/FrontISTR/ |
| OpenBLAS-0.2.20.tar.gz | http://www.openblas.net/ |
| metis-5.1.0.tar.gz | http://glaros.dtc.umn.edu/gkhome/metis/metis/download |
| scalapack-2.0.2.tgz | http://www.netlib.org/scalapack/ |
| MUMPS_5.1.2.tar.gz | http://mumps.enseeiht.fr/ |
| trilinos-12.12.1-Source.tar.bz2 | https://trilinos.org/download/ |

### REVOCAP_Refinerのコンパイル

```
$ cd $HOME/work
$ tar xvf REVOCAP_Refiner-1.1.04.tar.gz
$ cd REVOCAP_Refiner-1.1.04
$ make
$ cp lib/x86_64-linux/libRcapRefiner.a $HOME/local/lib
$ cp Refiner/rcapRefiner.h $HOME/local/include
```

### OpenBLASのコンパイル

OpenBLASはMSYS2から提供されるバイナリパッケージを利用します。

```
$ pacman -S mingw-w64-x86_64-openblas
```

### METISのコンパイル

```
$ cd $HOME/work
$ tar xvf metis-5.1.0.tar.gz
$ cd metis-5.1.0
```

MinGW-w64に合わせるため、以下のファイルを一部修正します。

- Makefile
- GKlib/gk_arch.h
- GKlib/getopt.c

```
% vim Makefile
60行目の
cd $(BUILDDIR) && cmake $(CURDIR) $(CONFIG_FLAGS)
を
cd $(BUILDDIR) && cmake -G "MSYS Makefiles" $(CURDIR) $(CONFIG_FLAGS)
に変更
```

```
$ vim GKlib/gk_arch.h
44行目の
  #include <sys/resource.h>
を削除
```

```
$ vim GKlib/gk_getopt.h
54行目からの
/* Function prototypes */
extern int gk_getopt(int __argc, char **__argv, char *__shortopts);
extern int gk_getopt_long(int __argc, char **__argv, char *__shortopts,
              struct gk_option *__longopts, int *__longind);
extern int gk_getopt_long_only (int __argc, char **__argv,
              char *__shortopts, struct gk_option *__longopts, int *__longind);
を削除。
```

```
$ cd build
$ cmake -G "MSYS Makefiles" \
        -DCMAKE_INSTALL_PREFIX=$HOME/local \
        -DOPENMP=ON \
        ..
$ make
$ make install
```

### ScaLAPACKのコンパイル

```
$ cd $HOME/work
$ tar xvf scalapack-2.0.2.tgz
$ cd scalapack-2.0.2
```

サンプルのSLmake.inc.exampleをSLmake.incとしてコピーし、環境に合わせて編集します。

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

編集が完了したらmakeし、完成したライブラリをコピーします。

```
$ make
$ cp libscalapack.a $HOME/local/lib
```

コンパイル終了時にエラーが表示されますが無視して構いません。

### MUMPSのコンパイル

```
$ cd $HOME/work
$ tar xvf MUMPS_5.1.2.tar.gz
$ cd MUMPS_5.1.2
$ cp Make.inc/Makefile.inc.generic Makefile.inc
```

コピーした`Makefile.inc`の以下の部分を書き換えます。

```
$ vi Makefile.inc
$ cp Make.inc/Makefile.inc.generic Makefile.inc
$ vi Makefile.inc
LMETISDIR = $(HOME)/local
IMETIS    = -I$(LMETISDIR)/include
LMETIS    = -L$(LMETISDIR)/lib -lmetis

ORDERINGSF  = -Dmetis -Dpord

CC      = gcc -fopenmp
FC      = gfortran -fopenmp -fno-range-check
FL      = gfortran -fopenmp

LAPACK = -lopenblas

SCALAP  = -L$(HOME)/local/lib -lscalapack

INCPAR = -I$(HOME)/local/include

LIBPAR  = $(SCALAP) $(LAPACK) -L$(HOME)/local/lib -lmsmpi

LIBBLAS = -lopenblas

LIBOTHERS = -lpthread -fopenmp
```

書き換えが完了したら保存しmakeします。

```
$ make
$ cp lib/*.a $HOME/local/lib
$ cp include/*.h $HOME/local/include
```

エラーが表示されますが無視して構いません。

### Trilinos MLのコンパイル

```
$ cd $HOME/work
$ tar xvf trilinos-12.12.1-Source.tar.gz
$ cd trilinos-12.12.1-Source
$ mkdir build
$ cmake -G "MSYS Makefiles" \
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
$ make
$ make install
```

## FrontISTRのコンパイル

上記ライブラリのコンパイルが済んだらFrontISTRをコンパイルします。

```
$ cd $HOME/work
$ tar xvf FrontISTR_V50.tar.gz
$ cd FrontISTR
```

### Makefile.confの編集

雛形をコピーして、環境に合わせた内容に編集します。この例では、以下の様に編集します。

```
$ cp Makefile.conf.org Makefile.conf
$ vi Makefile.conf
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

### setup.shの実行

編集が完了したら、setup.sh を実行します。

```
$ ./setup.sh -p --with-tools --with-refiner \
             --with-metis --with-mumps --with-lapack --with-ml
```

### makeの実行

編集が完了したらmakeを実行します。

```
$ make
```

### make install の実行

makeが完了したら、make installを実行しMakefile.confで指定したディレクトリへインストールします。この例では  `$(HOME)/FrontISTR/bin` です。

```
$ make install
```

### 動作確認

本ソフトウェアに同梱されているチュートリアルを実行して、動作を確認します。

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

解析が終了すると以下の様に画面上に表示されます。

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

### 補足

MinGWのインストールされていない環境で実行するには、FrontISTR `fistr1.exe` と同じディレクトリに
以下のファイルをコピーします。

- libwinpthread-1.dll
- libgfortran-3.dll
- libgcc_s_seh-1.dll
- libgomp-1.dll
- libstdc++-6.dll
- libquadmath-0.dll

通常は、

```
C:\git-sdk-64\mingw64\bin
```

の下にありますので、バイナリを実行するコンピュータにコピーします。

また、Microsoft MPIのランタイムMSMpiSetup.exeも実行するコンピュータにインストールします。
