##  熱伝導解析

本解析の実施には、`tutorial/16_heat_block` のデータを用います。

### 解析対象

解析対象は穴あきブロックで、形状を図4.16.1に、メッシュデータを図4.16.2に示します。
メッシュには六面体1次要素を用い、メッシュ規模は要素数32,160、節点数37,386です。

![穴あきブロックの形状](./media/tutorial16_01.png){.center width="350px"}
<div style="text-align: center;">
図4.16.1　穴あきブロックの形状
</div>

![穴あきブロックのメッシュデータ](./media/tutorial16_02.png){.center width="350px"}
<div style="text-align: center;">
図4.16.2　穴あきブロックのメッシュデータ
</div>

### 解析内容

解析対象の円筒状内面に熱源を与える定常熱伝導解析を実施します。解析制御データを以下に示します。

### 解析結果

温度のコンター図をREVOCAP_PrePostで作成して図4.16.3に示します。また、解析結果の数値データとして、解析結果ログファイルの一部を以下に示します。

![温度の解析結果](./media/tutorial16_03.png){.center width="350px"}
<div style="text-align: center;">
図4.16.3　温度の解析結果
</div>


