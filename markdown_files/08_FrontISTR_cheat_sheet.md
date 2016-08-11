<head>
<meta charset="utf-8" />
<title>FrontISTR_CheatSheet_V4_5</title>
<link rel="stylesheet" type="text/css" href="css/FrontISTR_cheat_sheet.css"/>
</head>
# FrontISTR Ver.4.5 Cheat Sheet (2016/8/11) <img src="image/FrontISTR_logo.png" alt="FrontISTR_logo" width="6%" height="3%">
<div class="block_1">
## インストール
~~~
$ ./setup.sh -p --with-tools --with-metis
$ make
$ make install
~~~
## 並列実行
~~~
$ hecmw_part1
$ mpirun -np <4> fistr1
~~~
## 入出力

|ファイルの種類|ファイル名|入出力|
|:-|:-|:-|
|全体制御ファイル|hecmw_ctrl.dat|入|
|メッシュデータ|\<ModelName\>.msh|入|
|解析制御データ|\<ModelName\>.cnt|入|
|領域分割制御データ|hecmw_part_ctrl.dat|入|
|ログファイル|\<0\>.log|出|
|解析結果ファイル|\<ModelName\>.res|出|

## 全体制御ファイル（hecmw_ctrl.dat）
~~~
!MESH,NAME=part_in,TYPE=HECMW-ENTIRE
 <ModelName>.msh
!MESH,NAME=part_out,TYPE=HECMW-DIST
 <ModelName_p4>
!MESH, NAME=fstrMSH,TYPE=HECMW-DIST
 <ModelName_p4>
!CONTROL,NAME=fstrCNT
 <ModelName>.cnt
!RESULT,NAME=fstrRES,IO=OUT
 <ModelName>.res
~~~
## 領域分割制御データ(hecmw_part_ctrl.dat)
~~~
!PARTITION,TYPE=NODE-BASED,METHOD=PMETIS,DOMAIN=<4>
~~~
## メッシュファイル
~~~
!HEADER
<TITLE>
!NODE
 NODE_ID, x, y, z
!ELEMENT,TYPE=<341>
 ELEM_ID, node1, node2, node3, ...
!SECTION,TYPE=<SOLID>,EGRP=<EG1>,MATERIAL=<MAT1>
~~~
</div><div class="block_2">
~~~
!NGROUP,NGRP=<NG1>
 node1, node2, ...
!SGROUP,SGRP=<SG1>
 elem1, localsurf1, elem2, localsurf2, ...
!EGROUP,EGRP=<EG1>
 elem1, elem2, ...
!CONTACT PAIR,NAME=<CP1>
 <Slave_NodeGroup>, <Master_SurfaceGroup>
!AMPLITUDE,NAME=<AMP1>,VALUE=<RELATIVE|ABSOLUTE>
 value1, time1, value2, time2, ...
!INITIAL CONDITION,TYPE=TEMPERATURE
 NODE_ID, value
!EQUATION
 <項数>, <右辺値>
 NODE_ID, <dof>, <係数>, ...
!ZERO
!END
~~~
## 解析制御ファイル（共通）
~~~
!VERSION
 4.4
!WRITE,VISUAL,FREQUENCY=<出力間隔>
!WRITE,RESULT,FREQUENCY=<出力間隔>
!OUTPUT_VIS
 <出力変数名>, <ON|OFF>
!OUTPUT_RES
 <出力変数名>, <ON|OFF>
!RESTART,FREQUENCY=<出力間隔>
!END
~~~
|変数名|物理量|対象|
|:-|:-|:-|
|DISP|変位|VIS,RES|
|ROT|回転|VIS,RES|
|REACTION|節点反力|VIS,RES|
|NSTRAIN|節点ひずみ|VIS,RES|
|NSTRESS|節点応力|VIS,RES|
|NMISES|節点Mises応力|VIS,RES|
|ESTRAIN|要素ひずみ|RES|
|ESTRESS|要素応力|RES|
|EMISES|要素Mises応力|RES|
|ISTRAIN|積分点ひずみ|RES|
|ISTRESS|積分点応力|RES|
|PL_ISTRAIN|積分点塑性ひずみ|RES|
|VEL|速度|VIS,RES|
|ACC|加速度|VIS,RES|

</div><div class="block_3">

## 解析制御ファイル（静解析）
~~~
!SOLUTION,TYPE=<STATIC|NLSTATIC>
!STATIC
!BOUNDARY,GRPID=<1>
 NODE_ID, <開始自由度>, <終了自由度>, <拘束値>
!CLOAD,GRPID=<1>
 NODE_ID, <自由度>, <荷重値>
!DLOAD,GRPID=<1>
　SGRP, <荷重タイプ>, <荷重パラメータ>
!SPRING,GRPID=<1>
 NODE_ID, <拘束自由度>, <ばね定数>
~~~
## 解析制御ファイル（接触）
~~~
!CONTACT_ALGO,TYPE=<SLAGRANGE|ALAGRANGE>
!CONTACT,GRPID=<1>,NTOL=<法線方向閾値>,TTOL=<接線方向閾値>,NPENALTY=<法線方向ペナルティ>,TPENALTY=<接線方向ペナルティ>
 <接触ペア名>, <摩擦係数>, <摩擦のペナルティ剛性>
~~~
## 解析制御ファイル（熱応力）
~~~
!REFTEMP
 <温度>
!TEMPERATURE,READRESULT=<結果ステップ数>,SSTEP=<開始ステップ>,INTERVAL=<ステップ間隔>
~~~
## 解析制御ファイル（固有値）
~~~
!EIGEN
 <固有値数>, <許容差>, <最大反復数>
!BOUNDARY
~~~
## 解析制御ファイル（熱伝導）
~~~
!HEAT
 <DT>, <計算時間>, <時間増分>, <許容変化>, <最大反復>, <判定値>
!FIXTEMP
 NODE_ID, <温度>
!CFLUX
 NODE_ID, <熱流束>
!DFLUX
　ELEMENT_ID, <荷重タイプ>, <熱流束>
!SFLUX
　SGRP, <熱流束>
~~~
</div><div class="clear"/><div class="block_1">
~~~
!FILM
　ELEMENT_ID, <荷重タイプ>, <熱伝達係数>, <雰囲気温度>
!SFLIM
　SGRP, <熱伝達係数>, <雰囲気温度>
!RADIATE
　ELEMENT_ID, <荷重タイプ>, <輻射係数>, <雰囲気温度>
!SRADIATE
　SGRP, <輻射係数>, <雰囲気温度>
~~~
## 解析制御ファイル（動解析共通）
~~~
!BOUNDARY
!CLOAD
!VELOCITY,TYPE=<INITIAL|TRANSIT>,AMP=<NAME>
 Node_ID, <自由度>, <自由度>, <拘束値>
!ACCELERATION,TYPE=<INITIAL|TRANSIT>,AMP=<NAME>
 Node_ID, <自由度>, <自由度>, <拘束値>
~~~
## 解析制御ファイル（動解析時刻歴応答）
~~~
!DYNAMIC,TYPE=NONLINEAR
 <陰解法1|陽解法11>, <時刻歴1>
 <開始時刻>, <終了時刻>, <全ステップ数>, <時間増分>
 <γ>, <β>
 <集中質量|consistent質量2>, 1, <Rm>, <Rk>
 1, <モニタリング節点>, <モニタリング出力間隔>
 <変位>, <速度>, <加速度>, <反力>, <ひずみ>, <応力>
~~~
## 解析制御ファイル（動解析周波数応答）
~~~
!DYNAMIC,TYPE=NONLINEAR
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
 NODE_ID, <自由度>, <荷重値>
~~~
## 解析ステップ
~~~
!STEP,TYPE=<STATIC|VISCO>,SUBSTEPS=<分割数>,CONVERG=<判定値>
 <時間増分値>, <時間増分終値>
 BOUNDARY, <GRPID>
 LOAD, <GRPID>
 CONTACT, <GRPID>
~~~
</div><div class="block_2">
| 境界条件種類 | 属するカード |
|:-|:-|
| BOUNDARY | !BOUNDARY, !SPRING |
| LOAD | !CLOAD, !DLOAD, !TEMPERATURE |
| CONTACT | !MATERIAL |
## 材料物性値
~~~
!MATERIAL,NAME=<材料名>
!ELASTIC,TYPE=<ISOTROPIC|ORTHOTROPIC>,DEPENDENCIES=<0>
 <ヤング率>, <ポアソン比>
!DENSITY
 <質量密度>
!EXPANSION_COEFF,TYPE=<ISOTROPIC|ORTHOTROPIC>,DEPENDENCIES=<0>
 <線膨張係数>
~~~
~~~
!PLASTIC,YIELD=MISES,HARDEN=BILINEAR,DEPENDENCIES=<0>
 <初期降伏応力>, <硬化係数>
~~~
~~~
!PLASTIC,YIELD=MISES,HARDEN=MULTILINEAR,DEPENDENCIES=<0>
 <降伏応力>, <塑性ひずみ>
 <降伏応力>, <塑性ひずみ>
 ...
~~~
~~~
!PLASTIC,YIELD=MISES,HARDEN=SWIFT,DEPENDENCIES=<0>
 <ε0>, <K>, <n>
~~~
~~~
!PLASTIC,YIELD=<Mohr-Coulomb|Drucker-Prager>,HARDEN=BILIENAR,DEPENDENCIES=<0>
 <粘着力>, <内部摩擦角>, <硬化係数>
~~~
~~~
!HYPERELASTIC,TYPE=NEOHOOKE
 <C10>, <D>
~~~
~~~
!VISCOELASTIC
 <せん断緩和弾性率>, <緩和時間>
~~~
~~~
!CREEP,TYPE=Norton,DEPENDENCIES=<0>
 <A>, <n>, <m>
~~~
## ソルバー制御
~~~
!SOLVER,METHOD=<CG>,PRECOND=<1>,MPCMETHOD=<3>
 <反復回数>, <前処理繰り返し数>, <クリロフ>, <目標色数>
 <打切り誤差>, <対角成分倍率>, 0.0
~~~
</div><div class="block_3">
| 解法 | 備考 |
|:-|:-|
|CG||
|BiCGSTAB||
|GMRES|クリロフ部分空間数を設定すること|
|GPBiCG||
|DIRECT||
|DIRECTmkl|接触解析で使う|
|MUMPS||

| 値 | 前処理 |
|:-|:-|
| 1,2 | SSOR |
| 3 | Diagonal Scaling |
| 5 | AMG |
| 10 | Block ILU(0) |
| 11 | Block ILU(1) |
| 12 | Block ILU(2) |

| 値 | MPC手法 |
|:-|:-|
| 1 | ペナルティ法 |
| 2 | MPC-CG法 |
| 3 | 陽的自由度消去法 |

## ポスト処理（AVS用データ出力）
~~~
!VISUAL
!output_type=COMPLETE_REORDER_AVS
~~~
## ポスト処理（境界面BMP画像出力）
~~~
!VISUAL,method=PSR
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
## 非線形解析

| 解析の種類 | 関連するカード |
|:-|:-|
| 静解析 | !SOLUTION, TYPE=NLSTATIC<BR>!STEP |
| 動解析 | !DYNAMIC, TYPE=NONLINEAR<BR>!STEP |
| 材料非線形 | !MATERIAL<BR>!PLASTIC<BR>!HYPERELASTIC<BR>!VISCOELASTIC<BR>!CREEP |

</div>
