# 動作環境

## 必要なソフトウェア

本ソフトウェアのインストールに際して、インストールする環境に以下のソフトウェアがインストールされている必要があります。
なお、これらのソフトウェアのインストールについては、各ソフトウェアのインストールマニュアルをご参照ください。

### C、C++、Fortran90コンパイラー

本ソフトウェアのインストールには、C、C++およびFortran90コンパイラーが必要です。

### Boostライブラリ

本ソフトウェアのC++ソースコードのコンパイルには、Boostライブラリが必要です。
インストールする環境にBoostライブラリがインストールされていない場合、下記のWEBサイトからダウンロードすることができます。

[link: http://www.boost.org/](http://www.boost.org/)

### Intel MKL（Math Kernel Library）

本ソフトウェアの接触解析モジュールでは、Intel
MKLを利用しています。インストールする環境にIntel
MKLがインストールされていない場合、接触解析の一部の機能が利用できません。

### MPI

本ソフトウェアはMPIにより並列化されているため、MPI-1規格に準拠したMPIライブラリが必要となります。
MPIを実装したフリーで利用できるライブラリの代表的なものには、MPICHやOpenMPIなどがあります。
MPICHは下記のWEBサイトからダウンロードすることができます。

[link: http://www.mcs.anl.gov/research/projects/mpich2](http://www.mcs.anl.gov/research/projects/mpich2)

### METIS

本ソフトウェアの領域分割ユーティリティは、METISのライブラリを使用することでpMETIS、kMETISによる領域分割が可能です。
これらの領域分割機能を利用する場合にはMETISが必要となります。
なお、METISのバージョンは、最新のVer.5系列とVer.4系列が利用可能ですが、後述のMUMPSを利用する場合で、MUMPSのオーダリングにMETISを利用する場合には、MUMPSがMETISのVer.4系列のみに対応しているため、Ver.4系列のMETISをお使いください。
また、METISがインストールされていない環境でも、RCBアルゴリズムによる領域分割は可能です。
METISは下記のWEBサイトからダウンロードすることができます。

[link: http://glaros.dtc.umn.edu/gkhome/views/metis/index.html](http://glaros.dtc.umn.edu/gkhome/views/metis/index.html)

### ParMETIS

本ソフトウェアの並列領域分割ユーティリティは、ParMETISライブラリを使用する予定です。

現時点ではParMETISは不要です。

### HEC-MW

本ソフトウェアは、「革新的シミュレーションソフトウェアの研究開発」プロジェクトおよび「イノベーション基盤シミュレーションソフトウェアの研究開発」プロジェクトで開発されたHEC-MWライブラリを利用しています。
このHEC-MWはFrontISTRのアーカイブに同梱されており、本ソフトウェアのインストール時に自動的にコンパイルされるため、別途インストールする必要はありません。

### REVOCAP\_Refiner

本ソフトウェアは、「イノベーション基盤シミュレーションソフトウェアの研究開発」プロジェクトで開発されたメッシュ細分化ツールREVOCAP\_Refinerに対応しています。
メッシュ細分化機能を利用する場合にはREVOCAP\_Refinerが必要となります。
REVOCAP\_Refinerは下記のWEBサイトからダウンロードすることができます。

[link: http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php](http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php)

### REVOCAP\_Coupler

本ソフトウェアは、「イノベーション基盤シミュレーションソフトウェアの研究開発」プロジェクトで開発された連成解析ツールREVOCAP\_Couplerに対応しています。連成解析機能を利用する場合にはREVOCAP\_Couplerが必要となります。REVOCAP\_Couplerは下記のWEBサイトからダウンロードすることができます。

[link: http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php](http://www.ciss.iis.u-tokyo.ac.jp/dl/index.php)

### MUMPS

本ソフトウェアは、パブリックドメインの並列直接法ソルバーMUMPS（a
MUltifrontal Massively Parallel sparse direct
Solver）に対応しています。MUMPSは、Esprit IV European project PARASOL
(1996-1999)で開発されたソフトウェアをベースとし、CERFACS, CNRS, ENS
Lyon, INPT(ENSEEIHT)-IRIT, INRIA, および University of
Bordeauxの各機関により研究開発されたものです。MUMPSは下記のWEBサイトからダウンロードすることができます。

[link: http://graal.ens-lyon.fr/MUMPS](http://graal.ens-lyon.fr/MUMPS)

### ML

本ソフトウェアは、代数マルチグリッド法に基づく前処理ライブラリML（Multi-Level
Preconditioner）に対応しています。MLは、Sandia National
Laboratoriesで進められているTrilinosプロジェクトで開発されているパッケージのひとつです。
MLは下記のWEBサイトからダウンロードすることができます。

[link: http://trilinos.org/packages/ml](http://trilinos.org/packages/ml)

## 動作確認環境

本ソフトウェアは、下記の環境において動作確認を行っています。
ただし、これ以外の環境においても、前述のインストールに必要なソフトウェアが導入されている場合、正常に動作すると思われます。

### 動作確認環境

| 環境 (OS) | コンパイラ | 並列化環境 |
|:--|:--|:--|
| K computer | Fujitsu Compiler | Fujitsu MPI |
| EARTH SIMULATOR (ES2) | NEC Compiler | NEC MPI |
| Intel Xeon Cluster<br> CentOS 5 | Intel Compiler | Intel MPI |
| AMD Opteron Cluster<br> RedHat Enterprise Linux 5 | Intel Compiler | OpenMPI |
| Intel Itanium Cluster<br> SUSE Linux Enterprise 10 | Intel Compiler | Intel MPI |
| AMD Opteron Cluster<br> CentOS 4.4 | Intel Compiler | MPICH 1.2.7p1 |
| PC<br> Windows XP<br> Windows 7 | gnu Compiler | MPICH2-1.3.2p1 |
