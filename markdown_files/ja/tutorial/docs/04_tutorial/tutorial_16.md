##  熱伝導解析

本解析の実施には、tutorial/16\_heat\_block のデータを用います。

### 解析対象

解析対象は穴あきブロックで、形状を図4.16.1に、メッシュデータを図4.16.2に示します。
メッシュには六面体1次要素を用い、メッシュ規模は要素数32,160、節点数37,386です。

<div style="text-align: center;">
<img src="../fig/image32.png" width="350px"><br>
図4.16.1　穴あきブロックの形状
</div>

<div style="text-align: center;">
<img src="../fig/image33.png" width="350px"><br>
図4.16.2　穴あきブロックのメッシュデータ
</div>

### 解析内容

解析対象の円筒状内面に熱源を与える定常熱伝導解析を実施します。解析制御データを以下に示します。

### 解析結果

温度のコンター図をREVOCAP\_PrePostで作成して図4.16.3に示します。また、解析結果の数値データとして、解析結果ログファイルの一部を以下に示します。

<div style="text-align: center;">
<img src="../fig/image34.png" width="350px"><br>
図4.16.3　温度の解析結果
</div>
