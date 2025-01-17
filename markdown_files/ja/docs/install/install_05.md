## Makefile.confでのインストール

以下の手順で、本ソフトウェアをインストールします。

### Makefile.confの編集

`${FSTRBUILDDIR}` にあるMakefile.conf.orgを、本ソフトウェアをインストールする計算機環境に合わせて編集し、Makefile.confを作成します。
定義できる変数は数多くありますが、ほとんどの変数については既定値をそのまま利用できます。
多くの環境では、下記の変数以外を変更する必要はないと思われます。

| 変数名      | 説明                                                         |
|:------------|:-------------------------------------------------------------|
| MPIDIR      | MPIがインストールされているディレクトリ                      |
| PREFIX      | 本ソフトウェアの実行モジュールをインストールするディレクトリ |
| METISDIR    | METISがインストールされているディレクトリ                    |
| REFINERDIR  | REVOCAP_Refinerがインストールされているディレクトリ          |
| REVOCAPDIR  | REVOCAP_Couplerがインストールされているディレクトリ          |
| MUMPSDIR    | MUMPSがインストールされているディレクトリ                    |
| CC          | Cコンパイラー起動コマンド                                    |
| CPP         | C++コンパイラー起動コマンド                                  |
| F90         | Fortran90コンパイラー起動コマンド                            |

すべての変数の詳細については、「付録1 Makefile.confの変数一覧」をご参照ください。
また、「付録2 Makefile.confの設定例」にMakefile.confの一例を記載します。

### setup.shの実行

`${FSTRBUILDDIR}` にて、シェルスクリプトsetup.shを以下のように実行し、
Makefileを作成します。

```txt
./setup.sh
```

並列計算用のライブラリを生成する場合などは、下記のオプションを指定してsetup.sh
を実行して下さい。

#### setup.sh 実行時オプション

| オプション           | 意味                                            | 備考                               |
|:---------------------|:------------------------------------------------|:-----------------------------------|
| -g または --debug    | デバック用ライブラリの生成                      |                                    |
| -p または --parallel | 並列実行用ライブラリの生成                      |                                    |
| --with-tools         | パーティショナーなどのツール生成                |                                    |
| --with-refiner       | REVOCAP_Refinerの組み込み                       |                                    |
| --with-revocap       | REVOCAP_Couplerの組み込み                       |                                    |
| --with-metis         | METISの使用                                     |                                    |
| --with-mkl           | Intel MKLの使用                                 |                                    |
| --with-mumps         | MUMPSの使用                                     |                                    |
| --with-lapack        | Lapackルーチンの使用                            | 条件数推定機能を利用する場合に必要 |
| --with-ml            | MLの使用                                        |                                    |
| --old-res-format     | FrontISTRのresultファイルを旧フォーマットで出力 |                                    |

以下では、setup.sh 実行の例を示します。

#### 並列処理用にコンパイルする場合

MPIがインストールされている並列実行環境で本ソフトウェアを使用する場合、以下のように**-p **または** --parallel**オプションを付けてsetup.shを起動します。

```txt
./setup.sh –p
```

#### パーティショナーなどのツールを生成する場合

パーティショナー(RCB)やビジュアライザーなどのプリ・ポスト処理用ツールが必要な場合、以下のように**--with-tools**オプションを付けてsetup.shを実行すると、各種ツールが生成されます。

```txt
./setup.sh –p --with-tools
```

#### METISを使用する場合

METISがインストールされている環境では、さらに以下のように**--with-metis**オプションを付けてsetup.shを実行すると、パーティショナーにおいてMETISの使用が可能となります。

```txt
./setup.sh –p --with-tools --with-metis
```

### makeの実行

`${FSTRBUILDDIR}` にて、以下のようにmakeを実行します。

```txt
make 2 > & 1 | tee make.log
```

makeの実行には、計算機環境によっては数十分かかる場合があります。実行中にエラーが生じた場合は、Makefile.confの設定の見直し等を行なって下さい。

### make installの実行

makeの実行が正常に終了した後、Makefile.confで指定したディレクトリに本ソフトウェアをインストールするために、
以下のようにmake installを実行します。

```txt
make install
```

### Windows環境へのインストール

Windows環境では、以下のUNIXライク環境を用いることにより、上記の手順でインストールが可能です。

- 逐次処理版：MinGW, Cygwin

- 並列処理版：MinGW + Microsoft MPI, Cygwin + OpenMPI
