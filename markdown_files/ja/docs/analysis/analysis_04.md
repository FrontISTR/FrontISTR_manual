## 単一領域メッシュデータ

### 単一メッシュデータ概要

FrontISTRのメッシュデータ取得には、単一領域メッシュデータファイルを入力する方法と並列処理するために分散メッシュデータファイルを入力する方法の二通りがある。

ここでは、単一領域メッシュデータについて記述する。

単一領域メッシュデータの特徴は以下のとおりである。

  * 自由書式に基づくASCII形式のファイルである。
  * "`!`" で始まるヘッダーとそれに続くデータから構成されている。
  * ヘッダーの記述の順番は基本的に自由である。
  * データの区切り記号には "`,`" を使用する。

### 入力規則

単一領域メッシュデータファイルは、ヘッダー行、データ行、コメント行から構成される。

ヘッダー行には必ず1つのヘッダーが含まれる。

ヘッダー
:   単一領域メッシュデータファイル内で、データの意味とデータブロックを特定する。
:   行頭が "`!`" で始まる場合、ヘッダーであるとみなされる。

ヘッダー行
:   ヘッダーとそれに伴うパラメータの内容を記述する。
:   ヘッダー行はヘッダーで始まっていなければならない。パラメータが必要な場合は、"`,`" を用いてその後に続けなければならない。
:   パラメータが値をとる場合は、パラメータの後に "`=`" が続き、その後に値を記述する。ヘッダー行を複数行にわたって記述することはできない。

データ行
:   ヘッダー行の次の行から開始され、必要なデータを記述する。
:    データ行は複数行にわたる可能性があるが、それは各ヘッダーで定義されるデータ記述の規則により決定される。
:    データ行は必要ない場合もある。

区切り文字
:   データの区切り文字にはカンマ "`,`" を用いる。

空白の扱い
:   空白は無視される。

名前
:   名前に使用可能な文字は、アンダースコア "`_`"、ハイフン "`-`"、英数字 "`a-z A-Z 0-9`" であるが、最初の一文字は "`_`" または英字 "`a-z A-Z`" で始まっていなければならない。大文字小文字の区別はなく、内部的にはすべて大文字として扱われる。
:   また、名前の最大長は63文字である。

ファイル名
:   ファイル名に使用可能な文字は、アンダースコア "`_`"、ハイフン "`-`"、ピリオド "`.`"、スラッシュ "`/`"、英数字 "`a-z A-Z 0-9`" である。
:   ファイル名は、特に記述がない限りパスを含んでもよい。相対パス、絶対パスのいずれも指定可能である。
:   また、ファイル名の最大長は1023文字である。

浮動小数点データ
:   指数はあってもなくてもよい。指数の前には、"`E`" または "`e`" の記号をつけなければならない。
:    "`E`" または "`e`" どちらを使用してもかまわない。"`D`" または "`d`" は使用不可。

!!, # コメント行
:   行頭が "`!!`" または "`#`" で始まる行はコメント行とみなされ、無視される。
:   コメント行はファイル中の任意の位置に挿入でき、その数に制限はない。

### 単一領域メッシュデータのヘッダー一覧

単一領域メッシュデータは以下のヘッダーにより構成されている。

|ヘッダー名          |内容                      |
|:-------------------|:-------------------------|
|[`!AMPLITUDE`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/amplitude.html)        | 非定常荷重               |
|[`!EGROUP`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/egroup.html)           | 要素グループ             |
|[`!ELEMENT`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/element.html)          | 要素情報                 |
|[`!EQUATION`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/equation.html)         | 拘束点情報               |
|[`!HEADER`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/header.html)           | メッシュデータのタイトル |
|[`!MATERIAL`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/material.html)         | 材料情報                 |
|[`!NGROUP`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/ngroup.html)           | 節点グループ             |
|[`!NODE`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/node.html)             | 節点情報                 |
|[`!SECTION`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/section.html)          | セクション情報           |
|[`!SGROUP`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/sgroup.html)           | 面グループ               |
|[`!ZERO`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/zero.html)             | 絶対零度                 |
|[`!CONTACT PAIR`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/contactpair.html)     | 接触面ペア               |
|[`!END`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/msh/end.html)              | 読み込み終了             |

各ヘッダーには，パラメータとそれぞれのヘッダーに対応したデータの項目がある。

以下，上記各ヘッダーについてデータ作成例とともに簡単に説明する。データ作成例の右端に示している番号は上記表の説明番号である。

#### メッシュデータ例

```
!HEADER                                         M1-5
  TEST MODEL CTLR10

!NODE                                           M1-9
  1, 0.00000E+00, 0.00000E+00, 0.00000E+00
  2, 0.50000E+01, 0.00000E+00, 0.00000E+00
  3, 0.10000E+02, 0.00000E+00, 0.00000E+00
  .. ...          ...          ...

!ELEMENT,TYPE=351                               M1-3
  1, 1, 2, 4, 34, 35, 37
  2, 2, 5, 4, 35, 38, 37
  3, 2, 3, 5, 35, 36, 38

!SECTION, TYPE=SOLID, EGRP=ALL, MATERIAL=M1     M1-9
  1.0

!MATERIAL, NAME=M1, ITEM=2                      M1-6
!ITEM=1, SUBITEM=2
  2.1E5, 0.3
!ITEM=2, SUBITEM=1
7.8e-6

!NGROUP, NGRP=FIX, GENERATE                     M1-7
  2 , 2 , 1
  3 , 3 , 1
  1 , 1 , 1
  69 , 69 , 1
  67 , 67 , 1

!NGROUP, NGRP=CL1                               M1-8
  50

!END                                            M1-13
```
