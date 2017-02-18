<!-- include, libの順に記載する -->

# 付録

## 付録1 Makefile.confの変数一覧

### MPIに関する設定

MPI対応コンパイラーが自動参照している場合は、MPIに関する設定は不要である。

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| MPIDIR | MPIがインストールされているディレクトリのパスを指定する | なし |
| MPIBINDIR | MPIの実行ファイル群がインストールされているディレクトリのパスを指定する | なし |
| MPIINCDIR | MPIのヘッダーファイル群がインストールされているディレクトリのパスを指定する | . |
| MPILIBDIR | MPIのライブラリ群がインストールされているディレクトリのパスを指定する | . |
| MPILIBS | CおよびFortran90のオブジェクトファイルにリンクさせるMPIライブラリを指定する | なし |

### インストールディレクトリに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| PREFIX | 本ソフトウェアをインストールするディレクトリのパスを指定する | `$(HOME)/FrontISTR` |
| BINDIR | 本ソフトウェアの実行ファイル群をインストールするディレクトリのパスを指定する | `$(PREFIX)/bin` |
| INCLUDEDIR | 本ソフトウェアのヘッダーファイル群をインストールするディレクトリのパスを指定する | `$(PREFIX)/include` |
| LIBDIR | 本ソフトウェアのライブラリ群をインストールするディレクトリのパスを指定する | `$(PREFIX)/lib` |

### METISに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| METISDIR | METISがインストールされているディレクトリのパスを指定する | `$(HOME)/metis` |
| METISINCDIR | METISのヘッダーファイル群（metis.hなど）がインストールされているディレクトリのパスを指定する | `$(METISDIR)/include` |
| METISLIBDIR | METISのライブラリ（libmetis.a）がインストールされているディレクトリのパスを指定する | `$(METISDIR)/lib` |

### ParMETISに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| PARMETISDIR | ParMETISがインストールされているディレクトリのパスを指定する。 | `$(HOME)/ParMetis` |
| PAEMETISINCDIR | ParMETISのヘッダーファイル群（parmetis.hなど）がインストールされているディレクトリのパスを指定する | `$(PARMETISDIR)/include` |
| PARMETISLIBDIR | ParMETISのライブラリ（libparmetis.a）がインストールされているディレクトリのパスを指定する | `$(PARMETISDIR)/lib` |

### REVOCAP_Refinerに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| REFINERDIR | REVOCAP_Refinerがインストールされているディレクトリのパスを指定する | `$(HOME)/REVOCAP_Refiner` |
| REFINERINCDIR | REVOCAP_Refinerのヘッダーファイル群がインストールされているディレクトリのパスを指定する | `$(PARMETISDIR)/include` |
| REFINERLIBDIR | REVOCAP_Refinerのライブラリ群がインストールされているディレクトリのパスを指定する | `$(PARMETISDIR)/lib` |

### REVOCAP_Couplerに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| REVOCAPDIR | REVOCAP_Couplerがインストールされているディレクトリのパスを指定する | `$(HOME)/REVOCAP_Coupler` |
| REVOCAPINCDIR | REVOCAP_Couplerのヘッダーファイル群がインストールされているディレクトリのパスを指定する | `$(REVOCAPDIR)/include` |
| REVOCAPLIBDIR | REVOCAP_Couplerのライブラリ群がインストールされているディレクトリのパスを指定する | `$(REVOCAPDIR)/lib` |

### MUMPSに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| MUMPSDIR | MUMPSがインストールされているディレクトリのパスを指定する | `$(HOME)/MUMPS` |
| MUMPSINCDIR | MUMPSのヘッダーファイル群がインストールされているディレクトリのパスを指定する | `$(MUMPSDIR)/include` |
| MUMPSLIBDIR | MUMPSのライブラリ群がインストールされているディレクトリのパスを指定する | `$(MUMPSDIR)/lib` |

### MLに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| MLDIR | MLがインストールされているディレクトリのパスを指定する | `$(HOME)/trilinos` |
| MLINCDIR | MLのヘッダーファイル群がインストールされているディレクトリのパスを指定する | `$(MLDIR)/include` |
| MLLIBDIR | MLのライブラリ群がインストールされているディレクトリのパスを指定する | `$(MLDIR)/lib` |

### Cコンパイラーに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| CC | Cコンパイラーの起動コマンドを指定する | `mpicc` |
| CFLAGS | Cコンパイラーに付与するオプションを指定する | なし |
| LDFLAGS | Cリンカーに付与するオプションを指定する。REVOCAP_Refinerを使用する場合で、CプログラムのリンクにCコンパイラーを用いる場合には、C++の標準ライブラリ（-lstdc++など）を指定する必要がある。 | `-lm` |
| OPTFLAGS | Cコンパイラーに付与する最適化オプションなどを指定する | `-O3` |
| CLINKER | Cプログラムのリンク時に用いるコマンドを指定する。REVOCAP_Refinerを使用する場合で、CプログラムのリンクにC++コンパイラーを用いる必要がある場合などに指定する。 | `$(CC)` |

### C++コンパイラーに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| CPP | C++コンパイラーの起動コマンドを指定する | `mpic++` |
| CPPFLAGS | C++コンパイラーに付与するオプションを指定する。BoostライブラリがC++コンパイラーから自動参照されない場合、-Iオプションにより、インクルードファイルが格納されているディレクトリを指定する。 | `-DMPICH_IGNORE_CXX_SEEK` |
| CPPLDFLAGS | C++リンカーに付与するオプションを指定する | なし |
| CPPOPTFLAGS | C++コンパイラーに付与する最適化オプションなどを指定する | `-O3` |

### Fortran90コンパイラーに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| F90 | Fortran90コンパイラーの起動コマンドを指定する | `mpif90` |
| F90FLAGS | Fortran90コンパイラーに付与するオプションを指定する | `-DMPICH_IGNORE_CXX_SEEK` |
| F90LDFLAGS | Fortran90リンカーに付与するオプションを指定する。Intel MKLを利用する場合には、そのリンクオプションを指定する。また、REVOCAP_Refinerを使用する場合で、Fortran90プログラムのリンクにFortran90コンパイラーを用いる場合には、C++の標準ライブラリ（-lstdc++など）を指定する必要がある。 | なし |
| F90OPTFLAGS | Fortran90コンパイラーに付与する最適化オプションなどを指定する | `-O2` |
| F90LINKER | Fortran90プログラムのリンク時に用いるコマンドを指定する。REVOCAP_Refinerを使用する場合で、Fortran90プログラムのリンクにC++コンパイラーを用いる必要がある場合などに指定する（京コンピュータでは“mpiFCCpx --linkfortran” を指定する）。 | `$(F90)` |

### UNIXコマンドに関する設定

| 変数名 | 説明 | 既定値 |
|:--|:--|:--|
| MAKE | makeの起動コマンドを指定する。オプションが必要な場合は同時に指定する。 | `make` |
| AR | アーカイブの作成、変更などを行なうコマンドを指定する。オプションが必要な場合は同時に指定する。 | `ar ruv` |
| CP | ファイルやディレクトリをコピーするコマンドを指定する。オプションが必要な場合は同時に指定する。 | `cp -f` |
| RM | ファイルやディレクトリを削除するコマンドを指定する。オプションが必要な場合は同時に指定する。 | `rm -f` |
| MKDIR | ディレクトリを作成するコマンドを指定する。オプションが必要な場合は同時に指定する。 | `mkdir -p` |
| MV | ファイルを移動するコマンドを指定する。オプションが必要な場合は同時に指定する。 | `mv` |

## 付録2 Makefile.confの設定例

## 付録3 京コンピュータおよび富士通FX10における注意

本バージョンでは、京コンピュータおよび富士通FX10向けのチューニングが行われていますが、これに伴い、利用する環境に応じてソースコードの一部を変更する必要があります。

変更するファイル：

`hecmw1/src/solver/solver_33/hecmw_tuning_fx.f90`

変更内容：

ファイル内で定義されているパラーメータ変数 **TotalSectorCacheSize** を

- 京コンピュータでは **12**

- FX10では **24**

に設定する。

なお、初期状態では京コンピュータ向けの設定となっています。
