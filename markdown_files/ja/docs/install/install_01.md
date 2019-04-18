*** Last updated 2019-04-18 ***

# 動作環境

## 必要なソフトウェア

本ソフトウェアのインストールに際して、インストールする環境に以下のソフトウェアがインストールされている必要があります。
なお、これらのソフトウェアのインストールについては、各ソフトウェアのインストールマニュアルをご参照ください。

### C、C++、Fortran90コンパイラー

本ソフトウェアのインストールには、C、C++およびFortran90コンパイラーが必要です。

### MPI

本ソフトウェアはMPIにより並列化されているため、MPI-1規格に準拠したMPIライブラリが必要となります。
MPIを実装したフリーで利用できるライブラリの代表的なものには、MPICHやOpenMPIなどがあります。

OpenMPIは下記のWEBサイトから

[https://www.open-mpi.org/](https://www.open-mpi.org/)

MPICHは下記のWEBサイトからダウンロードすることができます。

[http://www.mpich.org/](http://www.mpich.org/)

### METIS

本ソフトウェアの領域分割ユーティリティは、METISのライブラリを使用することでpMETIS、kMETISによる領域分割が可能です。
これらの領域分割機能を利用する場合にはMETISが必要となります。
なお、METISのバージョンは、最新のVer.5系列とVer.4系列が利用可能です。

また、METISがインストールされていない環境でも、RCBアルゴリズムによる領域分割は可能です。

METISは下記のWEBサイトからダウンロードすることができます。

[http://glaros.dtc.umn.edu/gkhome/metis/metis/overview](http://glaros.dtc.umn.edu/gkhome/metis/metis/overview)

### ParMETIS

本ソフトウェアの並列領域分割ユーティリティは、ParMETISライブラリを使用する予定です。

現時点ではParMETISは不要です。

ParMETISは下記のWEBサイトからダウンロードすることができます。

[http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview](http://glaros.dtc.umn.edu/gkhome/metis/parmetis/overview)

### HEC-MW

本ソフトウェアは、「革新的シミュレーションソフトウェアの研究開発」プロジェクトおよび「イノベーション基盤シミュレーションソフトウェアの研究開発」プロジェクトで開発されたHEC-MWライブラリを利用しています。

このHEC-MWはFrontISTRのアーカイブに同梱されており、本ソフトウェアのインストール時に自動的にコンパイルされるため、別途インストールする必要はありません。

### REVOCAP\_Refiner

本ソフトウェアは、「イノベーション基盤シミュレーションソフトウェアの研究開発」プロジェクトで開発されたメッシュ細分化ツールREVOCAP\_Refinerに対応しています。

メッシュ細分化機能を利用する場合にはREVOCAP\_Refinerが必要となります。
REVOCAP\_Refinerの最新版は下記のWEBサイトからダウンロードすることができます。

[http://www.multi.k.u-tokyo.ac.jp/FrontISTR/](http://www.multi.k.u-tokyo.ac.jp/FrontISTR/)

### REVOCAP\_Coupler

本ソフトウェアは、「イノベーション基盤シミュレーションソフトウェアの研究開発」プロジェクトで開発された連成解析ツールREVOCAP\_Couplerに対応しています。連成解析機能を利用する場合にはREVOCAP\_Couplerが必要となります。REVOCAP\_Couplerは下記のWEBサイトからダウンロードすることができます。

[http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php](http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php)

### LAPACK/BLAS

本ソフトウェアは、CG法およびGMRES法を用いた前処理適用後行列の条件数推定機能が実装されています。
本機能を利用する場合にはLAPACKが必要になります。また、LAPACKを利用するにはBLASが必要となります。

LAPACKのリファレンス実装は下記WEBサイトからダウンロードすることができます。

[http://www.netlib.org/lapack/](http://www.netlib.org/lapack/)

BLASのリファレンス実装は下記WEBサイトからダウンロードすることができます。

[http://www.netlib.org/blas/](http://www.netlib.org/blas/)

高速なオープンソースの実装としてはOpenBLASなどが利用できます。OpenBLASは下記WEBサイトからダウンロードすることができます。

[http://www.openblas.net/](http://www.openblas.net/)

なお、後述するIntel MKLがインストールされている場合、改めてインストールする必要はありません。

### MUMPS

本ソフトウェアは、パブリックドメインの並列直接法ソルバーMUMPS（a
MUltifrontal Massively Parallel sparse direct
Solver）に対応しています。MUMPSは、Esprit IV European project PARASOL
(1996-1999)で開発されたソフトウェアをベースとし、CERFACS, CNRS, ENS
Lyon, INPT(ENSEEIHT)-IRIT, INRIA および University of
Bordeauxの各機関により研究開発されたものです。MUMPSは下記のWEBサイトからダウンロードすることができます。

[http://mumps.enseeiht.fr/](http://mumps.enseeiht.fr/)

### ScaLAPACK

本ソフトウェアで直接利用していませんが、上述のMUMPSはScaLAPACKを利用します。ScaLAPACKは下記のWEBサイトからダウンロードすることができます。

[http://www.netlib.org/scalapack/](http://www.netlib.org/scalapack/)

なお、後述するIntel MKLがインストールされScaLAPACKライブラリがインストールされている場合、改めてインストールする必要はありません。

### ML

本ソフトウェアは、代数マルチグリッド法に基づく前処理ライブラリML（Multi-Level
Preconditioner）に対応しています。MLは、Sandia National
Laboratoriesで進められているTrilinosプロジェクトで開発されているパッケージのひとつです。
MLは下記のWEBサイトからダウンロードすることができます。

[https://trilinos.org/](https://trilinos.org/)

### Intel MKL（Math Kernel Library）

本ソフトウェアの接触解析モジュールでは、Intel MKLを利用しています。

インストールする環境にIntel MKLがインストールされていない場合、接触解析の一部の機能が利用できません。

## 動作確認環境

本ソフトウェアは、下記の環境において動作確認を行っています。
ただし、これ以外の環境においても、前述のインストールに必要なソフトウェアが導入されている場合、正常に動作すると思われます。

### 動作確認環境

| 環境 (OS) | コンパイラ | 並列化環境 |
|:--|:--|:--|
| K computer | Fujitsu Compiler | Fujitsu MPI |
| EARTH SIMULATOR (ES3) | NEC Compiler | NEC MPI |
| Intel Xeon Cluster<br> CentOS 7 | Intel Compiler | Intel MPI |
| Intel Xeon Cluster<br> RedHat Enterprise Linux 7 | Intel Compiler | OpenMPI |
| Intel Xeon Cluster<br> SUSE Linux Enterprise 10 | Intel Compiler | SGI MPT |
| AMD Ryzen PC<br> ubuntu 16.04 | GNU Compiler | OpenMPI-1.10.2|
| AMD Ryzen PC<br> ubuntu 16.04 | PGI Compiler | OpenMPI-1.10.2|
| AMD Ryzen PC<br> ubuntu 18.04 | GNU Compiler | OpenMPI-2.1.1|
| Intel Core i7 PC<br> ubuntu 16.04 | GNU Compiler | OpenMPI-1.10.2|
| Intel Core i7 PC<br> ubuntu 18.04 | GNU Compiler | OpenMPI-2.1.1|
| Intel Core i7 PC<br> CentOS 7 | GNU Compiler | OpenMPI-1.10.2 |
| PC<br> Windows 7 <br> Windows 10 | GNU Compiler | Microsoft MPI-8.1 |
| SBC<br> Raspberry Pi 3| GNU Compiler | OpenMPI-2.0.2 |
