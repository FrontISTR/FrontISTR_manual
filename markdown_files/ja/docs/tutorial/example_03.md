## 固有値解析用実モデル例題

### 解析モデル

固有値解析を対象とした実モデル検証例題の一覧を表9.3.1に示す。
また、これらのうち、EX07（タービンローダ）およびEX08（スプリング）のモデル形状を図9.3.1、図9.3.2に示す。
そのほかのモデル形状は検証内容が一致する弾性静解析用検証例題と同じ形状であり、すでに示してある。
なお、要素タイプ731および741の例題を実行するには、別途直接法ソルバーが必要である。

<div style="text-align: center;">
表 9.3.1　固有値解析用実モデル検証例題
</div>

| ケース名 | 要素タイプ | 検証モデル           | 節点数  | 自由度数 |
|:--|:--|:--|:--|:--|
| EX06     | 342        | タービンブレード     | 10,095  | 30,285 |
| EX07     | 361        | タービンロータ       | 127,440 | 382,320 |
| EX08     | 342        | スプリング           | 78,771  | 236,313 |
| EX09     | 741        | 円筒シェル           | 10,100  | 60,600 |
| EX10A    | 731        | ワイングラス(coarse) | 7,240   | 43,440 |
| EX10B    | 731        | ワイングラス(midium) | 48,803  | 292,818 |

<div style="text-align: center;">
<img src="./media/example03_01.png" width="350px"><br>
図 9.3.1　タービンロータ（EX07）
</div>

<div style="text-align: center;">
<img src="./media/example03_02.png" width="350px"><br>
図 9.3.2　スプリング（EX08）
</div>

### 解析結果

振動モードおよび固有振動数を以下に示す。

#### EX06 タービンブレード

|  |  |
|--|--|
|<img src="./media/example03_03.png" width="200px">|<img src="./media/example03_04.png" width="200px">|
|(a) モード 1 (1170 kHz)                          |(b) モード 2(3250kHz)                              |
|                                                 |                                                 |
|<img src="./media/example03_05.png" width="200px">|<img src="./media/example03_06.png" width="200px">|
|(c) モード 3(4130kHz)                            |(d) モード 4(4140kHz)                              |
|<img src="./media/example03_07.png" width="200px">| |
|(e) モード 5(8210kHz)                              | |

<div style="text-align: center;">
図 9.3.3　EX06タービンブレード振動モード
</div>

#### EX07 タービンロータ

|  |  |
|--|--|
|<img src="./media/example03_08.png" width="300px">|<img src="./media/example03_09.png" width="300px">|
|(a) モード 1(1067Hz)|(b) モード 2(1072Hz)|
|  |  |
|<img src="./media/example03_10.png" width="300px">|<img src="./media/example03_11.png" width="300px">|
|(c) モード 3(1072Hz)|(d) モード 4(1093Hz)|
|  |  |
|<img src="./media/example03_12.png" width="300px">| |
|(e) モード 5(1093Hz)| |
|  |  |

<div style="text-align: center;">
図 9.3.4　EX07タービンロータ振動モード
</div>

#### EX08スプリング

|  |  |  |
|--|--|--|
|モード 1 (445Hz)                                   |モード 2 (446Hz)                                   |モード 3 (908Hz)                                   |
|<img src="./media/example03_13.png" width="160px">|<img src="./media/example03_14.png" width="160px">|<img src="./media/example03_15.png" width="160px">|
|  |  |
|モード 4 (985Hz)                                   |モード 5 (1819Hz)                                  |   |
|<img src="./media/example03_16.png" width="160px">|<img src="./media/example03_17.png" width="160px">|   |

|  | FrontISTR | NASTRAN |
|--|----------:|--------:|
| 1|445 Hz     |445 Hz    |
| 2|446 Hz     |446 Hz    |
| 3|908 Hz     |908 Hz    |
| 4|985 Hz     |986 Hz    |
| 5|1810 Hz    |1810 Hz   |

<div style="text-align: center;">
図 9.3.5　EX08スプリング振動モード
</div>

#### EX09 円筒シェル

<div style="text-align: center;">
<img src="./media/example03_18.png" width="350px"><br>
(a) モード 1, 2 (109 Hz)
</div>

<div style="text-align: center;">
<img src="./media/example03_19.png" width="350px"><br>
(b) モード 3,4(570Hz)
</div>

<div style="text-align: center;">
<img src="./media/example03_20.png" width="350px"><br>
(c) モード 5(615Hz)
</div>

<div style="text-align: center;">
図 9.3.6　EX09円筒シェル振動モード
</div>

#### EX10Aワイングラス

|   |   |   |
|---|---|---|
|<img src="./media/example03_21.png" width="120px">|<img src="./media/example03_22.png" width="120px">|<img src="./media/example03_23.png" width="120px">|
|(a) モード 1(101Hz)|(b) モード 2(102Hz)|(c) モード 3(354Hz)|
|   |   |   |
|<img src="./media/example03_24.png" width="120px">|<img src="./media/example03_25.png" width="120px">|   |
|(d) モード 4(1335Hz)|(e) モード 5(1336Hz)|   |

<div style="text-align: center;">
図 9.3.7　EX10Aワイングラス振動モード
</div>