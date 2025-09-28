
## 解析制御データ

### 解析制御データ概要

FrontISTRは、解析制御データファイルを入力して、下図に示す計算制御データ、ソルバー制御データおよびポスト処理（可視化）制御データを取得し、解析計算を実施する。

![解析制御データ](media/analysis05_01.png){.center width="50%"}

解析制御データファイルの特徴は以下のとおりである。

  * 自由書式に基づくASCII形式のファイルである。
  * "`!`" で始まるヘッダーとそれに続くデータから構成されている。
  * ヘッダーの記述の順番は基本的に自由である。
  * データの区切り記号には "`,`" を使用する。
  * ファイル内は大きく分けて3つのゾーンに分かれている。
  * ファイルの最後に "`!END`" を入力して終了とする。

#### 解析制御データ例

```
########## 計算制御データ部分 ##########
### Control File for HEAT solver
!SOLUTION,TYPE=HEAT
!FIXTEMP
 XMIN, 0.0
 XMAX, 500.0

########## ソルバー制御データ部分 ##########
### Solver Control
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=NO,TIMELOG=NO
 100, 1
 1.0e-8,1.0,0.0

########## ポスト制御(可視化)データ部分 ##########
### Post Control
!WRITE,RESULT
!WRITE,VISUAL
!VISUAL, method=PSR
!surface_num = 1
!surface 1
!surface_style = 1
!display_method 1
!color_comp_name = TEMPERATURE
!color_subcomp = 1
!output_type = BMP
!x_resolution = 500
!y_resolution = 500
!num_of_lights = 1
!position_of_lights = -20.0, 5.8, 80.0
!viewpoint = -20.0 10.0 8.0
!up_direction = 0.0 0.0 1.0
!ambient_coef= 0.3
!diffuse_coef= 0.7
!specular_coef= 0.5
!color_mapping_style= 1
!!interval_mapping= -0.01, 0.02
!color_mapping_bar_on = 1
!scale_marking_on = 1
!num_of_scale = 5
!font_size = 1.5
!font_color = 1.0 1.0 1.0
```
### 入力規則

解析制御データは、ヘッダー行、データ行、コメント行から構成される。

ヘッダー行には必ず一つのヘッダーが含まれる。


ヘッダー
:   解析制御データ内で、データの意味とデータブロックを特定する。
:   行頭が "`!`" で始まる場合、ヘッダーであるとみなされる。

ヘッダー行
:   ヘッダーとそれに伴うパラメータを記述する。
:   ヘッダー行はヘッダーで始まっていなければならない。パラメータが必要な場合は、"`,`" を用いてその後に続けなければならない。パラメータが値をとる場合は、パラメータの後に "`=`" が続き、その後に値を記述する。
:    ヘッダー行を複数行にわたって記述することはできない。

データ行
:    ヘッダー行の次の行から開始され、必要なデータを記述する。
:    データ行は複数行にわたる可能性があるが、それは各ヘッダーで定義されるデータ記述の規則により決定される。
:    データ行は必要ない場合もある。

区切り文字
:    データの区切り文字にはカンマ "`,`" を用いる。

空白の扱い
:    空白は無視される。

名前
:    名前に使用可能な文字は、アンダースコア "`_`"、ハイフン "`-`"、英数字 "`a-z A-Z 0-9`" であるが、最初の一文字は "`_`" または英字 "`a-z A-Z`" で始まっていなければならない。大文字小文字の区別はなく、内部的にはすべて大文字として扱われる。
:    また、名前の最大長は63文字である。

ファイル名
:    ファイル名に使用可能な文字は、アンダースコア "`_`"、ハイフン "`-`"、ピリオド "`.`"、スラッシュ "`/`"、英数字 "`a-z A-Z 0-9`" である。
:    ファイル名は、特に記述がない限りパスを含んでもよい。相対パス、絶対パスのいずれも指定可能である。
:    また、ファイル名の最大長は1023文字である。

浮動小数点データ
:    指数はあってもなくてもよい。指数の前には、"`E`" または "`e`" の記号をつけなければならない。
:    "`E`" または "`e`" どちらを使用してもかまわない。

コメント行
:    行頭が "`!!`" または"`#`" で始まる行はコメント行とみなされ、無視される。
:    コメント行はファイル中の任意の位置に挿入でき、その数に制限はない。

!END
:    メッシュデータの終端
:    このヘッダーが表れると、メッシュデータの読み込みを終了する。

### 解析制御データ

#### 計算制御データのヘッダー一覧

FrontISTRでは、計算制御データに使用できる境界条件として以下のものがあげられる。

  * 分布荷重条件 (物体力, 圧力荷重, 重力, 遠心力)
  * 集中荷重条件
  * 熱荷重
  * 単点拘束条件 (SPC条件)
  * ばね境界条件
  * 接触
  * 集中熱流束
  * 分布熱流束
  * 対流熱伝達境界
  * 輻射熱伝達境界
  * 規定温度境界

上記境界条件の定義方法は、メッシュデータ同様に "`!`" ヘッダーの形式で定義する。

以下、表 7.3.1に全解析に共通な制御データのヘッダー一覧を示し、表
7.3.2から解析種別別のヘッダー一覧を示す。

** 表 7.3.1 全解析に共通な制御データ **

| ヘッダー                                          | 意味                     | 備考 | 説明番号 |
|-------------------------------------------------|--------------------------|------|----------|
| [`!VERSION`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/version.html)                      | ソルバーバージョン番号       |      | 1-1      |
| [`!SOLUTION`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/solution.html)                    | 解析の種別の指定            | 必須 | 1-2      |
| [`!WRITE,VISUAL`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/write_visual.html)            | 可視化データ出力の指定       |      | 1-3      |
| [`!WRITE,RESULT`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/write_result.html)            | 解析結果データ出力の指定     |      | 1-4      |
| [`!WRITE,LOG`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/write_log.html)                  | 結果出力の指定              |      | 1-5      |
| [`!OUPUT_VIS`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/output_vis.html)                 | 可視化データ出力制御         | 　   | 1-6      |
| [`!OUTPUT_RES`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/output_res.html)                | 解析結果データ出力制御       | 　   | 1-7      |
| [`!RESTART`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/restart.html)                      | リスタートの制御            |      | 1-8      |
| [`!ECHO`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/echo.html)                            | エコー出力                 |      | 1-9      |
| [`!ORIENTATION`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/orientation.html)             | 局所座標系の定義            |      | 1-10     |
| [`!SECTION`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/section.html)                     | セクションの局所座標系の定義  |      | 1-11     |
| [`!END`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/end.html)                             | 制御データの指定の終了       |      | 1-12     |
| [`!OUTPUT_SSTYPE`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/output_sstype.html)         | 結果出力の応力ひずみ測度の指定 |      | 1-13     |
| [`!INITIAL_CONDITION`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/initial_condition.html) | 初期条件の指定              |      | 1-14     |

** 表 7.3.2 静解析用制御データ **

| ヘッダー                                      | 意味                       | 備考 | 説明番号 |
|----------------------------------------------|----------------------------|------|----------|
| [`!STATIC`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/static.html)                     | 静解析の制御               | 　   | 2-1      |
| [`!MATERIAL`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/material.html)                 | 材料名                     |      | 2-2      |
| [`!ELASTIC`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/elastic.html)                 | 弾性材料物性               |      | 2-2-1    |
| [`!PLASTIC`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/plastic.html)                 | 塑性材料物性               |      | 2-2-2    |
| [`!HYPERELASTIC`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/hyperelastic.html)       | 超弾性材料物性             |      | 2-2-3    |
| [`!VISCOELASTIC`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/viscoelastic.html)       | 粘弾性材料物性             |      | 2-2-4    |
| [`!CREEP`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/creep.html)                     | クリープ材料物性           |      | 2-2-5    |
| [`!DENSITY`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/density.html)                 | 質量密度                   |      | 2-2-6    |
| [`!EXPANSION_COEFF`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/expansion_coeff.html) | 線膨張係数                 |      | 2-2-7    |
| [`!TRS`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/trs.html)                         | 粘弾性温度依存性           |      | 2-2-8    |
| [`!FLUID`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/fluid.html)                     | 流体物性                   |      | 2-2-9    |
| [`!USER_MATERIAL`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/user_material.html)    | ユーザー定義材料           |      | 2-2-10   |
| [`!BOUNDARY`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/boundary.html)                 | 変位境界条件               |      | 2-3      |
| [`!SPRING`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/spring.html)                   | ばね境界条件               |      | 2-3-1    |
| [`!CLOAD`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/cload.html)                       | 集中荷重                   |      | 2-4      |
| [`!DLOAD`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/dload.html)                       | 分布荷重                   |      | 2-5      |
| [`!ULOAD`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/uload.html)                       | ユーザー定義外部荷重       |      | 2-6      |
| [`!CONTACT_ALGO`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/contact_algo.html)         | 接触解析アルゴリズム       |      | 2-7      |
| [`!CONTACT`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/contact.html)                   | 接触                       |      | 2-8      |
| [`!TEMPERATURE`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/temperature.html)           | 熱応力解析における節点温度 |      | 2-9      |
| [`!REFTEMP`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/reftemp.html)                  | 熱応力解析における参照温度 |      | 2-10     |
| [`!STEP`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/step.html)                        | 解析ステップ制御           | 　   | 2-11     |
| [`!AUTOINC_PARAM`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/autoinc_param.html)      | 自動増分制御               | 　   | 2-12     |
| [`!TIME_POINTS`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/time_points.html)          | 計算及び出力時刻の指定     | 　   | 2-13     |
| [`!CONTACT_PARAM`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/contact_param.html)      | 接触判定制御               | 　   | 2-14     |

** 表 7.3.3 固有値解析用制御データ **

| ヘッダー | 意味             | 備考             | 説明番号 |
|----------|------------------|------------------|----------|
|[`!EIGEN`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/eigen.html)  | 固有値解析の制御 | 固有値解析で必須 | 3-1      |

** 表 7.3.4 熱伝導解析用制御データ **

| ヘッダー   | 意味                              | 備考             | 説明番号 |
|------------|-----------------------------------|------------------|----------|
|[`!HEAT`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/heat.html)     | 熱伝導解析の制御                  | 熱伝導解析で必須 | 4-1      |
|[`!FIXTEMP`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/fixtemp.html)  | 節点温度                          |                  | 4-2      |
|[`!CFLUX`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/cflux.html)    | 節点に与える集中熱流束            |                  | 4-3      |
|[`!DFLUX`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/dflux.html)    | 要素面に与える分布熱流束/内部発熱 |                  | 4-4      |
|[`!SFLUX`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/sflux.html)    | 面グループによる分布熱流束        |                  | 4-5      |
|[`!FILM`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/film.html)     | 境界面に与える熱伝達係数          |                  | 4-6      |
|[`!SFILM`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/sfilm.html)    | 面グループによる熱伝達係数        |                  | 4-7      |
|[`!RADIATE`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/radiate.html)  | 境界面に与える輻射係数            |                  | 4-8      |
|[`!SRADIATE`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/sradiate.html) | 面グループによる輻射係数          |                  | 4-9      |
|[`!WELD_LINE`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/weld_line.html)| 溶接線                            |                  | 4-10     |

** 表 7.3.5　動解析用制御データ **

| ヘッダー      | 意味                           | 備考                 | 説明番号 |
|---------------|--------------------------------|----------------------|----------|
|[`!DYNAMIC`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/dynamic.html)     | 動解析の制御                   | 動解析で必須         | 5-1      |
|[`!VELOCITY`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/velocity.html)    | 速度境界条件                   |                      | 5-2      |
|[`!ACCELERATION`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/acceleration.html)| 加速度境界条件                 |                      | 5-3      |
|[`!COUPLE`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/couple.html)      | 連成面定義                     | 連成解析で必要       | 5-4      |
|[`!EIGENREAD`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/eigenread.html)   | 固有値・固有モードの指定       | 周波数応答解析で必須 | 5-5      |
|[`!FLOAD`](https://frontistr-commons.gitlab.io/frontistr_documents/keyword_reference/cnt/fload.html)       | 周波数応答解析用集中荷重の定義 |                      | 5-6      |

各ヘッダーには、パラメータとそれぞれのヘッダーに対応したデータの項目がある。

以下、上記各ヘッダーについて、解析種別別にデータ作成例とともに説明する。上記表の説明番号はデータ作成例の右端に示している番号である。

#### 全解析に共通な制御データ

##### 解析制御データ例

```
### Control File for FISTR
!VERSION                                        1-1
  5
!SOLUTION, TYPE=STATIC                          1-2
!WRITE, VISUAL                                  1-3
!WRITE, RESULT                                  1-4
!ECHO                                           1-9
!BOUNDARY                                       2-3
  FIX, 1, 3, 0.0
!CLOAD                                          2-4
  CL1, 3, -1.0
!END                                            1-12
```

##### ヘッダーの説明

###### 1-1 `!VERSION`

ソルバーバージョンを示す。

###### 1-2 `!SOLUTION, TYPE=STATIC`

TYPE＝解析の種類

###### 1-3 `!WRITE, VISUAL`

メモリ渡しビジュアライザーによる可視化データの出力

記載するだけでファイルを出力

###### 1-4 `!WRITE, RESULT`

解析結果データの出力

記載するだけでファイルを出力

###### 1-6 `!ECHO`

節点データ、要素データおよび材料データをログファイルに出力

記載するだけでファイルに出力

###### 1-8 `!END`

制御データの終わりを示す

#### 静解析制御データ

##### 静解析制御データ例

```
### Control File for FISTR
!SOLUTION, TYPE=STATIC                          1-2
!WRITE, VISUAL                                  1-3
!WRITE, RESULT                                  1-4
!ECHO                                           1-9
!MATERIAL, NAME=M1                              2-2
!ELASTIC, TYPE=ISOTROPIC                        2-2-1
  210000.0, 0.3
!BOUNDARY                                       2-3
  FIX, 1, 3, 0.0
!SPRING 2-3-1
  200, 1, 0.03
!CLOAD 2-4
  CL1, 3, -1.0
!DLOAD 2-5
  1, P1, 1.0
!TEMPERATURE                                    2-9
  1, 10.0
!REFTEMP                                        2-10
!STEP, CONVERG=1.E-5, MAXITER=30                2-11
!END                                            1-12
```

##### ヘッダーの説明

  * <font color="Red">赤字</font>は例に記載されている数値、
  * 表2行目の英字は変数名をあらわす。

###### 2-1 `!STATIC`

静解析方法の設定

###### 2-2 `!MATERIAL`
材料物性の定義

`NAME=`材料物性の名前

###### 2-2-1 `!ELASTIC, TYPE=ISOTROPIC`

弾性物質の定義

`TYPE＝`弾性タイプ

| ヤング率                          | ポアソン比                   |
|-----------------------------------|------------------------------|
| YOUNG_MODULUS                     | POISSON_RATIO                |
| <font color="Red">210000.0</font> | <font color="Red">0.3</font> |

###### 2-3 `!BOUNDARY`

変位境界条件の定義

| 節点番号または節点グループ名  | 拘束自由度の開始番号        | 拘束自由度の終了番号          | 拘束値                         |
|-------------------------------|-----------------------------|-------------------------------|--------------------------------|
| NODE_ID                       | DOF_idS                     | DOF_idE                       | Value                          |
| <font color="Red">FIX</font>, | <font color="Red">1</font>, | <font color="color">3</font>, | <font color="color">0.0</font> |

###### 2-3-1 `!SPRING`

ばね境界条件の定義

| 節点番号またはグループ名      | 拘束自由度                  | ばね定数                      |
|-------------------------------|-----------------------------|-------------------------------|
| NODE_ID                       | DOF_id                      | Value                         |
| <font color="Red">200</font>, | <font color="Red">1</font>, | <font color="Red">0.03</font> |

###### 2-4 `!CLOAD`

集中荷重の定義

| 節点番号または節点グループ名  | 自由度番号                  | 荷重値                        |
|-------------------------------|-----------------------------|-------------------------------|
| NODE_ID                       | DOF_id                      | Value                         |
| <font color="Red">CL1</font>, | <font color="Red">3</font>, | <font color="Red">-1.0</font> |

###### 2-5 `!DLOAD`

分布荷重の定義

| 要素番号または要素グループ名 | 荷重タイプ番号               | 荷重パラメータ               |
|------------------------------|------------------------------|------------------------------|
| ELEMENT_ID                   | LOAD_type                    | param                        |
| <font color="Red">1</font>,  | <font color="Red">P1</font>, | <font color="Red">1.0</font> |

###### 2-9 `!TEMPERATURE`

熱応力解析に用いる節点温度の指定

| 節点番号または節点グループ名 | 温度                        |
|------------------------------|-----------------------------|
| NODE_ID                      | Temp_Value                  |
| <font color="Red">1</font>,  | <font color="Red">10</font> |

###### 2-10 `!REFTEMP`

熱応力解析における参照温度の定義

###### 2-11 `!STEP`

非線形静解析の制御 (線形解析の場合省略可)

| 収束値判定閾値<br/>(デフォルト:1.0E-06) | サブステップ数<br/>(AMPがある場合、AMPが優先) | 最大反復計算回数            | 時間関数名<br/>(AMPLITUDEで指定) |
|-----------------------------------------|-----------------------------------------------|-----------------------------|----------------------------------|
| CONVERG                                 | SUBSTEPS                                      | MAXITER                     | AMP                              |
| <font color="Red">1.0E-05</font>        | <font color="Red">10</font>                   | <font color="Red">30</font> |                                  |

#### 固有値解析制御データ

##### 固有値解析制御データ例

```
### Control File for FISTR
!SOLUTION, TYPE=EIGEN                           1-2
!WRITE, VISUAL                                  1-3
!WRITE, RESULT                                  1-4
!ECHO                                           1-9
!EIGEN                                          3-1
  3, 1.0E-8, 60
!BOUNDARY                                       2-3
  FIX, 1, 2, 0.0
!END                                            1-12
```

##### ヘッダーの説明

  * <font color="Red">赤字</font>は例に記載されている数値

###### 3-1 `!EIGEN`

固有値解析のパラメータ設定

| 固有値数                    | 許容差                            | 最大反復数                  |
|-----------------------------|-----------------------------------|-----------------------------|
| NSET                        | tolerance                         | LCZMAX                      |
| <font color="Red">3</font>, | <font color="Red">1.0E-08</font>, | <font color="Red">60</font> |

###### 2-3 `!BOUNDARY` (静解析におけるものと同一)

変位境界条件の定義

| 節点番号または節点グループ名  | 拘束自由度の開始番号        | 拘束自由度の終了番号        | 拘束値                       |
|-------------------------------|-----------------------------|-----------------------------|------------------------------|
| NODE_ID                       | DOF_idS                     | DOF_idE                     | Value                        |
| <font color="Red">FIX</font>, | <font color="Red">1</font>, | <font color="Red">3</font>, | <font color="Red">0.0</font> |

#### 熱伝導解析制御データ

##### 熱伝導解析制御データ例

```
### Control File for FISTR
!SOLUTION, TYPE=HEAT                            1-2
!WRITE, VISUAL                                  1-3
!WRITE, RESULT                                  1-4
!ECHO                                           1-9
!HEAT                                           4-1
!FIXTEMP                                        4-2
  XMIN, 0.0
  XMAX, 500.0
!CFLUX                                          4-3
　ALL, 1.0E-3
!DFLUX                                          4-4
　ALL, S1, 1.0
!SFLUX                                          4-5
　SURF, 1.0
!FILM                                           4-6
  FSURF, F1, 1.0, 800
!SFILM                                          4-7
　SFSURF, 1.0, 800.0
!RADIATE                                        4-8
　RSURF, R1, 1.0E-9, 800.0
!SRADIATE                                       4-9
　RSURF, R1, 1.0E-9, 800.0
!END                                            1-12
```

##### ヘッダーの説明

  * <font color="Red">赤字</font>は例に記載されている数値

###### 4-1 `!HEAT`

計算に関する制御データの定義

```
!HEAT
  (データなし) --------------------------- 定常計算
!HEAT
  0.0 ------------------------------------ 定常計算
!HEAT
  10.0, 3600.0 --------------------------- 固定時間増分非定常計算
!HEAT
  10.0, 3600.0, 1.0 ---------------------- 自動時間増分非定常計算
!HEAT
  10.0, 3600.0, 1.0, 20.0 ---------------- 自動時間増分非定常計算
```

###### 4-2 `!FIXTEMP`

節点グループ名または節点番号と固定温度

###### 4-3 `!CFLUX`

節点にあたえる集中熱流束の定義

| 節点グループ名または節点番号  | 熱流束値                         |
|-------------------------------|----------------------------------|
| NODE_GRP_NAME                 | Value                            |
| <font color="Red">ALL</font>, | <font color="Red">1.0E-03</font> |

###### 4-4 `!DFLUX`

要素の面にあたえる分布熱流束と内部発熱の定義

| 要素グループ名または要素番号  | 荷重タイプ番号               | 熱流束値                     |
|-------------------------------|------------------------------|------------------------------|
| ELEMENT_GRP_NAME              | LOAD_type                    | Value                        |
| <font color="Red">ALL</font>, | <font color="Red">S1</font>, | <font color="Red">1.0</font> |

####### 荷重パラメータ

| 荷重タイプ番号 | 作用面   | パラメータ |
|----------------|----------|------------|
| BF             | 要素全体 | 発熱量     |
| S1             | 第１面   | 熱流束値   |
| S2             | 第2面    | 熱流束値   |
| S3             | 第3面    | 熱流束値   |
| S4             | 第4面    | 熱流束値   |
| S5             | 第5面    | 熱流束値   |
| S6             | 第6面    | 熱流束値   |
| S0             | シェル面 | 熱流束値   |

###### 4-5 `!SFLUX`

面グループによる分布熱流束の定義

| 面グループ名                   | 熱流束値                     |
|--------------------------------|------------------------------|
| SURFACE_GRP_NAME               | Value                        |
| <font color="Red">SURF</font>, | <font color="Red">1.0</font> |

###### 4-6 `!FILM`

境界面にあたえる熱伝達係数の定義

| 要素グループ名または要素番号    | 荷重タイプ番号               | 熱伝達係数                    | 雰囲気温度                     |
|---------------------------------|------------------------------|-------------------------------|--------------------------------|
| ELEMENT_GRP_NAME                | LOAD_type                    | Value                         | Sink                           |
| <font color="Red">FSURF</font>, | <font color="Red">F1</font>, | <font color="Red">1.0</font>, | <font color="Red">800.0</font> |

####### 荷重パラメータ

| 荷重タイプ番号 | 作用面   | パラメータ             |
|----------------|----------|------------------------|
| F1             | 第1面    | 熱伝達係数と雰囲気温度 |
| F2             | 第2面    | 熱伝達係数と雰囲気温度 |
| F3             | 第3面    | 熱伝達係数と雰囲気温度 |
| F4             | 第4面    | 熱伝達係数と雰囲気温度 |
| F5             | 第5面    | 熱伝達係数と雰囲気温度 |
| F6             | 第6面    | 熱伝達係数と雰囲気温度 |
| F0             | シェル面 | 熱伝達係数と雰囲気温度 |

###### 4-7 `!SFILM`

面グループによる熱伝達係数の定義

| 面グループ名                     | 熱伝達率                      | 雰囲気温度                     |
|----------------------------------|-------------------------------|--------------------------------|
| SURFACE_GRP_NAME                 | Value                         | Sink                           |
| <font color="Red">SFSURF</font>, | <font color="Red">1.0</font>, | <font color="Red">800.0</font> |

###### 4-8 `!RADIATE`

境界面にあたえる輻射係数の定義

| 要素グループ名または要素番号    | 荷重タイプ番号               | 輻射係数                          | 雰囲気温度                     |
|---------------------------------|------------------------------|-----------------------------------|--------------------------------|
| ELEMENT_GRP_NAME                | LOAD_type                    | Value                             | Sink                           |
| <font color="Red">RSURF</font>, | <font color="Red">R1</font>, | <font color="Red">1.0E-09</font>, | <font color="Red">800.0</font> |

####### 荷重パラメータ

|荷重タイプ番号|作用面  |パラメータ          |
|--------------|--------|--------------------|
| R1           |第1面   |輻射係数と雰囲気温度|
| R2           |第2面   |輻射係数と雰囲気温度|
| R3           |第3面   |輻射係数と雰囲気温度|
| R4           |第4面   |輻射係数と雰囲気温度|
| R5           |第5面   |輻射係数と雰囲気温度|
| R6           |第6面   |輻射係数と雰囲気温度|
| R0           |シェル面|輻射係数と雰囲気温度|

###### 4-9 `!SRADIATE`

面グループによる輻射係数の定義

| 面グループ名                     | 輻射係数                          | 雰囲気温度                     |
|----------------------------------|-----------------------------------|--------------------------------|
| SURFACE_GRP_NAME                 | Value                             | Sink                           |
| <font color="Red">SRSURF</font>, | <font color="Red">1.0E-09</font>, | <font color="Red">800.0</font> |

#### 動解析制御データ

##### 動解析制御データ例

```
### Control File for FISTR
!SOLUTION, TYPE=DYNAMIC                         1-2
!DYNAMIC, TYPE=NONLINEAR                        5-1
  1 , 1
  0.0, 1.0, 500, 1.0000e-5
  0.5, 0.25
  1, 1, 0.0, 0.0
  100, 5, 1
  0, 0, 0, 0, 0, 0
!BOUNDARY, AMP=AMP1                             2-3
  FIX, 1, 3, 0.0
!CLOAD, AMP=AMP1                                2-4
  CL1, 3, -1.0
!COUPLE, TYPE=1                                 5-4
  SCOUPLE
!STEP, CONVERG=1.E-6, MAXITER=20                  2-11
!END                                            1-12
```

##### ヘッダーの説明

◆非線形動解析の制御（線形解析の場合省略可、陽解法の場合は不要）
  * <font color="Red">赤字</font>は例に記載されている数値、
  * 表2行目の英字は変数名をあらわす。

###### 5-1 `!DYNAMIC`

線形動解析の制御を行う。

|運動方程式の解法|解析の種類|
|----------------|----------|
|idx_eqa         |idx_resp  |
|<font color="Red">11</font>|<font color="Red">1</font>|

|解析開始時間|解析終了時間|全STEP数|時間増分|
|------------|------------|--------|--------|
|t_start     |t_end       |n_step  |t_delta |
|<font color="Red">0.0</font>|<font color="Red">1.0</font>|<font color="Red">500</font>|<font color="Red">1.0000e-5</font>|

| Newmark-i\(\beta\)法のパラメータ \(\gamma\) | Newmark-\(\beta\)法のパラメータ \(\beta\) |
|----------------------------------------|---------------------------------------|
| gamma                                  | beta                                  |
|<font color="Red">0.5</font>            |<font color="Red">0.25</font>          |

|質量マトリックスの種類|減衰の種類|Rayleigh減衰のパラメータR<sub>m</sub>|Rayleigh減衰のパラメータR<sub>k</sub>|
|----------------------|----------|----------------------------|--------------------------|
| idx_mas              | idx_dmp  | ray_m                      | ray_k                    |
|<font color="Red">1</font>|<font color="Red">1</font>|<font color="Red">0.0</font>|<font color="Red">0.0</font>|

|結果出力間隔|モニタリング節点番号または節点グループ名|変位モニタリングの結果出力間隔|
|------------|----------------------------------------|------------------------------|
| nout       | node_monit_1                           | nout_monit                   |
|<font color="Red">100</font>|<font color="Red">55</font>|<font color="Red">1</font>|

|出力制御変位|出力制御速度|出力制御加速度|出力制御反力|出力制御ひずみ|出力制御応力|
|------------|------------|--------------|------------|--------------|------------|
|iout_list(1)|iout_list(2)|iout_list(3)  |iout_list(4)|iout_list(5)  |iout_list(6)|
|<font color="Red">0</font>|<font color="Red">0</font>|<font color="Red">0</font>|<font color="Red">0</font>|<font color="Red">0</font>|<font color="Red">0</font>|

###### 2-3 `!BOUNDARY` (静解析におけるものと同一)

変位境界条件の定義

|節点番号または節点グループ名|拘束自由度の開始番号|拘束自由度の終了番号|拘束値|
|----------------------------|--------------------|--------------------|------|
|NODE_ID                     |DOF_idS             |DOF_idE             |Value |
|<font color="Red">FIX</font>,|<font color="Red">1</font>,|<font color="Red">3</font>,|<font color="Red">0.0</font>|

###### 2-4 `!CLOAD` (静解析におけるものと同一)

集中荷重の定義

|節点番号または節点グループ名|自由度番号|荷重値|
|----------------------------|----------|------|
|NODE_ID                     |DOF_id    |Value |
|<font color="Red">CL1</font>,|<font color="Red">3</font>,|<font color="Red">-1.0</font>|

###### 5-4 `!COUPLE, TYPE=1`

連成面の定義

|連成する面グループ名|
|--------------------|
|COUPLING_SURFACE_ID |
|<font color="Red">SCOUPLE</font>|

###### 2-11 `!STEP, CONVERG=1.E-10, ITMAX=20`

非線形静解析の制御 (線形解析の場合省略可、陽解法の場合は不要)

|収束値判定閾値<br/>(デフォルト:1.0E-06)|サブステップ数<br/>(AMPがある場合、AMPが優先)|最大反復計算回数|
|----------------------------------|----------------------------------------|----------------|
|CONVERG                           |SUBSTEPS                                |ITMAX           |
|<font color="Red">1.0E-10</font>  |                                        |<font color="Red">20</font>|

#### 動解析(周波数応答解析)制御データ

##### 動解析(周波数応答解析)制御データ例

```
!SOLUTION, TYPE=DYNAMIC                         1-2
!DYNAMIC                                        5-1
  11 , 2
  14000, 16000, 20, 15000.0
  0.0, 6.6e-5
  1, 1, 0.0, 7.2E-7
  10, 2, 1
  1, 1, 1, 1, 1, 1
!EIGENREAD                                      5-5
  eigen0.log
  1, 5
!FLOAD, LOAD CASE=2                             5-6
  _PickedSet5, 2, 1.0
!FLOAD, LOAD CASE=2
  _PickedSet6, 2, 1.0
```

##### ヘッダーの説明

  * <font color="Red">赤字</font>は例に記載されている数値、
  * 表2行目の英字は変数名をあらわす。

###### 5-1 `!DYNAMIC`

周波数応答解析の設定を行う。

#### ソルバー制御データ
|運動方程式の解法|解析の種類|
|----------------|----------|
| idx_eqa        | idx_resp |
|<font color="Red">11</font>|<font color="Red">2</font>|

|下限周波数|上限周波数|応答計算点数|変位を測定する周波数|
|----------|----------|------------|--------------------|
| f_start  | f_end    | n_freq     | f_disp             |
|<font color="Red">14000</font>|<font color="Red">16000</font>|<font color="Red">20</font>|<font color="Red">15000.0</font>|

|実時間での開始時間|実時間での終了時間|
|------------------|------------------|
| t_start          | t_end            |
|<font color="Red">0.0</font>|<font color="Red">6.6e-5</font>|

|質量マトリックスの種類|減衰の種類|Rayleigh減衰のパラメータR<sub>m</sub>|Rayleigh減衰のパラメータR<sub>k</sub>|
|----------------------|----------|-------------------------------------|-------------------------------------|
|idx_mas               | idx_dmp  | ray_m                               | ray_k                               |
|<font color="Red">1</font>|<font color="Red">1</font>|<font color="Red">0.0</font>|<font color="Red">7.2E-7</font>|

|時間空間でのサンプリング数|可視化データ出力指定<br/>(1:モード空間, 2:物理空間)|周波数空間モニタリング節点ID|
|--------------------------|----------------------------------------------|----------------------------|
| nout                     | vistype                                      | nodeout                    |
|<font color="Red">10</font>|<font color="Red">2</font>|<font color="Red">1</font>|

|出力制御変位|出力制御速度|出力制御加速度|出力制御無視|出力制御無視|出力制御無視|
|------------|------------|--------------|------------|------------|------------|
|iout_list(1)|iout_list(2)|iout_list(3)  |iout_list(4)|iout_list(5)|iout_list(6)|
|<font color="Red">1</font>|<font color="Red">1</font>|<font color="Red">1</font>|<font color="Red">1</font>|<font color="Red">1</font>|<font color="Red">1</font>|

###### 5-5 `!EIGENREAD`

周波数応答解析に用いる固有値・固有モードの指定

|固有値解析のログファイル名|
|--------------------------|
| eigenlog_filename        |
|<font color="Red">eigen0.log</font>|

|固有値解析に使用する指定モード始点|固有値解析に使用する指定モード終点|
|----------------------------------|----------------------------------|
| start_mode                       | end_mode                         |
|<font color="Red">1</font>        |<font color="Red">5</font>        |

###### 5-6 `!FLOAD`

周波数応答解析用集中荷重の定義

|節点番号または節点グループ名または面グループ名|自由度番号|荷重値|
|----------------------------------------------|----------|------|
|NODE_ID                                       |DOF_id    |Value |
|<font color="Red">_PickedSet5</font>|<font color="Red">2</font>|<font color="Red">1.0</font>

#### ソルバー制御データ

##### ソルバー制御データ例

```
### SOLVER CONTROL
!SOLVER, METHOD=CG, PRECOND=1, ITERLOG=YES, TIMELOG=YES        6-1
  10000, 1                                                     6-2
  1.0e-8, 1.0, 0.0                                             6-3
```

##### ヘッダーの説明

  * <font color="Red">赤字</font>は例に記載されている数値

###### 6-1 `!SOLVER,`

```
    METHOD=    解析方法
               (CG、BiCGSTAB、GMRES、GPBiCGなどがある)
    TIMELOG=   ソルバー計算時間出力の有無
    MPCMETHOD= 多点拘束処理の手法
               (1: ペナルティ法、2: MPC-CG法(非推奨) 、3: 陽的自由度消去法)
    DUMPTYPE=  行列ダンプ型式
    DUMPEXIT=  行列ダンプ直後にプログラムを終了するか

    以下のパラメータは解析方法で直接法を選択するとすべて無視される。
    PRECOND=   前処理の手法
    ITERLOG=   ソルバー収束履歴出力の有無
    SCALING=   行列の対角成分が1となるスケーリングの有無
    USEJAD=    ベクトル機向けオーダリングの有無
    ESTCOND=   条件数推定の頻度
               (指定された反復回数ごと、および、反復終了時に推定を実施。0の場合は推定なし。)
```

###### 6-2

|反復回数,|前処理の繰り返し数,|クリロフ部分空間数|マルチカラーの色数|前処理セットアップ情報の再利用回数|
|---------|-------------------|------------------|------------------|----------------------------------|
| NITER   |iterPREMAX         |NREST             |NCOLOR_IN         |RECYCLEPRE                        |
|<font color="Red">10000</font>|<font color="Red">1</font>|    |    |                                  |

###### 6-3

|打ち切り誤差, |前処理行列計算時の対角成分の倍率, |未使用|
|--------------|----------------------------------|------|
| RESID        | SIGMA_DIAG                       |SIGMA |
|<font color="Red">1.0e-8</font>,|<font color="Red">1.0</font>,|<font color="Red">0.0</font>|

#### ポスト処理(可視化)制御データ

以下にポスト処理（可視化）制御データの例とその内容を示す。

##### 可視化制御データ例

  * 各説明番号(P1-0, P1-1等)はのちの詳細説明の番号とリンクしている。
  * **P1**-XX は共通データ、**P2**-XX はレンダリングのためのパラメータをあらわす。

なおレンダリングについては `output_type=BMP` のときのみ有効となる。

 * `surface_style` が `!surface_style=2`(等値面)、`!surface_style=3` (ユーザー指定曲面)の場合、別途設定が必要となる。その記載については共通データ後にまとめて記載する。<br/>(**P3**-XX は`!surface_style=2`における等値面での説明。<br/> **P4**-XX は`!surface_style=3`におけるユーザー指定曲面での説明。)

  * `!!`のように`!`が2つ記載されているものはコメント文と認識され解析に影響を及ぼさない。

```
### Post Control 　　                           説明番号
!VISUAL, method=PSR                             P1-0
!surface_num = 1                                P1-1
!surface 1                                      P1-2
!surface_style = 1                              P1-3
!display_method = 1                             P1-4
!color_comp_name = STRESS                       P1-5
!colorsubcomp_name                              P1-6
!color_comp 7                                   P1-7
!!color_subcomp = 1                             P1-8
!iso_number                                     P1-9
!specified_color                                P1-10
!deform_display_on = 1                          P1-11
!deform_comp_name                               P1-12
!deform_comp                                    P1-13
!deform_scale = 9.9e-1                          P1-14
!initial_style = 1                              P1-15
!deform_style = 3                               P1-16
!initial_line_color                             P1-17
!deform_line_color                              P1-18
!output_type = BMP                              P1-19
!x_resolution = 500                             P2-1
!y_resolution = 500                             P2-2
!num_of_lights = 1                              P2-3
!position_of_lights = -20.0, 5.8, 80.0          P2-4
!viewpoint = -20.0 -10.0 5.0                    P2-5
!look_at_point                                  P2-6
!up_direction = 0.0 0.0 1.0                     P2-7
!ambient_coef= 0.3                              P2-8
!diffuse_coef= 0.7                              P2-9
!specular_coef= 0.5                             P2-10
!color_mapping_style= 1                         P2-11
!!interval_mapping_num                          P2-12
!interval_mapping= -0.01, 0.02                  P2-13
!rotate_style = 2                               P2-14
!rotate_num_of_frames                           P2-15
!color_mapping_bar_on = 1                       P2-16
!scale_marking_on = 1                           P2-17
!num_of_scale = 5                               P2-18
!font_size = 1.5                                P2-19
!font_color = 1.0 1.0 1.0                       P2-20
!background_color                               P2-21
!isoline_color                                  P2-22
!boundary_line_on                               P2-23
!color_system_type                              P2-24
!fixed_range_on = 1                             P2-25
!range_value = -1.E-2, 1.E-2                    P2-26
```

##### 共通データ一覧 (P1-1からP1-19)

| 番号               | キーワード           | 型                 | 内容               |
|--------------------|----------------------|--------------------|--------------------|
| P1-0               | `!VISUAL`            |                    | 可視化手法の指定   |
| P1-1               | `surface_num`        |                    | 1つのサーフェスレンダリング内のサーフェス数|
| P1-2               | `surface`            |                    | サーフェスの内容の設定 |
| P1-3               | `surface_style`      | integer            | 表面タイプの指定 (省略値: 1)<br/>1: 境界表面<br/>2: 等値面<br />3: 方程式によるユーザー定義の曲面 |
| P1-4               | `display_method`     | integer            | 表示方法 (省略値: 1)<br/>1: 色コードの表示<br/>2: 境界線表示<br/>3: 色コード及び境界線表示<br/>4: 指定色一色の表示<br/>5: 色分けにによる等値線表示 |
| P1-5               | `color_comp_name`    | character(100)     | 変数名とカラーマップとの対応 (省略値: 第一変数名) |
| P1-6               | `color_subcomp_name` | character(4)       | 変数がベクトルの時、表示するコンポーネントを指定する。(省略値: x)<br> norm: ベクトルのノルム<br/>x: x成分<br/>y: y 成分<br/>z: z 成分|
| P1-7               | `color_comp`         | integer            | 変数名に識別番号をつける (省略値: 0) |
| P1-8               | `color_subcomp`      | integer            | 変数の自由度が1以上の時、表示される自由度番号を指定する。<br/>0: ノルム<br/>(省略値: 1)|
| P1-9               | `iso_number`         | integer            | 等値線数を指定する。(省略値: 5) |
| P1-10              | `specified_color`    | real               | `display_method = 4`の時のカラーを指定する<br/>0.0 &lt; `specified_color` &lt; 1.0 |
| P1-11              | `!deform_display_on` | integer            | 変形の有無を指定する。<br/>1: on, 0: off (省略値: 0) |
| P1-12              | `!deform_comp_name`  | character(100)     | 変形を指定する際の採用する属性を指定する。<br/>(省略値: `DISPLACEMENT`という名の変数) |
| P1-13              | `!deform_ comp`      | integer            | 変形を指定する際の変数の識別番号<br/>(省略値: 0)|
| P1-14              | `!deform_scale`      | real               | 変形を表示する際の変位スケールを指定する。<br/>Default:自動<br/>`standard_scale` = 0.1 * sqrt(`x_range`<sup>2</sup> + `y_range`<sup>2</sup> + `z_range`<sup>2</sup>) / `max_deform`<br/>`user_defined`: `real_scale` = `standard_scale` * `deform_scale`|
| P1-15              | `!initial_style`     | integer            | 変形表示のタイプを指定する(省略値: 1)<br/>0: 無し<br/>1: 実線メッシュ(指定がなければ青で表示)<br/>2: グレー塗りつぶし<br/>3: シェーディング(物理属性をカラー対応させる)<br/>4: 点線メッシュ(指定がなければ青で表示)|
| P1-16              | `!deform_style`      | integer            | 初期、変形後の形状表示スタイルを指定する(省略値: 4)<br/>0: 無し<br/>1: 実線メッシュ（指定がなければ青で表示)<br/>2: グレー塗りつぶし<br/>3: シェーディング(物理属性をカラー対応させる)<br/>4: 点線メッシュ(指定がなければ青で表示)|
| P1-17              | `!initial_line_color` | real (3)           | 初期メッシュを表示する際のカラーを指定する。<br/>これは実線、点線両者を含む。<br/>(省略値: 青(0.0, 0.0, 1.0)) |
| P1-18              | `!deform_line_color` | real (3)           | 変形メッシュを表示する際のカラーを指定する。<br/>これは実線、点線両者を含む。<br/>(黄色(1.0, 1.0, 0.0)) |
| P1-19              | `output_type`        | character(3)       | 出力ファイルの型を指定する。(省略値: AVS)<br/>`AVS`: AVS用UCDデータ(物体表面上のみ)<br/>`BMP`: イメージデータ(BMPフォーマット)<br/>`COMPLETE_AVS`: AVS用UCDデータ<br/>`COMPLETE_REORDER_AVS`: 節点・要素番号を並び替え<br/>`SEPARATE_COMPLETE_AVS`: 分割領域ごと<br/>`COMPLETE_MICROAVS`: 物理量スカラー出力<br/>`FSTR_FEMAP_NEUTRAL`: FEMAP用ニュートラルファイル|

##### レンダリングデータ一覧 (P2-1からP2-26)

(output_type = BMPの時のみ有効)　

|        | キーワード             | 型       |  内容 |
|--------|------------------------|----------|-------|
| P2-1   | `x_resolution`         | integer  | 最終図の幅を指定する。 (省略値: 512) |
| P2-2   | `y_resolution`         | integer  | 最終図の高さを指定する。 (省略値: 512) |
| P2-3   | `num_of_lights`        | integer  | 照明の個数を指定する。 (省略値: 1) |
| P2-4   | `position_of_lights`   | real(:)  | 照明の位置を座標で指定する。 (省略値: 正面真上)<br/>指定方法<br/> `!position_of_lights= x, y, z, x, y, z,...`<br/>例) `!position_of_lights=100.0, 200.0, 0.0`<br/>|
| P2-5   | `viewpoint`            | real(3)  | 視点の位置を座標で指定する。<br/>(省略値: x = (x<sub>min</sub> + x<sub>max</sub>)/2.0<br/> y = y<sub>min</sub> + 1.5 \*( y<sub>max</sub> - y<sub>min</sub>)<br/>z = z<sub>min</sub> + 1.5 \*( z<sub>max</sub> - z<sub>min</sub>) )
| P2-6   | `look_at_point`        | real(3)  | 視線の位置を指定する。<br/>(省略値: データの中心)|
| P2-7   | `up_direction`         | real(3)  | Viewpoint, `look_at_point` and `up_direction` にてビューフレーム を定義する。 (省略値: 0.0, 0.0, 1.0) |
| P2-8   | `ambient_coef`         | real     | 周囲の明るさを指定する。 (省略値: 0.3) |
| P2-9   | `diffuse_coef`         | real     | 乱反射光の強さを係数にて指定する。(省略値: 0.7)|
| P2-10  | `specular_coef`        | real     | 鏡面反射の強さを係数にて指定する。(省略値: 0.6)|
  P2-11  | `color_mapping_style`  | integer  | カラーマップの方法を指定する。 (省略値: 1)<br/> 1: 完全線形マップ (全色をRGBに線形に写像する)<br/> 2: クリップ線形マップ (`mincolor`から`maxcolor`)をRGBカラースペースに写像する。<br/> 3: 非線形カラーマップ (全領域を複数の区間に分割し、区間ごとには線形マップを行う) <br/>4: 最適自動調整 (データの分布を統計処理してカラーマップを決定する)|
| P2-12  | `interval_mapping_num` | integer  | `color_mapping_style = 3` の時の区間の数を指定する。|
| P2-13  | `interval_mapping`     | real(:)  | `color_mapping_style = 2` or `3` の時の区間位置とカラー番号を指定する。<br/>`color_mapping_style=2`の場合<br/> `!interval_mapping=[minimum color], [maximum color]`<br/> If `color_mapping_style=3`の場合<br/>`!interval_mapping=[区間,対応するカラー値\],・・・指定回繰り返し`<br/>注意：1行内に記述すること。|
| P2-14  | `rotate_style`         | integer  | アニメーションの回転軸を指定する。<br/>1: x軸で回転する。<br/>2: y軸で回転する。<br/>3: z軸で回転する。<br/>4: 特に視点を指定してアニメーションする。 (8フレーム)<br/>|
| P2-15  | `rotate_num_of_frames` | integer  | アニメーションのサイクルを指定する。<br/>(`rotate_style` = 1, 2, 3) (省略値: 8)|
| P2-16  | `color_mapping_bar_on` | integer  | カラーマップバーの有無を指定する。<br/>0: off 1: on　省略値: 0|
| P2-17  | `scale_marking_on`     | integer  | カラーマップバーに値の表示の有無を指定する。<br/>0: off 1: on　省略値: 0|
| P2-18  | `num_of_scale`         | integer  | カラーバーのメモリの数を指定する。 (省略値: 3)|
| P2-19  | `font_size`            | real     | カラーマップバーの値表示の際のフォントサイズを指定する。<br/>範囲: 1.0-4.0 (省略値: 1.0)|
| P2-20  | `font_color`           | real(3)  | カラーマップバーの値表示の際の表示色を指定する。<br/>(省略値: 1.0, 1.0, 1.0 (白)) |
| P2-21  | `background_color`     | real(3)  | 背景色を指定する。 (省略値: 0.0, 0.0, 0.0 (黒))|
| P2-22  | `isoline_color`        | real(3) | 等値線の色を指定する。(省略値: その値と同じ色)|
| P2-23  | `boundary_line_on`     | integer  | データの地域を表示の有無を指定する。<br/>0: off 1: on　省略値: 0|
| P2-24  | `color_system_type`    | integer  | カラーマップのスタイルを指定する(省略値: 1)<br/>1: (青－赤)(昇順に)<br/>2: レインボーマップ (赤から紫へ昇順に)<br/>3: (黒－白)(昇順に).|
| P2-25  | `fixed_range_on`       | integer  | カラーマップの方法を他のタイムステップに対して保持するか否かを指定する。<br/>0: off 1: on (省略値: 0)|
| P2-26  | `range_value`          | real(2) | 区間を指定する。|

##### `surface_style`の設定値別データ一覧

###### (等値面 (`surface_style=2`) の場合)

|      | キーワード          | 型             | 内容                                                                 |
|------|---------------------|----------------|----------------------------------------------------------------------|
| P3-1 | `data_comp_name`    | character(100) | 等値面の属性に名前をつける。                                         |
| P3-2 | `data_subcomp_name` | character(4)   | 変数がベクトルの時、表示するコンポーネントを指定する。 (省略値: x)<br/>norm: ベクトルのノルム<br/>x: x成分<br/>y: y成分<br/>z: z成分 |
| P3-3 | `data_comp`         | integer        | 変数名に識別番号をつける (省略値: 0)                                |
| P3-4 | `data_subcomp`      | integer        | 変数の自由度が1以上の時、表示される自由度番号を指定する。<br/>0: ノルム (省略値: 1)<br/>|
| P3-5 | `iso_value`         | real           | 等値面の値を指定する。                                               |

###### (ユーザーの方程式指定による曲面(`surface_sytle = 3`)の場合)

|      | キーワード | 型      | 内容 |
|------|------------|---------|-----------------------------------|
| P4-1 | method     | integer | 曲面の属性を指定する。(省略値: 5)<br/>1: 球面<br/>2: 楕円曲面<br/>3: 双曲面<br/>4: 方物面<br/>5: 一般的な2次曲面|
| P4-2 | point      | real(3) | method = 1, 2, 3, or 4　の時の中心の座標を指定する。(省略値: 0.0, 0.0, 0.0)|
| P4-3 | radius     | real    | method = 1 の時の半径を指定する。(省略値: 1.0)|
| P4-4 | length     | real    | method = 2, 3, 又は4)の時の径の長さを指定する。<br/>注意: 楕円曲面の場合一つの径の長さは1.0である。|
| P4-5 | coef       | real    | method=5の時、2次曲面の係数を指定する。<br/>coef[1]x<sup>2</sup> + coef[2]y<sup>2</sup> + coef[3]z<sup>2</sup> + coef[4]xy + coef[5]xz + coef[6]yz + coef[7]x + coef[8]y + coef[9]z + coef[10]=0<br/>例: coef=0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, -10.0<br/>これはy=10.0　という平面を意味する。|
