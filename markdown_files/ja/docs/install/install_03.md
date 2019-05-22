## インストール

### サポートされているインストール方法

本ソフトウェアでは、2つのインストール方法がサポートされています。

#### cmakeでのインストール

本ソフトウェアは、cmakeを用いたインストールをサポートしています。

cmakeを予めインストールしておく必要があります。cmakeは下記WEBサイトからダウンロードすることができます。

[https://cmake.org/](https://cmake.org/)

```
$ cd ${FSTRBUILDDIR}
$ mkdir build
$ cd build
$ cmake ..
$ make -j2
$ make install
```

インストールされているライブラリを自動で探索し、FrontISTRの機能を有効にします。また、複数コアを持ったコンピュータでは、並列コンパイルを有効にすることで、コンパイル時間の短縮が期待できます。

[cmakeでのインストール つづき](install_04)

##### 参考

  - [参考 CentOS7.6へのインストール手順例(cmake)](install_07)
  - [参考 Ubuntu18.04へのインストール手順例(cmake)](install_09)

#### Makefile.confでのインストール

本ソフトウェアでは、手動でライブラリやコンパイラ、有効にする機能を指定する方法がサポートされています。

```
$ cd ${FSTRBUILDDIR}
$ cp Makefile.conf.org Makefile.conf
$ vi Makefile.conf
  ファイルを編集しコンパイラやライブラリの場所を指定
$ ./setup.sh [有効にしたい機能を指定]
$ make
$ make install
```

cmake での自動設定が困難な環境では、こちらの方法での構築を推奨します。なお、こちらの方法は並列コンパイルがサポートされていません。

[Makefile.confでのインストール つづき](install_05)

##### 参考

  - [参考 CentOS7.6へのインストール手順例(Makefile.conf)](install_08)
  - [参考 Ubuntu18.04へのインストール手順例(Makefile.conf)](install_10)
  - [参考 Windows10へのインストール手順例(Makefile.conf)](install_11)


