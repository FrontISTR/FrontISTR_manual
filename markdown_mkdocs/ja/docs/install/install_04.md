# インストール

以下の手順で、本ソフトウェアをインストールします。

## Makefile.confの編集

\${FSTRBUILDDIR}にあるMakefile.conf.orgを、本ソフトウェアをインストールする計算機環境に合わせて編集し、Makefile.confを作成します。定義できる変数は数多くありますが、ほとんどの変数については既定値をそのまま利用できます。多くの環境では、下記の変数以外を変更する必要はないと思われます。

MPIDIR ：MPIがインストールされているディレクトリ

PREFIX ：本ソフトウェアの実行モジュールをインストールするディレクトリ

METISDIR ：METISがインストールされているディレクトリ

PARMETISDIR：ParMETISがインストールされているディレクトリ

REFINERDIR：REVOCAP\_Refinerがインストールされているディレクトリ

REVOCAPDIR：REVOCAP\_Couplerがインストールされているディレクトリ

MUMPSDIR： MUMPSがインストールされているディレクトリ

CC ：Cコンパイラー起動コマンド

CPP ：C++コンパイラー起動コマンド

F90 ：Fortran90コンパイラー起動コマンド

すべての変数の詳細については、「付録1　Makefile.confの変数一覧」をご参照ください。また、「付録2　Makefile.confの設定例」にMakefile.confの一例を記載します。

## setup.shの実行

\${FSTRBUILDDIR}にて、シェルスクリプトsetup.shを以下のように実行し、
Makefileを作成します。

\$ ./setup.sh

並列計算用のライブラリを生成する場合などは、下記のオプションを指定してsetup.sh
を実行してください。

表2　setup.sh 実行時オプション

  オプション             意 味                                備 考
  ---------------------- ------------------------------------ ------------------------------------
  -g または --debug      デバック用ライブラリの生成           
  -p または --parallel   並列実行用ライブラリの生成           
  --with-tools           パーティショナーなどのツール生成     
  --with-refiner         REVOCAP\_Refinerの組み込み           
  --with-revocap         REVOCAP\_Couplerの組み込み           
  --with-metis           METIS の使用                         
  --with-parmetis        ParMETIS の使用                      現時点では無効
  --with-mkl             Intel MKLの使用                      
  --with-mumps           MUMPSの使用                          
  --with-paracon         並列接触解析用実行モジュールの生成   
  --with-lapack          Lapackルーチンの使用                 条件数推定機能を利用する場合に必要
  --with-ml              MLの使用                             

以下では、setup.sh 実行の例を示します。

\(1) 並列処理用にコンパイルする場合

MPIがインストールされている並列実行環境で本ソフトウェアを使用する場合、以下のように-pまたは--parallel
オプションを付けてsetup.shを起動します。

\$ ./setup.sh –p

\(2) パーティショナーなどのツールを生成する場合

　パーティショナー（RCB）やビジュアライザーなどのプリ・ポスト処理用ツールが必要な場合、以下のように-with-toolsオプションを付けてsetup.shを実行すると、各種ツールが生成されます。

\$ ./setup.sh –p --with-tools

\(3) METISを使用する場合

METISがインストールされている環境では、さらに以下のように--with-metisオプションを付けてsetup.shを実行すると、パーティショナーにおいてMETISの使用が可能となります。

\$ ./setup.sh –p --with-tools --with-metis

\(4) 接触解析用にコンパイルする場合

接触解析用にコンパイルする場合、並列なしの場合と並列ありの場合の2通りの方法があります。並列なしの場合は、Intel
MKLまたはMUMPSの利用が必要となります。

\$ ./setup.sh --with-mkl　　または、　\$ ./setup.sh --with-mumps

並列ありで接触解析を行う場合は、-p、--with-metisオプションも必要となります。また並列ありの場合はIntl
MKLは使えません。

\$ ./setup.sh –p --with-metis --with\_mumps --with\_paracon

## makeの実行

\${FSTRBUILDDIR}にて、以下のようにmakeを実行します。

\$ make 2&gt;&1 | tee make.log

makeの実行には、計算機環境によっては数十分かかる場合があります。実行中にエラーが生じた場合は、Makefile.confの設定の見直し等を行なってください。

## make installの実行

makeの実行が正常に終了した後、Makefile.confで指定したディレクトリに本ソフトウェアをインストールするために、以下のようにmake
installを実行します。

\$ make install

## Windows環境におけるインストール

　Windows環境では、以下のUNIXライク環境を用いることにより、上記の手順でインストールが可能です。

　　逐次処理版：MinGW

　　並列処理版：Cygwin
