## 参考 CentOS7.6へのインストール手順例(cmake)

CentOS7.6上へ本ソフトウェアと、それに必要な外部ライブラリの構築手順の例を示します。他の環境へのインストールの参考にしてください。

また、各ライブラリの詳細な構築方法は、それぞれのドキュメントを参考にしてください。

### 準備

最初に本ソフトウェアをコンパイルするのに必要なツールやパッケージをインストールしてください。

```
$ su
# yum group mark install "Development Tools"
# yum update
# yum install openmpi-devel cmake
# exit
```

次にMPIの環境設定を行います。コマンドライン上で

```
module purge
module load mpi/openmpi-x86_64
```

`$HOME/.bash_profile`に記述しておけば、次回ログイン時も設定が反映されます。

gcc/g++/gfortranおよびMPIのラッパーが正しくインストールされているか確認してください。

```
$ which gcc g++ gfortran mpicc mpic++ mpifort
/usr/bin/gcc
/usr/bin/g++
/usr/bin/gfortran
/usr/lib64/openmpi/bin/mpicc
/usr/lib64/openmpi/bin/mpic++
/usr/lib64/openmpi/bin/mpifort
```

### ライブラリのインストール

本ソフトウェアに必要なライブラリをインストールします。作業ディレクトリは`$HOME/work` 、インストール先のディレクトリは`$HOME/local`とします。

各ディレクトリを作成し、`$HOME/local/bin`をPATH環境変数に追加します。

```
cd $HOME
mkdir work
mkdir -p local/bin local/lib local/include
export PATH=$HOME/local/bin:$PATH
```

#### ダウンロード

以下のソフトウェアをダウンロードし、作業ディレクトリ`$HOME/work`へ保存します。

| ソフトウェア名 | ダウンロード先 |
|:--|:--|
| REVOCAP_Refiner-1.1.04.tar.gz | <https://www.frontistr.com/> |
| FrontISTR_V50.tar.gz | <https://www.frontistr.com/> |
| OpenBLAS-0.2.20.tar.gz | <http://www.openblas.net/> |
| metis-5.1.0.tar.gz | <https://gitlab.com/FrontISTR-Commons/METIS> <br/> <https://gitlab.com/FrontISTR-Commons/GKlib> |
| scalapack-2.0.2.tgz | <http://www.netlib.org/scalapack/> |
| MUMPS_5.1.2.tar.gz | <http://mumps.enseeiht.fr/> |
| trilinos-12.14.1-Source.tar.bz2 | <https://trilinos.org/download/> |

#### REVOCAP_Refinerのコンパイル

```
cd $HOME/work
tar xvf REVOCAP_Refiner-1.1.04.tar.gz
cd REVOCAP_Refiner-1.1.04
make
cp lib/x86_64-linux/libRcapRefiner.a ~/local/lib
cp Refiner/rcapRefiner.h ~/local/include
```

#### OpenBLASのコンパイル

```
cd $HOME/work
tar xvf OpenBLAS-0.2.20.tar.gz
make BINARY=64 NO_SHARED=1 USE_OPENMP=1
make PREFIX=~/local install
```

#### METISのコンパイル

```
cd $HOME/work
tar xvf metis-5.1.0.tar.gz
cd metis-5.1.0
make config prefix=~/local cc=gcc openmp=1
make
make install
```

#### ScaLAPACKのコンパイル

```
$ cd $HOME/work
$ tar xvf scalapack-2.0.2.tgz
$ cd scalapack-2.0.2
$ mkdir build
$ cmake -DCMAKE_INSTALL_PREFIX=$HOME/local \
        -DCMAKE_EXE_LINKER_FLAGS="-fopenmp" \
        -DCMAKE_BUILD_TYPE="Release" \
        -DBLAS_LIBRARIES=$HOME/local/lib/libopenblas.a \
        -DLAPACK_LIBRARIES=$HOME/local/lib/libopenblas.a \
        ..
$ make
$ make install
```

#### MUMPSのコンパイル

```
cd $HOME/work
tar xvf MUMPS_5.1.2.tar.gz
cd MUMPS_5.1.2
cp Make.inc/Makefile.inc.generic Makefile.inc
```

コピーした`Makefile.inc`の以下の部分を書き換えます。

```
$ cp Make.inc/Makefile.inc.generic Makefile.inc
$ vi Makefile.inc
LMETISDIR = $(HOME)/local
IMETIS    = -I$(LMETISDIR)/include
LMETIS    = -L$(LMETISDIR)/lib -lmetis

ORDERINGSF  = -Dmetis -Dpord

CC      = mpicc
FC      = mpifort
FL      = mpifort

LAPACK = -L$(HOME)/local/lib -lopenblas

SCALAP  = -L$(HOME)/local/lib -lscalapack

INCPAR = -I/usr/include/openmpi-x86_64

LIBPAR  = $(SCALAP) -L/usr/lib64/openmpi/lib -lmpi

LIBBLAS = -L$(HOME)/local/lib -lopenblas

OPTF    = -O -DBLR_MT -fopenmp
OPTC    = -O -I. -fopenmp
OPTL    = -O -fopenmp
```

書き換えが完了したら保存しmakeします。

```
make
cp lib/*.a $HOME/local/lib
cp include/*.h $HOME/local/include
```

#### Trilinos MLのコンパイル

```
$ cd $HOME/work
$ tar xvf trilinos-12.14.1-Source.tar.gz
$ cd trilinos-12.14.1-Source
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
        -DTPL_MUMPS_INCLUDE_DIRS=$HOME/local/include \
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

### FrontISTRのコンパイル

上記ライブラリのコンパイルが済んだらFrontISTRをコンパイルします。

```
$ cd $HOME/work
$ tar xvf FrontISTR_V50.tar.gz
$ cd FrontISTR
$ mkdir build
$ cd build
$ cmake -DCMAKE_INSTALL_PREFIX=$HOME/FrontISTR \
        -DWITH_ML=ON \
        -DBLAS_LIBRARIES=$HOME/local/lib/libopenblas.a \
        -DLAPACK_LIBRARIES=$HOME/local/lib/libopenblas.a \
        ..
```

#### makeの実行

makeを実行します。

```
make
```

4並列コンパイルをする場合、

```
make -j4
```

とします。並列コンパイルにより、コンパイル時間が短縮されます。

#### make install の実行

makeが完了したら、make installを実行し指定したディレクトリへインストールします。この例では `$(HOME)/FrontISTR/bin` になります。

```
make install
```

#### 動作確認

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
