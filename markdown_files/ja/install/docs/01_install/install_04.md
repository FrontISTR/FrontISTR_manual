# cmakeでのインストール

## cmakeでのインストール
<a href="cmake"></a>
cmakeには、ライブラリの自動探索機能が備わっています。それらを手動で明示することもできます。

### cmakeのオプション

| オプション              | 説明                                          | 備考                           |
|-------------------------|-----------------------------------------------|--------------------------------|
| -DWITH_TOOLS=1 | パーティショナなどのツールもコンパイル  | hecmw_part1など                |
| -DWITH_MPI=1            | MPIを有効                             | ライブラリが必要               |
| -DWITH_OPENMP=1         | OpenMPを有効                          | コンパイラの対応が必要         |
| -DWITH_REFINER=1        | REVOCAP_Refinerの機能を有効           | ライブラリが必要               |
| -DWITH_REVOCAP=1        | REVOCAP_Couplerの機能を有効           | ライブラリが必要               |
| -DWITH_PARAC=1          | 並列接触解析の機能を有効              |                                |
| -DWITH_METIS=1          | METISの機能を有効                     | 4.0.3と5.1.0に対応             |
| -DMETIS_VER_4=1         | metis-4.0.3を使う場合に設定 | metis-5.1.0の場合指定不要      |
| -DWITH_PARMETIS=1       | ParMETISの機能を有効                  | 3.2.0と4.0.3に対応             |
| -DMETIS_VER_3=1         | ParMetis-3.2.0を使う場合に設定                | parmetis-4.0.3の場合指定不要   |
| -DWITH_MKL=1            | MKL PARDISOの機能を有効               | ライブラリが必要               |
| -DWITH_MUMPS=1          | MUMPSの機能を有効                     | ライブラリが必要               |
| -DWITH_LAPACK=1         | LAPACKの機能を有効                    | ライブラリが必要               |
| -DWITH_ML=1             | Trilinos MLの機能を有効               | ライブラリが必要               |
| -DWITH_DOC=1            | FrontISTRのソースコードをドキュメント化 | doxygenとgraphvizが必要        |
| -DBLA_VENDOR="Generic"  | 利用するBLASのベンダーを指定                  | FindBLAS.cmakeを参照           |
| -DBLAS_LIBRARIES=".."   | BLASライブラリを直接指定                      | ライブラリを絶対パスで直接指定 |
| -DLAPACK_LIBRARIES=".." | LAPACKライブラリを直接指定                    | ライブラリを絶対パスで直接指定 |
| -DCMAKE_INSTALL_PREFIX= | インストールするパスを設定。デフォルトは`/usr/local` | -DCMAKE_INSTALL_PREFIX=$HOME/local で $HOME/local/bin などにプログラムがインストールされる　|
| -DCMAKE_C_COMPILER=     | Cコンパイラを指定        | -DCMAKE_C_COMPILER=icc  (Intel Cコンパイラ）                                                |
| -DCMAKE_CXX_COMPILER=   | C++コンパイラを指定     | -DCMAKE_CXX_COMPILER=icpc  (Intel C++コンパイラ)                                            |
| -DCMAKE_Fortran_COMPILER= | Fortranコンパイラを指定  | -DCMAKE_Fortran_COMPILER=ifort  (Intel Fortranコンパイラ)                                   |
| -DCMAKE_PREFIX_PATH=      | ライブラリ等の格納場所を指定 | -DCMAKE_PREFIX_PATH=$HOME/tools (ライブラリやインクルードファイルを探索するパス)            |

