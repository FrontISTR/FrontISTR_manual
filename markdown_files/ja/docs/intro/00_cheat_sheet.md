---
title: FrontISTR Ver.5.1 チートシート(2020/08/06)
# pandoc -s ../ja/docs/intro/00_cheat_sheet.md -c css/mystyle.css -o 00_cheat_sheet.html
---

## チートシート

### インストール

~~~
$ tar xzf FrontISTR-v5.1.tar.gz
$ cd FrontISTR-v5.1
$ mkdir build; cd build
$ cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/local
$ make -j2; make install
~~~

### 並列実行

~~~
$ hecmw_part1
$ mpirun -np <4> fistr1
~~~

### 入力

| ファイルの種類     | ファイル名          |
|:--------------|:--------------------|
| 全体制御ファイル   | hecmw_ctrl.dat      |
| メッシュデータ     | <ModelName>.msh     |
| 解析制御データ     | <ModelName>.cnt     |
| 領域分割制御データ | hecmw_part_ctrl.dat |

### 出力

| ファイルの種類     | ファイル名          |
|:--------------|:--------------------|
| ログファイル       | <0>.log             |
| 解析結果ファイル   | <ModelName>.res.<0>.<Step> |
| 可視化用ファイル   | <ModelName>_vis_psf.<Step>.pvtu |

### 全体制御ファイル(hecmw_ctrl.dat)

~~~
!MESH, NAME=part_in, TYPE=HECMW-ENTIRE
 <ModelName>.msh
!MESH, NAME=part_out, TYPE=HECMW-DIST
 <ModelName>.p
!MESH, NAME=fstrMSH, TYPE=HECMW-DIST, REFINE=<1>
 <ModelName>.p
!CONTROL, NAME=fstrCNT
 <ModelName>.cnt
!RESTART, NAME=restart_in, IO=INOUT
 <ModelName>.restart
!RESULT, NAME=fstrTEMP, IO=IN
 <ModelName>.res
!RESULT, NAME=fstrRES, IO=OUT, TYPE=BINARY
 <ModelName>.res
!RESULT, NAME=vis_out, IO=OUT
 <ModelName>_vis
!SUBDIR, ON
~~~

### 領域分割制御データ(hecmw_part_ctrl.dat)

~~~
!PARTITION, TYPE=NODE-BASED, METHOD=PMETIS, DOMAIN=<4>
~~~

### メッシュファイル

~~~
!HEADER
 <TITLE>
!NODE
 <NODE_ID>, <x>, <y>, <z>
!ELEMENT, TYPE=<341>, EGRP=<E1>
 <ELEM_ID>, <node1>, <node2>, <node3>, ...
!MATERIAL, NAME=<STRMAT>, ITEM=<3>
!ITEM=1, SUBITEM=2
 <YoungModulus>, <PoissonRatio>
!ITEM=2
 <Density>
!ITEM=3
 <ExpansionCoeff>
!MATERIAL, NAME=<HEATMAT>, ITEM=<3>
!ITEM=1, SUBITEM=2
 <Density>, <Temperature>
!ITEM=2, SUBITEM=2
 <SpecificHeat>, <Temperature>
!ITEM=3, SUBITEM=2
 <Conductivity>, <Temperature>
!SECTION, TYPE=<SOLID>, EGRP=<E1>, MATERIAL=<STRMAT>
!NGROUP, NGRP=<NG1>
 <node1>, <node2>, ...
!SGROUP, SGRP=<SG1>
 <elem1>, <localsurf1>, <elem2>, <localsurf2>, ...
!EGROUP, EGRP=<EG1>
 <elem1>, <elem2>, ...
!CONTACT PAIR, NAME=<CP1>
 <Slave_NodeGroup>, <Master_SurfaceGroup>
!AMPLITUDE, NAME=<AMP1>, VALUE=<RELATIVE|ABSOLUTE>
 <value1>, <time1>, <value2>, <time2>, ...
!EQUATION
 <Num_terms>, <RHS>
 <NODE_ID>, <dof>, <coeff>, ...
!ZERO
 <AbsoluteZero>
!END
~~~

### バージョン

~~~
!VERSION
 5
~~~

### 静解析

~~~
!SOLUTION, TYPE=STATIC
!STATIC
!BOUNDARY,GRPID=<1>
 <NODE_ID>, <開始自由度>, <終了自由度>, <拘束値>
!CLOAD,GRPID=<1>
 <NODE_ID>, <自由度>, <荷重値>
!DLOAD,GRPID=<1>
 <SGRP>, <荷重タイプ>, <荷重パラメータ>
!SPRING,GRPID=<1>
 <NODE_ID>, <拘束自由度>, <ばね定数>
~~~

### 接触

~~~
!CONTACT_ALGO, TYPE=<SLAGRANGE|ALAGRANGE>
!CONTACT, GRPID=<1>, NTOL=<法線方向閾値>, TTOL=<接線方向閾値>, NPENALTY=<法線方向ペナルティ>, TPENALTY=<接線方向ペナルティ>
 <接触ペア名>, <摩擦係数>, <摩擦のペナルティ剛性>
~~~

### 熱応力

~~~
!REFTEMP
 <温度>
!TEMPERATURE, READRESULT=<結果ステップ数>, SSTEP=<開始ステップ>, INTERVAL=<ステップ間隔>
~~~

### 固有値

~~~
!SOLUTION, TYPE=EIGEN
!EIGEN
 <固有値数>, <許容差>, <最大反復数>
!BOUNDARY
~~~

### 熱伝導

~~~
!SOLUTION, TYPE=HEAT
!HEAT
 <DT>, <計算時間>, <時間増分>, <許容変化>, <最大反復>, <判定値>
!INITIAL_CONDITION, TYPE=<TEMPERATURE>
 <NODE_ID>, <温度>
!FIXTEMP
 <NODE_ID>, <温度>
!CFLUX
 <NODE_ID>, <熱流束>
!DFLUX
 <ELEMENT_ID>, <荷重タイプ>, <熱流束>
!SFLUX
 <SGRP>, <熱流束>
!FILM
 <ELEMENT_ID>, <荷重タイプ>, <熱伝達係数>, <雰囲気温度>
!SFLIM
 <SGRP>, <熱伝達係数>, <雰囲気温度>
!RADIATE
 <ELEMENT_ID>, <荷重タイプ>, <輻射係数>, <雰囲気温度>
!SRADIATE
 <SGRP>, <輻射係数>, <雰囲気温度>
!WELD_LINE
 <電流>, <電圧>, <入熱効率>, <トーチ移動速度>
 <EGRP>, <DOF>, <始点座標>, <終点座標>, <溶接源の幅>, <溶接開始時刻> 
~~~

### 動解析

~~~
!SOLUTION, TYPE=DYNAMIC
!BOUNDARY
!CLOAD
!DLOAD
!SPRING
!VELOCITY, TYPE=<INITIAL|TRANSIT>, AMP=<NAME>
 <NODE_ID>, <自由度>, <自由度>, <拘束値>
!ACCELERATION, TYPE=<INITIAL|TRANSIT>, AMP=<NAME>
 <NODE_ID>, <自由度>, <自由度>, <拘束値>
!INITIAL_CONDITION, TYPE=<VELOCITY|ACCELERATION>
 <NODE_ID>, <DOF>, <value>
~~~

### 時刻歴応答

~~~
!DYNAMIC, TYPE=<LINEAR|NONLINEAR>
 <陰解法1|陽解法11>, <時刻歴1>
 <開始時刻>, <終了時刻>, <全ステップ数>, <時間増分>
 <γ>, <β>
 <集中質量1|consistent質量2>, 1, <Rm>, <Rk>
 1, <モニタリング節点>, <モニタリング出力間隔>
 <変位>, <速度>, <加速度>, <反力>, <ひずみ>, <応力>
~~~

### 周波数応答

~~~
!DYNAMIC, TYPE=NONLINEAR
 <陰解法1|陽解法11>, <周波数2>
 <下限周波数>, <上限周波数>, <応答計算点数>, <変位測定周波数>
 <振動開始時刻>, <振動終了時刻>
 <集中質量1>, 1, <Rm>, <Rk>
 <サンプリング数>, <モード空間1|物理空間2>, <モニタリング節点>
 <変位>, <速度>, <加速度>, 0, 0, 0
!EIGENREAD
 <固有値解析のログファイル>
 <モード始点>, <モード終点>
!FLOAD
 <NODE_ID>, <自由度>, <荷重値>
~~~

### 解析ステップ

~~~
!STEP, TYPE=<STATIC|VISCO>, SUBSTEPS=<最大サブステップ数>, CONVERG=<判定値>, MAXITER=<最大反復回数>
 <時間増分値>, <ステップ時間幅>
 BOUNDARY, <GRPID>
 LOAD, <GRPID>
 CONTACT, <GRPID>
~~~

### 自動時間増分

~~~
!AUTOINC_PARAM, NAME=<AP1>
 <時間増分減少率>, <最大反復数>, <合計反復数>, <接触反復数>, <減少条件成立サブステップ>
 <時間増分増加率>, <最大反復数>, <合計反復数>, <接触反復数>, <増加条件成立サブステップ>
 <カットバック時間増分減少率>, <カットバック回数> 
!TIME_POINTS, NAME=<時刻リスト>, TIME=<STEP|TOTAL>
 <TIME>
!STEP, TYPE=<STATIC|VISCO>, SUBSTEPS=<最大サブステップ数>, CONVERG=<判定値>, MAXITER=<最大反復回数>, INC_TYPE=AUTO, MAXRES=<最大許容残差>, TIME_POINTS=<時刻リスト名>, AUTOINCPARAM=<自動増分パラメータ名>, MAXCONTITER=<最大接触反復回数>
 <初期時間増分値>, <ステップ時間幅>, <時間増分下限>, <時間増分上限>
 BOUNDARY, <GRPID>
 LOAD, <GRPID>
 CONTACT, <GRPID>
~~~

| 境界条件種類 | 属するカード                 |
|:-------------|:-----------------------------|
| BOUNDARY     | !BOUNDARY, !SPRING           |
| LOAD         | !CLOAD, !DLOAD, !TEMPERATURE |
| CONTACT      | !CONTACT                     |

### 出力

~~~
!WRITE, VISUAL, FREQUENCY=<出力間隔>
!WRITE, RESULT, FREQUENCY=<出力間隔>
!OUTPUT_VIS
 <出力変数名>, <ON|OFF>
!OUTPUT_RES
 <出力変数名>, <ON|OFF>
!OUTPUT_SSTYPE, TYPE=<SOLUTION|MATERIAL>
~~~

主な出力変数名

| 変数名     | 物理量           | 対象    |
|:-----------|:-----------------|:--------|
| DISP       | 変位             | VIS,RES |
| REACTION   | 節点反力         | VIS,RES |
| NSTRAIN    | 節点ひずみ       | VIS,RES |
| NSTRESS    | 節点応力         | VIS,RES |
| NMISES     | 節点Mises応力    | VIS,RES |
| ESTRAIN    | 要素ひずみ       | RES     |
| ESTRESS    | 要素応力         | RES     |
| EMISES     | 要素Mises応力    | RES     |
| VEL        | 速度             | VIS,RES |
| ACC        | 加速度           | VIS,RES |
| TEMP       | 温度             | VIS,RES |

### リスタート

~~~
!RESTART, FREQUENCY=<n>
~~~

### 局所座標

~~~
!ORIENTATION, NAME=<座標系名>, DEFINITION=COORDINATES
<ax,ay,az>,<bx,by,bz>,<cx,cy,cz>
~~~

~~~
!ORIENTATION, NAME=<座標系名>, DEFINITION=NODES
<a,b,c>
~~~

### セクション

~~~
!SECTION, SECNUM=<メッシュデータのSECTION順>, ORIENTATION=<局所座標系名>, FORM361=<FBAR|IC|BBAR|FI>
~~~

### 材料物性値

~~~
!MATERIAL, NAME=<材料名>
!ELASTIC, TYPE=<ISOTROPIC|ORTHOTROPIC>, DEPENDENCIES=<0>
 <ヤング率>, <ポアソン比>
!DENSITY
 <質量密度>
!EXPANSION_COEFF, TYPE=<ISOTROPIC|ORTHOTROPIC>, DEPENDENCIES=<0>
 <線膨張係数>
~~~

~~~
!PLASTIC, YIELD=MISES, HARDEN=BILINEAR, DEPENDENCIES=<0>
 <初期降伏応力>, <硬化係数>
~~~

~~~
!PLASTIC, YIELD=MISES, HARDEN=MULTILINEAR, DEPENDENCIES=<0>
 <降伏応力>, <塑性ひずみ>
 <降伏応力>, <塑性ひずみ>
 ...
~~~

~~~
!PLASTIC, YIELD=MISES, HARDEN=SWIFT, DEPENDENCIES=<0>
 <ε0>, <K>, <n>
~~~

~~~
!PLASTIC, YIELD=<Mohr-Coulomb|Drucker-Prager>, HARDEN=BILIENAR, DEPENDENCIES=<0>
 <粘着力>, <内部摩擦角>, <硬化係数>
~~~

~~~
!HYPERELASTIC, TYPE=NEOHOOKE
 <C10>, <D>
~~~

~~~
!VISCOELASTIC
 <せん断緩和弾性率>, <緩和時間>
~~~

~~~
!CREEP, TYPE=Norton, DEPENDENCIES=<0>
 <A>, <n>, <m>
~~~

### ソルバー制御

~~~
!SOLVER, METHOD=<CG>, PRECOND=<1>, MPCMETHOD=<3>
 <反復回数>, <前処理繰り返し数>, <クリロフ>, <目標色数>, <セットアップ再利用>
 <打切り誤差>, <対角成分倍率>, 0.0
~~~

| 解法      | 備考                             |
|:----------|:---------------------------------|
| CG        |                                  |
| BiCGSTAB  |                                  |
| GMRES     | クリロフ部分空間数を設定すること |
| GPBiCG    |                                  |
| DIRECT    |                                  |
| DIRECTmkl | 接触解析で使う                   |
| MUMPS     |                                  |

| 値  | 前処理           |
|:----|:-----------------|
| 1,2 | SSOR             |
| 3   | Diagonal Scaling |
| 5   | AMG              |
| 10  | Block ILU(0)     |
| 11  | Block ILU(1)     |
| 12  | Block ILU(2)     |

| 値 | MPC手法          |
|:---|:-----------------|
| 1  | ペナルティ法     |
| 2  | MPC-CG法         |
| 3  | 陽的自由度消去法 |

### ソルバー制御（AMG）

~~~
!SOLVER, METHOD=<CG>, PRECOND=5, MPCMETHOD=<3>
 <反復回数>, <前処理繰り返し数>, <クリロフ>, <目標色数>, <セットアップ再利用>
 <打切り誤差>, <対角成分倍率>, 0.0
 <粗グリッドソルバ>, <スムーザー>, <マルチグリッドサイクル>, <最大レベル>, <コースニングスキーム>, <スムーザースィープ数>
~~~

### ポスト処理（ParaView用データ出力）

~~~
!VISUAL
!output_type=VTK
~~~

### ポスト処理（BMP画像出力）

~~~
!VISUAL, method=PSR
!surface_num=1
!surface
!surface_style=1
!display_method=1
!color_comp_name=STRESS
!color_comp=7
!x_resolution=800
!y_resolution=600
!output_type=BMP
~~~

### 非線形解析

| 解析の種類 | 関連するカード                                                      |
|:-----------|:----------------------------------------------------------------|
| 静解析     | !SOLUTION, TYPE=NLSTATIC<BR>!STEP                                                            |
| 動解析     | !DYNAMIC, TYPE=NONLINEAR<BR>!STEP                                |
| 接触解析   | !CONTACT<BR>!CONTACT_ALGO<BR>!STEP                               |
| 材料非線形 | !PLASTIC<BR>!HYPERELASTIC<BR>!VISCOELASTIC<BR>!CREEP              |