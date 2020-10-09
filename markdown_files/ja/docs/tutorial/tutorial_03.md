## 非線形静解析 (超弾性その1)

本解析の実施には、`tutorial/03_hyperelastic_cylinder` のデータを用います。

### 解析対象

解析対象は丸棒の1/8モデルで、形状を図4.3.1に、メッシュデータを図4.3.2に示します。

 | 項目       | 内容                    | 備考                             | 参照 |
 |------------|-------------------------|----------------------------------|------| 
 | 解析の種別 | 非線形静解析(超弾性)    | !SOLUTION,TYPE=NLSTATIC          |      |
 | 節点数     | 629                     |                                  |      |
 | 要素数     | 432                     |                                  |      |
 | 要素タイプ | 8節点六面体一次要素     | !ELEMENT,TYPE=361                |      |
 | 材料物性名 | MAT1                    | !MATERIAL,NAME=MAT1              |      |
 | 材料性質   | HYPERELASTIC            | !HYPERELASTIC,TYPE=MOONEY-RIVLIN |      |
 | 境界条件   | 拘束, 強制変位          |                                  |      |
 | 行列解法   | CG/SSOR                 | !SOLVER,METHOD=CG,PRECOND=1      |      |

![丸棒(1/8モデル)の形状](./media/tutorial03_01.png){.center width="350px"}
<div style="text-align: center;">
図4.3.1　丸棒(1/8モデル)の形状
</div>

![丸棒(1/8モデル)のメッシュデータ](./media/tutorial03_02.png){.center width="350px"}
<div style="text-align: center;">
図4.3.2　丸棒(1/8モデル)のメッシュデータ
</div>

### 解析内容

丸棒に軸方向の引張変位を与える応力解析を実施します。
超弾性の材料構成式にはMooney-Rivlinモデルを用います。解析制御データを以下に示します。

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
 LOADS, 3, 3, -7.0
 FIX,   3, 3, 0.0
 XSYMM, 1, 1, 0.0
 YSYMM, 2, 2, 0.0
### STEP
!STEP, SUBSTEPS=5, CONVERG=1.0e-5
 BOUNDARY, 1
### Material
!MATERIAL, NAME=MAT1
!HYPERELASTIC, TYPE=MOONEY-RIVLIN
 0.1486, 0.4849, 0.0789
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

### 解析結果

5サブステップ目の解析結果について、ミーゼス応力のコンターを付加した変形図をREVOCAP_PrePostで作成して図4.3.3に示します。
また、解析結果の数値データとして、解析結果ログファイルの一部を以下に示します。

![変形およびミーゼス応力の解析結果](./media/tutorial03_03.png){.center width="350px"}
<div style="text-align: center;">
図4.3.3　変形およびミーゼス応力の解析結果
</div>

#### `0.log`

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
...
```

