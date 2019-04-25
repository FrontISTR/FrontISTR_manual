
# Cheat sheet

## Installation

~~~
$ ./setup.sh -p --with-tools --with-metis
$ make
$ make install
~~~

## Parallel execution

~~~
$ hecmw_part1
$ mpirun -np <4> fistr1
~~~

## Input/Output

|File type|File name|I/O|
|:-|:-|:-|
|Overall control data|hecmw_ctrl.dat|I|
|Mesh data|\<ModelName\>.msh|I|
|Analysis control file|\<ModelName\>.cnt|I|
|Mesh partitioning control file|hecmw_part_ctrl.dat|I|
|Log file|\<0\>.log|O|
|Results file|\<ModelName\>.res|O|

## Overall control data
###（hecmw_ctrl.dat）

~~~
!MESH, NAME=part_in, TYPE=HECMW-ENTIRE
 <ModelName>.msh
!MESH, NAME=part_out, TYPE=HECMW-DIST
 <ModelName_p4>
!MESH, NAME=fstrMSH, TYPE=HECMW-DIST
 <ModelName_p4>
!CONTROL, NAME=fstrCNT
 <ModelName>.cnt
!RESULT, NAME=fstrRES, IO=OUT
 <ModelName>.res
~~~

## Mesh partitioning control data
###(hecmw_part_ctrl.dat)

~~~
!PARTITION, TYPE=NODE-BASED, METHOD=PMETIS, DOMAIN=<4>
~~~

## Mesh data

~~~
!HEADER
<TITLE>
!NODE
 NODE_ID, x, y, z
!ELEMENT, TYPE=<341>
 ELEM_ID, node1, node2, node3, ...
!SECTION, TYPE=<SOLID>, EGRP=<EG1>, MATERIAL=<MAT1>
!NGROUP, NGRP=<NG1>
 node1, node2, ...
!SGROUP, SGRP=<SG1>
 elem1, localsurf1, elem2, localsurf2, ...
!EGROUP, EGRP=<EG1>
 elem1, elem2, ...
!CONTACT PAIR, NAME=<CP1>
 <Slave_NodeGroup>, <Master_SurfaceGroup>
!AMPLITUDE, NAME=<AMP1>, VALUE=<RELATIVE|ABSOLUTE>
 value1, time1, value2, time2, ...
!INITIAL CONDITION, TYPE=TEMPERATURE
 NODE_ID, value
!EQUATION
 <number of terms>, <right-hand value>
 NODE_ID, <dof>, <coefficient>, ...
!ZERO
!END
~~~

## Analysis control file (common)

~~~
!VERSION
 3.7
!WRITE, VISUAL, FREQUENCY=<output interval>
!WRITE, RESULT, FREQUENCY=<output interval>
!OUTPUT_VIS
 <Name of Output variable>, <ON|OFF>
!OUTPUT_RES
 <Name of Output variable>, <ON|OFF>
!RESTART, FREQUENCY=<output interval>
!END
~~~

|Variable name|Physical value|Target|
|:-|:-|:-|
|DISP|displacement|VIS,RES|
|ROT|rotation|VIS,RES|
|REACTION|nodal reactive force|VIS,RES|
|NSTRAIN|nodal strain|VIS,RES|
|NSTRESS|nodal stress|VIS,RES|
|NMISES|nodal mises stress|VIS,RES|
|ESTRAIN|elemental strain|RES|
|ESTRESS|elemental stress|RES|
|EMISES|elemental mises stress|RES|
|ISTRAIN|integration point strain|RES|
|ISTRESS|integration point stress|RES|
|PL_ISTRAIN|integration point plastic strain|RES|
|VEL|velocity|VIS,RES|
|ACC|acceleration|VIS,RES|

## Analysis control file (Static analysis)

~~~
!SOLUTION, TYPE=<STATIC|NLSTATIC>
!STATIC
!BOUNDARY,GRPID=<1>
 NODE_ID, <Start of DOF>, <End of DOF>, <Constraint value>
!CLOAD,GRPID=<1>
 NODE_ID, <DOF>, <Load value>
!DLOAD,GRPID=<1>
 SGRP, <Load type>, <Load parameter>
!SPRING,GRPID=<1>
 NODE_ID, <Constraint DOF>, <Spring constant>
~~~

## Analysis control file (Contact)

~~~
!CONTACT_ALGO, TYPE=<SLAGRANGE|ALAGRANGE>
!CONTACT, GRPID=<1>, NTOL=<法線方向閾値>, TTOL=<接線方向閾値>, NPENALTY=<法線方向ペナルティ>, TPENALTY=<接線方向ペナルティ>
 <Name of contact pair>, <friction coefficient>, <摩擦のペナルティ剛性>
~~~

## Analysis control file (Heat stress)

~~~
!REFTEMP
 <temperature>
!TEMPERATURE, READRESULT=<Total number of steps>, SSTEP=<Start step>, INTERVAL=<step interval>
~~~

## Analysis control file (Eigenvalue)

~~~
!EIGEN
 <Nuber of eigenvalue>, <allowable value>, <maximum number of iteration>
!BOUNDARY
~~~

## Analysis control file (Heat conduction)

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
!VELOCITY, TYPE=<INITIAL|TRANSIT>, AMP=<NAME>
 Node_ID, <自由度>, <自由度>, <拘束値>
!ACCELERATION, TYPE=<INITIAL|TRANSIT>, AMP=<NAME>
 Node_ID, <自由度>, <自由度>, <拘束値>
~~~

## 解析制御ファイル（時刻歴応答）

~~~
!DYNAMIC, TYPE=NONLINEAR
 <陰解法1|陽解法11>, <時刻歴1>
 <開始時刻>, <終了時刻>, <全ステップ数>, <時間増分>
 <γ>, <β>
 <集中質量|consistent質量2>, 1, <Rm>, <Rk>
 1, <モニタリング節点>, <モニタリング出力間隔>
 <変位>, <速度>, <加速度>, <反力>, <ひずみ>, <応力>
~~~

## 解析制御ファイル（周波数応答）

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
 NODE_ID, <自由度>, <荷重値>
~~~

## 解析ステップ

~~~
!STEP, TYPE=<STATIC|VISCO>, SUBSTEPS=<分割数>, CONVERG=<判定値>
 <時間増分値>, <時間増分終値>
 BOUNDARY, <GRPID>
 LOAD, <GRPID>
 CONTACT, <GRPID>
~~~

| 境界条件種類 | 属するカード |
|:-|:-|
| BOUNDARY | !BOUNDARY, !SPRING |
| LOAD | !CLOAD, !DLOAD, !TEMPERATURE |
| CONTACT | !CONTACT |

## 材料物性値

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

## ソルバー制御

~~~
!SOLVER, METHOD=<CG>, PRECOND=<1>, MPCMETHOD=<3>
 <反復回数>, <前処理繰り返し数>, <クリロフ>, <目標色数>
 <打切り誤差>, <対角成分倍率>, 0.0
~~~

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

## Post-process (Output of AVS format)

~~~
!VISUAL
!output_type=COMPLETE_REORDER_AVS
~~~

## Post-process (Output of BMP format)

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

## Non-linear analysis

| Type of analysis | Related card |
|:-|:-|
| Static analysis | !SOLUTION, TYPE=NLSTATIC<BR>!STEP |
| Dynamic analysis | !DYNAMIC, TYPE=NONLINEAR<BR>!STEP |
| Material nonlinearlity | !MATERIAL<BR>!PLASTIC<BR>!HYPERELASTIC<BR>!VISCOELASTIC<BR>!CREEP |

