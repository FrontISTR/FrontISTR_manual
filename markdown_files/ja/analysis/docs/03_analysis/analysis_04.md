# 単一領域メッシュデータ

## 単一メッシュデータ概要

FrontISTRのメッシュデータ取得には、単一領域メッシュデータファイルを入力する方法と並列処理するために分散メッシュデータファイルを入力する方法の二通りがある。
ここでは、単一領域メッシュデータについて記述する。

単一領域メッシュデータの特徴は以下のとおりである。

  - 自由書式に基づくASCII形式のファイルである。
  - 「!」で始まるヘッダーとそれに続くデータから構成されている。
  - ヘッダーの記述の順番は基本的に自由である。
  - データの区切り記号には「,」を使用する。

## 入力規則

単一領域メッシュデータファイルは、ヘッダー行、データ行、コメント行から構成される。

ヘッダー行には必ず1つのヘッダーが含まれる。

  - ヘッダー
    単一領域メッシュデータファイル内で、データの意味とデータブロックを特定する。
    行頭が「!」で始まる場合、ヘッダーであるとみなされる。

  - ヘッダー行
    ヘッダーとそれに伴うパラメータの内容を記述する。
    ヘッダー行はヘッダーで始まっていなければならない。パラメータが必要な場合は、「,」を用いてその後に続けなければならない。
    パラメータが値をとる場合は、パラメータの後に「=」が続き、その後に値を記述する。ヘッダー行を複数行にわたって記述することはできない。

  - データ行
    ヘッダー行の次の行から開始され、必要なデータを記述する。
    データ行は複数行にわたる可能性があるが、それは各ヘッダーで定義されるデータ記述の規則により決定される。
    データ行は必要ない場合もある。

  - 区切り文字
    データの区切り文字にはカンマ「,」を用いる。

  - 空白の扱い
    空白は無視される。

  - 名前
    名前に使用可能な文字は、アンダースコア「\_」、ハイフン「-」、英数字「a-z　A-Z　0-9」であるが、最初の一文字は「\_」または英字「a-z　A-Z」で始まっていなければならない。大文字小文字の区別はなく、内部的にはすべて大文字として扱われる。
    また、名前の最大長は63文字である。

  - ファイル名
    ファイル名に使用可能な文字は、アンダースコア「\_」、ハイフン「-」、ピリオド「.」、スラッシュ「/」、英数字「a-z　A-Z　0-9」である。
    ファイル名は、特に記述がない限りパスを含んでもよい。相対パス、絶対パスのいずれも指定可能である。
    また、ファイル名の最大長は1023文字である。

  - 浮動小数点データ
    指数はあってもなくてもよい。指数の前には、「E」または「e」の記号をつけなければならない。
    「E」または「e」どちらを使用してもかまわない。「D」または「ｄ」は使用不可。

  - !!, \#　　コメント行
    行頭が「!!」または「\#」で始まる行はコメント行とみなされ、無視される。
    コメント行はファイル中の任意の位置に挿入でき、その数に制限はない。

## 単一領域メッシュデータのヘッダー一覧

単一領域メッシュデータは以下のヘッダーにより構成されている。

|ヘッダー名  |内容                      |
|:-----------|:-------------------------|
|!CONTROL    |解析制御データ定義        |
|!MESH       |メッシュデータ定義        |
|!RESTART    |リスタートデータ定義      |
|!RESULT     |解析結果データ定義        |
|!SUBDIR     |サブディレクトリ分割指示  |

|ヘッダー名  |内容                      |
|:-----------|:-------------------------|
| !AMPLITUDE         | 非定常荷重               |
| !EGROUP            | 要素グループ             |
| !ELEMENT           | 要素情報                 |
| !EQUATION          | 拘束点情報               |
| !HEADER            | メッシュデータのタイトル |
| !INITIAL CONDITION | 初期条件                 |
| !MATERIAL          | 材料情報                 |
| !NGROUP            | 節点グループ             |
| !NODE              | 節点情報                 |
| !SECTION           | セクション情報           |
| !SGROUP            | 面グループ               |
| !ZERO              | 絶対零度                 |
| !CONTACT PAIR      | 接触面ペア               |
| !END               | 読み込み終了             |

各ヘッダーには，パラメータとそれぞれのヘッダーに対応したデータの項目がある。

以下，上記各ヘッダーについてデータ作成例とともに簡単に説明する。データ作成例の右端に示している番号は上記表の説明番号である。

＜メッシュデータ例＞

```
!HEADE
TEST MODEL CTLR10

!NODE
1, 0.00000E+00, 0.00000E+00, 0.00000E+00
2, 0.50000E+01, 0.00000E+00, 0.00000E+00
3, 0.10000E+02, 0.00000E+00, 0.00000E+00

!ELEMENT,TYPE=351
1, 1, 2, 4, 34, 35, 37
2, 2, 5, 4, 35, 38, 37
3, 2, 3, 5, 35, 36, 38

!SECTION, TYPE=SOLID, EGRP=ALL, MATERIAL=M1
1.0

!MATERIAL, NAME=M1, ITEM=2
!ITEM=1, SUBITEM=2
2.1E5, 0.3
!ITEM=2, SUBITEM=1
7.8e-6

!NGROUP, NGRP=FIX, GENERATE
2 , 2 , 1
3 , 3 , 1
1 , 1 , 1
69 , 69 , 1
67 , 67 , 1

!NGROUP, NGRP=CL1
50

!END
```

*****
##### !AMPLITUDE（M1-1）

ステップ内での荷重条件を与える変数の時間変化の指定

```
!AMPLITUDE, NAME=<name> [, optional parameter]
VAL1, T1, VAL2, T2, VAL3, T3

#（一行に四項まで）
```

| パラメータ  |                |
|:------------|:---------------|
  NAME         名前（必須）
  DEFINITION   タイプ（省略可）
  TIME         時間の種類（省略可）
  VALUE        値の種類（省略可）
  INPUT        外部ファイル名（省略可）

| パラメータ名  |パラメータ値  |内 容           |
|:--------------|:-------------|:---------------|
  NAME           &lt;name&gt;       AMPLITUDE名
  DEFINITION     TABULAR            デフォルト（現版ではデフォルトのみ）
  TIME           STEP TIME          デフォルト（現版ではデフォルトのみ）
  VALUE          RELATIVE           相対値（デフォルト）
                 ABSOLUTE           絶対値
  INPUT          &lt;filename&gt;   外部ファイル名（省略可）、2行目以降との併用も可能

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  VAL1     R      時間T1における値
  T1       R      時間T1
  VAL2     R      時間T2における値
  T2       R      時間T2
  VAL3     R      時T3における値
  T3       R      時間T3

*****
##### !EGROUP（M1-2）

要素グループの定義

1行目 {#行目-1 .afff5}

!EGROUP, EGRP=&lt;egrp&gt; \[, optional parameter\]

| パラメータ  |                |
|:------------|:---------------|
  EGRP         要素グループ名（必須）
  GENERATE     要素グループに属する節点の自動生成（省略可）
  INPUT        外部ファイル名（省略可）

| パラメータ名  |パラメータ値  |内 容           |
|:--------------|:-------------|:---------------|
  EGRP           &lt;egrp&gt;       要素グループ名
  GENERATE       なし               要素グループに属する節点の自動生成
  INPUT          &lt;filename&gt;   外部ファイル名（省略可）、2行目以降との併用も可能

2行目以降（GENERATEを使用しない場合） {#行目以降generateを使用しない場合 .afff5}

（2行目）elem1, elem2, elem3 ...

（以下同様）

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  elemX    I      要素グループに属する要素番号

2行目以降（GENERATEを使用する場合） {#行目以降generateを使用する場合 .afff5}

（2行目）elem1, elem2, elem3

（以下同様）

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  elem1    I       要素グループ内の最初の要素番号
  elem2    I       要素グループ内の最後の要素番号
  elem3    I       要素番号増分（省略可能、省略時はelem3=1となる）

注意 {#注意 .afff5}

-   1行に任意の数の要素を入れることができる。また次のオプションが始まるまで、任意の数の行を挿入することができる。

-   指定する要素は「!EGROUP」より前に定義されている必要がある。

-   「!ELEMENT」オプションで定義されていない要素は除外され、警告メッセージが表示される。

-   指定された要素が既に同じグループ内に存在する場合は無視され、警告メッセージが表示される。

-   すべての要素は、「ALL」という名前の要素グループに属している（自動的に生成される）。

-   ひとつのグループを複数回にわけて定義できる。

使用例 {#使用例 .afff5}

!EGROUP, EGRP=EA01

1, 2, 3, 4, 5, 6

101, 102

205

!EGROUP, EGRP=EA02

101, 102

!EGROUP, EGRP=EA01 グループ「EA01」に「501, 505」が追加される。

501, 505

!EGROUP, EGRP=EA04,　GENERATE グループ「NA04」に

301, 309, 2 「301,303,305,307,309,311,312,313」が追加される。

311, 313

*****
##### !ELEMENT（M1-3）

要素の定義

1行目 {#行目-2 .afff5}

!ELEMENT, TYPE=&lt;type&gt; \[, optional parameter\]

| パラメータ  |                |
|:------------|:---------------|
  TYPE         要素タイプ（必須）
  EGRP         要素グループ名（省略可）
  MATITEM      材料物性を要素ごとに定義する場合の物性項目数（セクションごとに物性を定義する場合は使用しない）
  INPUT        外部ファイル名（省略可）

| パラメータ名  |パラメータ値  |内 容           |
|:--------------|:-------------|:---------------|
  TYPE           111                ロッド、リンク要素（一次）
                 231                三角形要素（一次）
                 232                三角形要素（二次）
                 241                四角形要素（一次）
                 242                四角形要素（二次）
                 301                トラス要素（一次）
                 341                四面体要素（一次）
                 342                四面体要素（二次）
                 351                三角柱要素（一次）
                 352                三角柱要素（二次）
                 361                六面体要素（一次）
                 362                六面体要素（二次）
                 541                インターフェース要素（四角形断面，一次）
                 611                梁要素(一次)
                 641                梁要素(一次, 3自由度節点4点による)
                 731                三角形シェル要素（一次）
                 741                四角形シェル要素（一次）
                 743                四角形シェル要素（二次）
                 761                三角形シェル要素（一次, 3自由度節点6点による）
                 781                四角形シェル要素（一次, 3自由度節点8点による）
  EGRP           &lt;egrp&gt;       要素グループ名（省略可）
  INPUT          &lt;filename&gt;   外部ファイル名（省略可）、2行目以降との併用も可能

2行目以降 {#行目以降-1 .afff5}

（2行目）ELEM\_ID, nod1, nod2, nod3, ..., MAT1, MAT2, ...

（以下同様）

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  ELEM\_ID   I       要素番号
  nodX       I       コネクティビティ
  MATy       R       要素ごとの物性値

注意 {#注意-1 .afff5}

-   要素タイプ、コネクティビティの詳細は、「4章　要素ライブラリ」を参照のこと。

-   コネクティビティで指定する節点は「!ELEMENT」より前に定義されている必要がある。

-   要素番号は連続している必要はない。

-   「!ELEMENT」オプションは何回でも定義できる。

-   要素番号は自然数でなければならない。省略は不可。

-   同じ要素番号を重複して使用する場合、最後に入力した値が使用される。この場合、警告メッセージが出力される。

-   定義されていない節点をコネクティビティに使用することはできない。

-   ひとつの要素の定義を複数行にわたって記述してもよい。

使用例 {#使用例-1 .afff5}

!ELEMENT, TYPE=231

1, 1, 2, 3

2, 4, 8, 5

4, 6, 7, 8

!ELEMENT, TYPE=361, EGRP=A

101, 101, 102, 122, 121, 201, 202, 222, 221

102, 102, 103, 123, 122, 202, 203, 223, 222

103, 103, 104, 124, 123, 203, 204, 224, 223

*****
##### !EQUATION（1-4）

拘束節点グループの定義

1行目 {#行目-3 .afff5}

!EQUATION \[, optional parameter\]

| パラメータ  |                |
|:------------|:---------------|
  INPUT        外部ファイル名（省略可）

| パラメータ名  |パラメータ値  |内 容           |
|:--------------|:-------------|:---------------|
  INPUT          &lt;filename&gt;   外部ファイル名（省略可）、2行目以降との併用も可能

2行目以降 {#行目以降-2 .afff5}

（2行目 ）NEQ, CONST

（3行目以降）nod1, DOF1, A1, nod2, DOF2, A2 ...（一行に七項まで）

以下繰り返し

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  NEQ      I       方程式の項数
  CONST    R       方程式の定数項（右辺値）
  nod1     I/C     第1節点または節点グループ
  DOF1     I       第1節点または節点グループの拘束自由度
  A1       R       第1節点または節点グループの係数
  nod2     I/C     第2節点または節点グループ
  DOF2     I       第2節点または節点グループの拘束自由度
  A2       R       第2節点または節点グループの係数

注意 {#注意-2 .afff5}

-   「!NODE」で定義されていない節点、節点グループが指定された場合は無視され、警告メッセージが表示される。

-   「nod1=nod2」の場合は無視され、警告メッセージが表示される。

-   節点グループを指定した場合、節点数の整合性が取れない場合はエラーとなる。

-   自由度番号は解析のタイプ、要素によって異なる。整合がとれない自由度については無視され、警告メッセージが表示される。

使用例 {#使用例-2 .afff5}

!EQUATION

3

101, 1, 1.0, 102, 1, -1.0, 103, 1, -1.0

2

NG1, 2, 1.0, NG5, 2, -1.0

*****
##### !HEADER（M1-5）

メッシュデータのタイトル

1行目 {#行目-4 .afff5}

!HEADER

パラメータ

なし

2行目以降 {#行目以降-3 .afff5}

（2行目）TITLE

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  TITLE    C      ヘッダータイトル

使用例 {#使用例-3 .afff5}

!HEADER

Mesh for CFD Analysis

注意 {#注意-3 .afff5}

-   省略可能。

-   ヘッダーは複数行にわたってもよいが、ヘッダーとして認識されるのは最初の行の127カラム目までである。

-   「!HEADER」を複数回定義すると、内容が更新され、警告メッセージが表示される。

*****
##### !INITIAL CONDITION （M1-6）

温度初期条件の定義

1行目 {#行目-5 .afff5}

!INITIAL CONDITION, TYPE=&lt;type&gt; \[, optional parameter\]

| パラメータ  |                |
|:------------|:---------------|
  TYPE         タイプ（必須）
  INPUT        外部ファイル名（省略可）

| パラメータ名  |パラメータ値  |内 容           |
|:--------------|:-------------|:---------------|
  TYPE           TEMPERATURE        温度
  INPUT          &lt;filename&gt;   外部ファイル名（省略可）、2行目以降との併用も可能

2行目以降 {#行目以降-4 .afff5}

（2行目以降）nod1, VAL1（１行に１組）

以下繰り返し

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  nod1     I/C     節点番号または節点グループ
  VAL1     R       節点値

使用例 {#使用例-4 .afff5}

!INITIAL CONDITION，TYPE=TEMPERATURE

101, 25.0

NA01, 38.0

注意 {#注意-4 .afff5}

-   「!NODE」で定義されていない節点、節点グループが指定された場合は無視され、警告メッセージが表示される。

-   同じ節点に対して再定義した場合はエラーとなる。

##### \
!MATERIAL (M1-7)

材料物性の定義

物性が温度依存している場合は対応する温度ごとにテーブル入力が可能である。

1行目 {#行目-6 .afff5}

!MATERIAL, NAME=&lt;name&gt; \[, optional parameter\]

| パラメータ  |                |
|:------------|:---------------|
  NAME         材料名（必須）
  ITEM         物性項目数（省略可、省略した場合は「1」となる）
  INPUT        外部ファイル名（省略可）

| パラメータ名  |パラメータ値  |内 容           |
|:--------------|:-------------|:---------------|
  NAME           &lt;name&gt;       材料名
  ITEM           &lt;ITEMnum&gt;    ユーザー定義による物性項目数
  INPUT          &lt;filename&gt;   外部ファイル名（省略可）、2行目以降との併用も可能

2行目以降 {#行目以降-5 .afff5}

（2行目） !ITEM=1, SUBITEM=&lt;k&gt;

（3行目） VAL1-1-1, VAL1-1-2, … VAL1-1-k, TEMP1-1

（4行目） VAL1-2-1，VAL1-2-2, … VAL1-2-k, TEMP1-2

・・

（L+2行目）VAL1-L-1，VAL1-L-2, … VAL1-L-k, TEMP1-L

以下「!ITEM=&lt;ITEMnum&gt;」まで繰り返し定義する

  ------------------------------------------------------------------------------------------
  サブパラメータ（「!ITEM」に対するもの）
  ----------------------------------------- ------------------------------------------------
  SUBITEM                                   各物性項目で定義されるサブ物性項目数（省略可、

                                            省略した場合は「1」となる。
  ------------------------------------------------------------------------------------------

  サブパラメータ名   パラメータ値         内 容
  ------------------ -------------------- ----------------------------------
  SUBITEM            &lt;subITEMnum&gt;   ユーザー定義によるサブ物性項目数

【m番目の物性が温度依存している場合】 {#m番目の物性が温度依存している場合 .afff5}

温度依存のテーブルの項目数がNの場合、以下のように入力する：

!ITEM=m, SUBITEM=k

VALm1-1, ..., VALm1-k, TEMPm1

VALm2-1, ..., VALm2-k, TEMPm2

...

VALmN-1, ..., VALmN-k, TEMPm-N

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  VALmn-k   R       物性値（温度依存）
  TEMPmn    R       対応する温度

TEMPm1 &lt; TEMPm2 &lt; ... &lt; TEMPmN でなければならない。

温度がTEMPm1以下の場合はVALm1、TEMPmN以上の場合はVALmNが使用される。

【m番目の物性が温度依存していない場合】 {#m番目の物性が温度依存していない場合 .afff5}

!ITEM=m, SUBITEM=k

VALm1-1, ..., VALm1-k

VALm2-1, ..., VALm2-k

...

VALmN-1, ..., VALmN-k

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  VALmn-k   R       物性値（温度依存なし）

注意 {#注意-5 .afff5}

-   材料名が重複した場合はエラーとなる。

-   「!SECTION」オプションで参照されているMATERIALが定義されていない場合はエラーとなる。

-   「!ELEMENT」オプションで、パラメータ「MATITEM」を使用して要素ごとに物性を入力した場合の値が優先して使用される。この場合、「!MATERIAL」オプションを使用して入力した物性値は使用されない。

-   「!ITEM=m」サブオプションの数と、パラメータ「ITEM」の数が整合しない場合、定義されていないサブオプションがある場合はエラーとなる。

-   「!ITEM=m」サブオプションは、mの小さい順番に並んでいなくてもよい。

-   「!SUBITEM=k」サブオプション、温度依存性を使用する場合、省略した値は「0.0」となる。

-   温度依存性を使用する場合、温度の低い順に定義しなければならない。

-   温度依存性を使用する場合、同じ温度を2回以上使用した場合はエラーとなる。

使用例 {#使用例-5 .afff5}

!MATERIAL, NAME= STEEL, ITEM= 2

!ITEM=1 温度依存性なし

35.0

!ITEM=2

40.0, 0.0

45.0, 100.0

50.0, 200.0

!MATERIAL, NAME= CUPPER 項目数＝1（デフォルト値）

!ITEM=1 温度依存性なし

80.0

誤った使用例 {#誤った使用例 .afff5}

例1【パラメータ「ITEM」と「!ITEM=m」サブオプションの数が整合していない-1】

!MATERIAL, NAME= STEEL, ITEM= 2

!ITEM=3

20.0

!ITEM=1

35.0

!ITEM= 2

40.0

例2【パラメータ「ITEM」と「!ITEM=m」サブオプションの数が整合していない-2】

!MATERIAL, NAME= STEEL, ITEM= 3

!ITEM=3

20.0

!ITEM= 2

40.0

!MATERIAL, NAME= CUPPER

...

弾性静解析および固有値解析 {#弾性静解析および固有値解析 .afff5}

!MATERIAL, NAME=&lt;name&gt;, ITEM=&lt;ITEMnum&gt;

!ITEM=1, SUBITEM=2

&lt;Young\_modulus&gt;, &lt;Poisson\_ratio&gt;

!ITEM=2

&lt;Density&gt;

!ITEM=3

&lt;Expansion\_coeff&gt;

  ------------------------------------------------------------------------------------------------
  パラメータ名   パラメータ値      内 容
  -------------- ----------------- ---------------------------------------------------------------
  NAME           &lt;name&gt;      材料名、!SECTIONのMATELIALと対応

  ITEM           &lt;ITEMnum&gt;   ユーザー定義による物性項目数（1以上）

                                   　&lt;Yang\_modulus&gt;・・・ヤング率（必須）

                                   &lt;Poisson\_ratio&gt;・・・ポアソン比（必須）

                                   &lt;Density&gt;・・・質量密度（ITEMnum=2のとき必須）

                                   &lt; Expansion\_coeff &gt;・・・線膨張係数（ITEMnum=3のとき）
  ------------------------------------------------------------------------------------------------

（例）

!MATERIAL, NAME=M1,
ITEM=3　　　---　材料名M1の材料では3種の物値を定義の意

!ITEM=1, SUBITEM=2
　　　---　!ITEM=1ではヤング率とポアソン比を定義（必須）

4000.0, 0.3

!ITEM=2　　　　　　　　---　!ITEM=2で質量密度を定義すること（ITEM=2のときには必須）

8.0102E-0

!ITEM=3　　　　　　 　---　!ITEM=3で線膨張係数を定義すること

1.0E-5

熱伝導解析 {#熱伝導解析-2 .afff5}

リンク、平面、ソリッド、3次元板要素の場合

!MATERIAL, NAME=&lt;name&gt;, ITEM=3

!ITEM=1, SUBITEM=2

&lt;Density&gt;, &lt;Temperature&gt;

!ITEM=2, SUBITEM=2

&lt;Specific\_heat&gt;, &lt;Temperature&gt;

!ITEM=3, SUBITEM=2

&lt;Conductivity&gt;, &lt;Temperature&gt;

| パラメータ名  |パラメータ値  |内 容           |
|:--------------|:-------------|:---------------|
  NAME           &lt;name&gt;      材料名、!SECTIONのMATELIALと対応

  ITEM           &lt;ITEMnum&gt;   ユーザー定義による物性項目数（**常に3**）

                                   &lt;Density&gt;・・・密度

                                   &lt;Specific\_heat&gt;・・・比熱

                                   &lt;Conductivity&gt;・・・熱伝導率

                                   &lt;Temperature&gt;・・・温度
  ----------------------------------------------------------------------------

（例）

!MATERIAL, NAME=M1,
ITEM=3　　　---　材料名M1の材料では3種の物値を定義の意

!ITEM=1, SUBITEM=１　 　 ---　!ITEM=1では密度と温度を定義（必須）

7850., 300.

7790., 500.

7700., 800.

!ITEM=2, SUBITEM=1 ---　!ITEM=2では比熱と温度を定義（必須）

0.465, 300.

0.528, 500.

0.622, 800.

!ITEM=3 ---　!ITEM=3では熱伝導率と温度を定義（必須）

43., 300.

38.6, 500.

27.7, 800.

インターフェース要素の場合

!SECTIONヘッダーで定義する。(材料データは不要)

（例）

!SECTION, TYPE=INTERFACE, EGRP=GAP　 ---　セクションの定義

1.0, 20.15, 8.99835E-9, 8.99835E-9

上記の!SECTIONでは、インターフェース要素で、グループ名=GAPに所属する要素のギャップパラメータを定義している。

第1パラメータ　：　ギャップ幅

第2パラメータ　：　ギャップ熱伝達係数

第3パラメータ　：　ギャップ輻射係数１

第4パラメータ　：　ギャップ輻射係数２

参考 {#参考 .afff5}

program TEST

use hecmw

implicit REAL\*8 (A-H,O-Z)

type (hecmwT\_local\_mesh) :: hecMESH

!C

!C !MATERIAL, NAME=SUS304, ITEM=3

!C !ITEM=1, SUBITEM= 3

!C 100.0, 200.0, 300.0, 0.00

!C 101.0, 210.0, 301.0, 1.00

!C 102.0, 220.0, 302.0, 2.00

!C 103.0, 230.0, 303.0, 3.00

!C !ITEM=3, SUBITEM= 2

!C 1000.0, , 0.00

!C 1001.0, 1., 1.00

!C 1002.0, 2., 2.00

!C 1003.0, 3., 3.00

!C !ITEM=2

!C 5000.0

!C

!C !MATERIAL, NAME=FEC, ITEM=2

!C !ITEM=1, SUBITEM= 3

!C 2100.0, 2200.0, 2300.0, 0.00

!C 2101.0, 2210.0, 2301.0, 1.00

!C 2102.0, 2220.0, 2302.0, 2.00

!C 2103.0, 2230.0, 2303.0, 3.00

!C 3103.0, 3230.0, 2304.0, 4.00

!C !ITEM=2

!C 6000.0, 10.0

!C 6500.0, 30.0

!C

hecMESH%material%n\_mat = 2

nn= hecMESH%material%n\_mat

allocate (hecMESH%material%mat\_name(nn))

hecMESH%material%mat\_name(1)= 'SUS304'

hecMESH%material%mat\_name(2)= 'FEC'

nn= hecMESH%material%n\_mat

allocate (hecMESH%material%mat\_ITEM\_index(0:nn))

hecMESH%material%mat\_ITEM\_index(0)= 0

hecMESH%material%mat\_ITEM\_index(1)= 3

hecMESH%material%mat\_ITEM\_index(2)=
hecMESH%material%mat\_ITEM\_index(1) + 2

hecMESH%material%n\_mat\_ITEM=
hecMESH%material%mat\_ITEM\_index(hecMESH%material%n\_mat)

nn= hecMESH%material%n\_mat\_ITEM

allocate (hecMESH%material%mat\_subITEM\_index(0:nn))

hecMESH%material%mat\_subITEM\_index(0)= 0

hecMESH%material%mat\_subITEM\_index(1)= 3

hecMESH%material%mat\_subITEM\_index(2)=
hecMESH%material%mat\_subITEM\_index(1) + 1

hecMESH%material%mat\_subITEM\_index(3)=
hecMESH%material%mat\_subITEM\_index(2) + 2

hecMESH%material%mat\_subITEM\_index(4)=
hecMESH%material%mat\_subITEM\_index(3) + 3

hecMESH%material%mat\_subITEM\_index(5)=
hecMESH%material%mat\_subITEM\_index(4) + 1

hecMESH%material%n\_mat\_subITEM=

& hecMESH%material%mat\_subITEM\_index(hecMESH%material%n\_mat\_ITEM)

nn= hecMESH%material%n\_mat\_subITEM

allocate (hecMESH%material%mat\_TABLE\_index(0:nn))

hecMESH%material%mat\_TABLE\_index( 0)= 0

hecMESH%material%mat\_TABLE\_index( 1)= 4

hecMESH%material%mat\_TABLE\_index( 2)=
hecMESH%material%mat\_TABLE\_index( 1) + 4

hecMESH%material%mat\_TABLE\_index( 3)=
hecMESH%material%mat\_TABLE\_index( 2) + 4

hecMESH%material%mat\_TABLE\_index( 4)=
hecMESH%material%mat\_TABLE\_index( 3) + 1

hecMESH%material%mat\_TABLE\_index( 5)=
hecMESH%material%mat\_TABLE\_index( 4) + 4

hecMESH%material%mat\_TABLE\_index( 6)=
hecMESH%material%mat\_TABLE\_index( 5) + 4

hecMESH%material%mat\_TABLE\_index( 7)=
hecMESH%material%mat\_TABLE\_index( 6) + 5

hecMESH%material%mat\_TABLE\_index( 8)=
hecMESH%material%mat\_TABLE\_index( 7) + 5

hecMESH%material%mat\_TABLE\_index( 9)=
hecMESH%material%mat\_TABLE\_index( 8) + 5

hecMESH%material%mat\_TABLE\_index(10)=
hecMESH%material%mat\_TABLE\_index( 9) + 2

hecMESH%material%n\_mat\_TABLE=

& hecMESH%material%mat\_TABLE\_index(hecMESH%material%n\_mat\_subITEM)

nn= hecMESH%material%n\_mat\_TABLE

allocate (hecMESH%material%mat\_VAL (nn))

allocate (hecMESH%material%mat\_TEMP(nn))

hecMESH%material%mat\_VAL = 0.d0

hecMESH%material%mat\_TEMP= 0.d0

hecMESH%material%mat\_VAL ( 1)= 100.0d0

hecMESH%material%mat\_TEMP( 1)= 0.0d0

hecMESH%material%mat\_VAL ( 2)= 101.0d0

hecMESH%material%mat\_TEMP( 2)= 1.0d0

hecMESH%material%mat\_VAL ( 3)= 102.0d0

hecMESH%material%mat\_TEMP( 3)= 2.0d0

hecMESH%material%mat\_VAL ( 4)= 103.0d0

hecMESH%material%mat\_TEMP( 4)= 3.0d0

hecMESH%material%mat\_VAL ( 5)= 200.0d0

hecMESH%material%mat\_TEMP( 5)= 0.0d0

hecMESH%material%mat\_VAL (13)= 5000.0d0

hecMESH%material%mat\_VAL (14)= 1000.0d0

hecMESH%material%mat\_TEMP (14)= 0.0d0

hecMESH%material%mat\_VAL (15)= 1001.0d0

hecMESH%material%mat\_TEMP (15)= 1.0d0

hecMESH%material%mat\_VAL (16)= 1002.0d0

hecMESH%material%mat\_TEMP (16)= 2.0d0

hecMESH%material%mat\_VAL (17)= 1003.0d0

hecMESH%material%mat\_TEMP (17)= 3.0d0

hecMESH%material%mat\_VAL (18)= 0.0d0

hecMESH%material%mat\_TEMP (18)= 0.0d0

hecMESH%material%mat\_VAL (19)= 1.0d0

hecMESH%material%mat\_TEMP (19)= 1.0d0

hecMESH%material%mat\_VAL (20)= 2.0d0

hecMESH%material%mat\_TEMP (20)= 2.0d0

hecMESH%material%mat\_VAL (21)= 3.0d0

hecMESH%material%mat\_TEMP (21)= 3.0d0

hecMESH%material%mat\_VAL (22)= 2100.0d0

hecMESH%material%mat\_TEMP (22)= 0.0d0

hecMESH%material%mat\_VAL (23)= 2101.0d0

hecMESH%material%mat\_TEMP (23)= 1.0d0

hecMESH%material%mat\_VAL (24)= 2102.0d0

hecMESH%material%mat\_TEMP (24)= 2.0d0

hecMESH%material%mat\_VAL (25)= 2103.0d0

hecMESH%material%mat\_TEMP (25)= 3.0d0

hecMESH%material%mat\_VAL (26)= 3103.0d0

hecMESH%material%mat\_TEMP (26)= 4.0d0

write (\*,'(a,i10)') '%n\_mat\_ITEM ', hecMESH%material%n\_mat\_ITEM

write (\*,'(a,i10)') '%n\_mat\_subITEM',
hecMESH%material%n\_mat\_subITEM

write (\*,'(a,i10)') '%n\_mat\_TABLE ', hecMESH%material%n\_mat\_TABLE

end program TEST

##### \
!NGROUP (M1-8)

節点グループの定義

1行目 {#行目-7 .afff5}

!NGROUP, NGRP=&lt;ngrp&gt; \[, optional parameter\]

| パラメータ  |                |
|:------------|:---------------|
  NGRP         節点グループ名（必須）
  GENERATE     節点グループに属する節点の自動生成（省略可）
  INPUT        外部ファイル名（省略可）

  パラメータ名   パラメータ値       内 容
  -------------- ------------------ ---------------------------------------------------
  NGRP           &lt;ngrp&gt;       節点グループ名
  GENERATE       なし               節点グループに属する節点の自動生成
  INPUT          &lt;filename&gt;   外部ファイル名（省略可）、2行目以降との併用も可能

2行目以降（GENERATEを使用しない場合） {#行目以降generateを使用しない場合-1 .afff5}

（2行目）nod1, nod2, nod3

（以下同様）

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  nodX     I       節点グループに属する節点番号

2行目以降（GENERATEを使用する場合） {#行目以降generateを使用する場合-1 .afff5}

（2行目）nod1, nod2, nod3

（以下同様）

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  nod1     I       節点グループ内の最初の節点番号
  nod2     I       節点グループ内の最後の節点番号
  nod3     I       節点番号増分（省略可能、省略時はnod3=1となる）

注意 {#注意-6 .afff5}

-   1行に任意の数の節点を入れることができる。また次のオプションが始まるまで、任意の数の行を挿入することができる。

-   指定する節点は「!NGROUP」より前に定義されている必要がある。

-   「!NODE」オプションで定義されていない節点は除外され、警告メッセージが表示される。

-   指定された節点が既に同じグループ内に存在する場合は無視され、警告メッセージが表示される。

-   全ての節点は、「ALL」という名前の節点グループに属している（自動的に生成される）。

-   ひとつのグループを複数回にわけて定義できる。

使用例 {#使用例-6 .afff5}

!NGROUP, NGRP= NA01

1, 2, 3, 4, 5, 6

101, 102

!NGROUP, NGRP= NA02

101, 102

!NGROUP, NGRP= NA01 グループ「NA01」に「501, 505」が追加される。

501, 505

!NGROUP, NGRP= NA02 グループ「NA02」に「501, 505」が追加される。

501, 505

!NGROUP, NGRP= NA04,GENERATE グループ「NA04」に

301, 309, 2 「301,303,305,307,309,311,312,313」が追加される。

311, 313

##### \
!NODE (M1-9)

節点座標の定義

1行目 {#行目-8 .afff5}

!NODE \[, optional parameter\]

| パラメータ  |                |
|:------------|:---------------|
  SYSTEM       座標系（省略可）
  NGRP         節点グループ名（省略可）
  INPUT        外部ファイル名（省略可）

  パラメータ名   パラメータ値       内容
  -------------- ------------------ ---------------------------------------------------
  SYSTEM         R                  デカルト座標系（デフォルト値）
                 C                  円筒座標系
  NGRP           &lt;ngrp&gt;       節点グループ名（省略可）
  INPUT          &lt;filename&gt;   外部ファイル名（省略可）、2行目以降との併用も可能

2行目以降 {#行目以降-6 .afff5}

（2行目）NODE\_ID, Xcoord, Ycoord, Zcoord

（以下同様）

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  NODE\_ID   I       節点番号
  Xcoord     R       X座標
  Ycoord     R       Y座標
  Zcoord     R       Z座標

注意 {#注意-7 .afff5}

-   区切り記号を含めて節点座標を省略した場合、値は「0.0」となる。

-   既に定義されてる節点を再定義した場合、内容が更新され、警告メッセージが表示される。

-   「!ELEMENT」で参照されない節点は除外される。

-   「!ELEMENT」で定義される節点は「!ELEMENT」より前に定義されていなければならない。

使用例 {#使用例-7 .afff5}

!NODE, NGRP=TEST

1, 0.0, 0.0, 0.5

2, 0.0, 0.0, 1.0

3, 0.0,,1.5 Y座標は「0.0」

4, X,Y,Z座標は「0.0」

##### \
!SECTION (M1-10)

セクションの定義

1行目 {#行目-9 .afff5}

!SECTION, TYPE=&lt;type&gt;, EGRP=&lt;egrp&gt; \[, optional parameter\]

| パラメータ  |                |
|:------------|:---------------|
  TYPE         セクションタイプ（必須）
  EGRP         要素グループ名（必須）
  MATERIAL     ユーザー定義材料名（必須）
  SECOPT       要素タイプ用補助パラメータ（省略可、省略した場合は=0となる）
  INPUT        外部ファイル名（省略可）

| パラメータ名  |パラメータ値  |内 容           |
|:--------------|:-------------|:---------------|
  TYPE           SOLID               ロッド，三角形，四角形，四面体，五面体，六面体要素
                 SHELL               シェル要素
                 BEAM                梁要素
                 INTERFACE           インターフェース要素
  EGRP           &lt;egrp&gt;        要素グループ名
  MATERIAL       &lt;material &gt;   ユーザー定義による材料名
  SECOPT         &lt;secopt&gt;      = 0：指定なし，平面応力
                                     = 1：平面ひずみ
                                     = 2：軸対称
                                     =10：0＋次数低減積分
                                     =11：1＋次数低減積分
                                     =12：2＋次数低減積分
  INPUT          &lt;filename&gt;    外部ファイル名（省略可）、2行目以降との併用も可能

2行目以降 {#行目以降-7 .afff5}

【TYPE=SOLID】の場合 {#typesolidの場合 .afff5}

（2行目）THICKNESS

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  THICKNESS   R       トラス要素の場合、断面積（必須）

「TYPE=SOLID」の場合、「THICKNESS」は省略可。

　

【TYPE=SHELL】の場合 {#typeshellの場合 .afff5}

（2行目）THICKNESS, INTEGPOINTS

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  THICKNESS     R       シェル断面厚さ
  INTEGPOINTS   I       シェル断面方向積分点

【TYPE=BEAM】の場合 {#typebeamの場合 .afff5}

（2行目）vx,vy,vz,area,Iyy,Iz,Jx

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  vx,vy,vz   R       参考軸方向
  area       R       断面面積
  Iyy, Izz   Ｒ      断面二次モーメント
  Jx         R       ねじり定数

【TYPE=INTERFACE】の場合 {#typeinterfaceの場合 .afff5}

（2行目）THICKNESS, GAPCON, GAPRAD1, GAPRAD2

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  THICKNESS   R       断面厚さ
  GAPCON      R       ギャップ熱伝達係数（省略時0）
  GAPRAD1     R       ギャップ輻射熱伝達係数-1（省略時0）
  GAPRAD2     R       ギャップ輻射熱伝達係数-2（省略時0）

注意 {#注意-8 .afff5}

-   パラメータ「TYPE」が要素タイプと整合していない場合はエラーとなる。

-   SECTION情報を持たない要素がある場合はエラーとなる。

-   セクション名が重複した場合はエラーとなる。

使用例 {#使用例-8 .afff5}

!SECTION, EGRP=SOLID1, TYPE=SOLID, MATERIAL=STEEL

!SECTION, EGRP=SHELL2, TYPE=SHELL, MATERIAL=STEEL

1.0, 5

##### !SGROUP (M1-11)

面グループの定義

1行目 {#行目-10 .afff5}

!SGROUP, SGRP=&lt;sgrp&gt; \[, optional parameter\]

| パラメータ  |                |
|:------------|:---------------|
  SGRP         面グループ名（必須）
  INPUT        外部ファイル名（省略可）

| パラメータ名  |パラメータ値  |内 容           |
|:--------------|:-------------|:---------------|
  SGRP           &lt;sgrp&gt;       面グループ名
  INPUT          &lt;filename&gt;   外部ファイル名（省略可）、2行目以降との併用も可能

2行目以降 {#行目以降-8 .afff5}

（2行目）elem1, lsuf1, elem2, lsuf2, elem3, lsuf3, ...

（以下同様）

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  elemX    I       面グループに属する要素番号
  lsufX    I       面グループに属する要素の局所面番号

注意 {#注意-9 .afff5}

-   要素タイプと面番号については、「4章　要素ライブラリ」を参照のこと。

-   （要素、局所面番号）という組み合わせによって面を構成する。1行に任意の数の面を入れることができる。また次のオプションが始まるまで、任意の数の行を挿入することができる。（要素、局所面番号）という組み合わせは必ず同一の行になければならない。

-   指定する要素は「!SGROUP」より前に定義されている必要がある。

-   要素が「!ELEMENT」オプションで定義されていない場合は無視され、警告メッセージが表示される。

-   「!ELEMENT」オプションで定義されていない要素を含む面は除外され、警告メッセージが表示される。

-   要素タイプと面番号の整合性が取れない面は除外され、警告メッセージが表示される。

-   ひとつのグループを複数回にわけて定義できる。

使用例 {#使用例-9 .afff5}

!SGROUP, SGRP= SUF01

101, 1, 102, 1, 103, 2, 104, 2

201, 1, 202, 1

501, 1

!SGROUP, SGRP= SUF02

101, 2, 102, 2

!SGROUP, SGRP= EA01 グループ「SUF01」に「(601,1), (602,2)」が追加。

601, 1

602, 2

誤った使用例 {#誤った使用例-1 .afff5}

例1【（要素、局所面番号）の組が複数行にわたっている】

!SGROUP, SGRP= SUF01

101, 1, 102, 1, 103

1, 104, 1

例2【局所面番号と要素タイプの整合性がとれない】

!ELEMENT, TYPE= 211, SECTION= A

101, 1, 2, 3

102, 2, 3, 4

...

!SGROUP, SGRP= SUF01

101, 1

101, 2

101, 4 三角形要素に第4面は存在しないので，この組み合わせは無視される

##### !ZERO (M1-12)

絶対零度

1行目 {#行目-11 .afff5}

!ZERO

パラメータ

なし

2行目以降 {#行目以降-9 .afff5}

（2行目）ZERO

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  ZERO     R       絶対零度

注意 {#注意-10 .afff5}

-   省略可能。省略された場合は「絶対零度＝0」となる。

-   「!ZERO」を複数回定義すると、内容が更新され、警告メッセージが表示される。

使用例 {#使用例-10 .afff5}

!ZERO

-273.16

##### !CONTACT PAIR　(M1-13)

接触解析に用いる接触面ペアの定義

1行目 {#行目-12 .afff5}

!CONTACT PAIR, NAME=&lt;name&gt; \[,optional parameter\]

| パラメータ  |                |
|:------------|:---------------|
  NAME         接触ペア名（必須）
  TYPE         タイプ（省略可）

| パラメータ名  |パラメータ値  |内 容           |
|:--------------|:-------------|:---------------|
  NAME           &lt;name&gt;   接触ペア名

  ＴＹＰＥ       NODE-SURF      スレーブ面は節点グループ

                                マスター面は面グループ（デフォルト）

                 SURF-SURF      スレーブ面、マスター面とも面グループ
  --------------------------------------------------------------------

2行目以降 {#行目以降-10 .afff5}

（2行目以降）SLAVE\_GRP, MASTER\_GRP

（以下同様）

| 変数名  | 属性  | 内容         |
|:--------|:------|:-------------|
  SLAVE\_GRP    C       スレーブ面の節点/面グループ名
  MASTER\_GRP   C       マスター面の面グループ名

##### !END （M1-14）

メッシュデータの終端

このヘッダーが表れると、メッシュデータの読み込みを終了する。

1行目 {#行目-13 .afff5}

!END

パラメータ

なし

2行目以降 {#行目以降-11 .afff5}

なし
