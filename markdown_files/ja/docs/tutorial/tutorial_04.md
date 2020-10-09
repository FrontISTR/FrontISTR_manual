## 非線形静解析 (超弾性その2)

本解析の実施には、`tutorial/04_hyperelastic_spring` のデータを用います。

### 解析対象

解析対象はスプリングで、形状を図4.4.1に、メッシュデータを図4.4.2に示します。

 | 項目       | 内容                 | 備考                            | 参照 |
 |------------|----------------------|---------------------------------|------|
 | 解析の種別 | 非線形静解析(超弾性) | !SOLUTION,TYPE=NLSTATIC         |      |
 | 節点数     | 78,771               |                                 |      |
 | 要素数     | 46,454               |                                 |      |
 | 要素タイプ | 10節点四面体二次要素 | !ELEMENT,TYPE=342               |      |
 | 材料物性名 | MAT1                 | !MATERIAL,NAME=MAT1             |      |
 | 材料性質   | HYPERELASTIC         | !HYPERELASTIC,TYPE=ARRUDA-BOYCE |      |
 | 境界条件   | 拘束/強制変位        |                                 |      |
 | 行列解法   | CG/SSOR              | !SOLVER,METHOD=CG,PRECOND=1     |      |

![スプリングの形状](./media/tutorial04_01.png){.center width="350px"}
<div style="text-align: center;">
図4.4.1　スプリングの形状
</div>

![スプリングのメッシュデータ](./media/tutorial04_02.png){.center width="350px"}
<div style="text-align: center;">
図4.4.2　スプリングのメッシュデータ
</div>

### 解析内容

図4.4.1に示す拘束面の変位を拘束し、強制面に変位を与える応力解析を実施します。超弾性の材料構成式にはArruda-Boyceモデルを用います。解析制御データを以下に示します。

#### 解析制御データ `spring.cnt`

```
#  Control File for FISTR
## Analysis Control
!VERSION
 3
!SOLUTION, TYPE=NLSTATIC
!WRITE,RESULT
!WRITE,VISUAL
## Solver Control
### Boundary Conditon
!BOUNDARY, GRPID=1
 LOADS, 2, 2, -5.0
 FIX,   1, 3, 0.0
### STEP
!STEP, SUBSTEPS=1, CONVERG=1.0e-5
 BOUNDARY, 1
### Material
!MATERIAL, NAME=MAT1
!HYPERELASTIC, TYPE=ARRUDA-BOYCE
 0.71, 1.7029, 0.1408
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=YES,TIMELOG=YES
 10000, 1
 1.0e-8, 1.0, 0.0
## Post Control
!VISUAL,metod=PSR
!surface_num=1
!surface 1
!output_type=VTK
!END
```

### 解析手順

FrontISTRの実行コマンド `fistr1` を実行します。

```
$ cd FrontISTR/tutorial/04_hyperelastic_spring
$ fistr1 -t 4
(4スレッドで実行)
```

### 解析結果

変位のコンターを付加した変形図をREVOCAP_PrePostで作成して図4.4.3に示します。また、解析結果の数値データとして、解析結果ログファイルの一部を以下に示します。

![変形および変位の解析結果](./media/tutorial04_03.png){.center width="350px"}
<div style="text-align: center;">
図4.4.3　変形および変位の解析結果
</div>

#### 解析結果ログ `0.log`

```
 fstr_setup: OK
#### Result step=     0
 ##### Local Summary @Node    :Max/IdMax/Min/IdMin####
 //U1    0.0000E+00         1  0.0000E+00         1
 //U2    0.0000E+00         1  0.0000E+00         1
 //U3    0.0000E+00         1  0.0000E+00         1
 //E11   0.0000E+00         1  0.0000E+00         1
 //E22   0.0000E+00         1  0.0000E+00         1
 //E33   0.0000E+00         1  0.0000E+00         1
 //E12   0.0000E+00         1  0.0000E+00         1
 //E23   0.0000E+00         1  0.0000E+00         1
 //E31   0.0000E+00         1  0.0000E+00         1
 //S11   0.0000E+00         1  0.0000E+00         1
 //S22   0.0000E+00         1  0.0000E+00         1
 //S33   0.0000E+00         1  0.0000E+00         1
 //S12   0.0000E+00         1  0.0000E+00         1
 //S23   0.0000E+00         1  0.0000E+00         1
 //S31   0.0000E+00         1  0.0000E+00         1
 //SMS   0.0000E+00         1  0.0000E+00         1
 ##### Local Summary @Element :Max/IdMax/Min/IdMin####
 //E11   0.0000E+00         1  0.0000E+00         1
 //E22   0.0000E+00         1  0.0000E+00         1
```
