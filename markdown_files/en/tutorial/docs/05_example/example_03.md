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
<img src="../fig/image312.png" width="350px"><br>
図 9.3.1　タービンロータ（EX07）
</div>

<div style="text-align: center;">
<img src="../fig/image312.png" width="350px"><br>
図 9.3.2　スプリング（EX08）
</div>

### 解析結果

振動モードおよび固有振動数を以下に示す。

#### EX06 タービンブレード

<div style="text-align: center;">
<img src="../fig/image312.png" width="350px"><br>
図 9.3.3　EX06タービンブレード振動モード
</div>

#### EX07 タービンロータ

<div style="text-align: center;">
<img src="../fig/image312.png" width="350px"><br>
図 9.3.4　EX07タービンロータ振動モード
</div>

#### EX08スプリング

<div style="text-align: center;">
<img src="../fig/image312.png" width="350px"><br>
図 9.3.5　EX08スプリング振動モード
</div>

#### EX09 円筒シェル

<div style="text-align: center;">
<img src="../fig/image312.png" width="350px"><br>
図 9.3.6　EX09円筒シェル振動モード
</div>

#### EX10Aワイングラス

<div style="text-align: center;">
<img src="../fig/image312.png" width="350px"><br>
図 9.3.7　EX10Aワイングラス振動モード
</div>
