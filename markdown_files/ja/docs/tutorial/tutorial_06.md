## 非線形静解析 (弾塑性その2)

本解析の実施には、`tutorial/06_plastic_can` のデータを用います。

### 解析対象

解析対象は容器の1/2モデルで、形状を図4.6.1に、メッシュデータを図4.6.2に示します。

 | 項目       | 内容                 | 備考                                   | 参照 |
 |------------|----------------------|----------------------------------------|------| 
 | 解析の種別 | 非線形静解析(弾塑性) | !SOLUTION,TYPE=NLSTATIC                |      |
 | 節点数     | 14,119               |                                        |      |
 | 要素数     | 7,236                |                                        |      |
 | 要素タイプ | 10節点四面体二次要素 | !ELEMENT,TYPE=342                      |      |
 | 材料物性名 | M1                   | !MATERIAL,NAME=M1                      |      |
 | 材料性質   | ELASTIC PLASTIC      | !ELASTIC !PLASTIC,YIELD=DRACKER-PRAGER |      |
 | 境界条件   | 拘束, 分布荷重       | !DLOAD                                 |      |
 | 行列解法   | CG/SSOR              | !SOLVER,METHOD=CG,PRECOND=1            |      |

![容器の形状](./media/tutorial06_01.png){.center width="350px"}
<div style="text-align: center;">
図4.6.1　容器の形状
</div>

![容器のメッシュデータ](./media/tutorial06_02.png){.center width="350px"}
<div style="text-align: center;">
図4.6.2　容器のメッシュデータ
</div>

### 解析内容

図4.6.1に示す拘束面の変位を拘束し、容器内部を強制面とし分布荷重を負荷する応力解析を実施します。
降伏関数にはDrucker-Pragerモデルを用います。解析制御データを以下に示します。

#### 解析制御データ `can.cnt`

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
 BND0, 3, 3, 0.000000
!BOUNDARY, GRPID=1
 BND1, 1, 1, 0.000000
 BND1, 2, 2, 0.000000
 BND1, 3, 3, 0.000000
!DLOAD, GRPID=1
 DL0, S, 1.0
!DLOAD, GRPID=1
 DL1, S, 1.0
!DLOAD, GRPID=1
 DL2, S, 0.5
### STEP
!STEP, SUBSTEPS=10, CONVERG=1.0e-5
 BOUNDARY, 1
 LOAD, 1
### Material
!MATERIAL, NAME=M1
!ELASTIC
 24000.0, 0.2
!PLASTIC, YIELD=DRUCKER-PRAGER
 500.0, 20.0, 0.0
### Solver Setting
!SOLVER,METHOD=CG,PRECOND=1,ITERLOG=NO,TIMELOG=YES
 20000, 1
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
$ cd FrontISTR/tutorial/06_plastic_can
$ fistr1 -t 4
(4スレッドで実行)
```

### 解析結果

10サブステップ目の解析結果について、ミーゼス応力のコンターを付加した変形図をREVOCAP_PrePostで作成して図4.6.3に示します。
変形倍率を30としています。また、解析結果の数値データとして、解析結果ログファイルの一部を以下に示します。

![変形およびミーゼス応力の解析結果](./media/tutorial06_03.png){.center width="350px"}
<div style="text-align: center;">
図4.6.3　変形およびミーゼス応力の解析結果
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

