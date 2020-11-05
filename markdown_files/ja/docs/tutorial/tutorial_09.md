## 接触解析 (その1)

本解析の実施には、`tutorial/09_contact_hertz` のデータを用います。

### 解析対象

解析はHertz接触問題で、解析対象の形状を図4.9.1に、メッシュデータを図4.9.2に示します。

 | 項目       | 内容                      | 備考                              | 参照  |
 |------------|---------------------------|-----------------------------------|-------|
 | 解析の種別 | 非線形静解析(弾塑性,接触) | !SOLUTION,TYPE=NLSTATIC  !CONTACT |       |
 | 節点数     | 408                       |                                   |       |
 | 要素数     | 168                       |                                   |       |
 | 要素タイプ | 8節点六面体一次要素       | !ELEMENT,TYPE=361                 |       |
 | 材料物性名 | MAT1                      | !MATERIAL,NAME=MAT1               |       |
 | 材料性質   | ELASTIC                   | !ELASTIC                          |       |
 | 境界条件   | 拘束, 強制変位            |                                   |       |
 | 行列解法   | CG/SSOR                   | !SOLVER,METHOD=CG,PRECOND=1       |       |

![解析対象の形状](./media/tutorial09_01.png){.center width="350px"}
<div style="text-align: center;">
図4.9.1　解析対象の形状
</div>

![解析対象のメッシュデータ](./media/tutorial09_02.png){.center width="350px"}
<div style="text-align: center;">
図4.9.2　解析対象のメッシュデータ
</div>

### 解析内容

円板の1/4モデルの上面に圧縮方向の強制変位を与える接触解析を拡張ラグランジュ乗数法で実施します。解析制御データを以下に示します。

#### 解析制御データ `cgs3.cnt`

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
 ALL, 3, 3, 0.0
 BOTTOM, 2, 2, 0.0
 CENTER, 1, 1, 0.0
 UPPER,  2, 2, -0.306
!CONTACT_ALGO, TYPE=ALAGRANGE
!CONTACT, GRPID=1
 CP1, 0.0
### STEP
!STEP, SUBSTEPS=5, CONVERG=1.0e-5
 BOUNDARY, 1
 CONTACT,  1
### Material
!MATERIAL, NAME=MAT1
!ELASTIC
 1100.0, 0.0
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=YES,TIMELOG=YES
 1000, 1
 1.0e-10, 1.0, 0.0
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
$ cd FrontISTR/tutorial/09_contact_hertz
$ fistr1 -t 4
(4スレッドで実行)
```

### 解析結果

5サブステップ目の解析結果について、y方向変位のコンターを付加した変形図をREVOCAP_PrePostで作成して図4.9.3に示します。また、解析結果の数値データとして、解析結果ログファイルの一部を以下に示します。

![変形およびy方向変位の解析結果](./media/tutorial09_03.png){.center width="350px"}
<div style="text-align: center;">
図4.9.3　変形およびy方向変位の解析結果
</div>

### 解析結果ログ `0.log`

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

