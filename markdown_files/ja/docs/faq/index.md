---
title: FrontISTR FAQ
date: 2020-10-05
author: FrontISTR Commons
---

<!-- 表記は FrontISTR ver. 0.0 で統一します -->
# FrontISTR FAQ

- [PDF](faq_ja.pdf)

## 一般的な質問

### FrontISTRとは何ですか?

FrontISTR(フロントアイスター)とは、WindowsやLinuxのPCクラスタはもとより、京などの超並列スパコンにも対応可能な、オープンソースの構造解析ソルバーです。

### FrontISTRには、メッシュ作成ツールや、結果の可視化ツールも含まれていますか?

含まれていません。
メッシュ作成ツールや結果の可視化には別途対応したプリポストツールが必要です。

### 対応しているプリポストツールは何がありますか?

オープンソースのツールでは

- [REVOCAP_PrePost(Version 4.6まで)](https://www.frontistr.com/download/)
- [EasyISTR](http://opencae.gifu-nct.ac.jp/pukiwiki/index.php?AboutEasyISTR)

などがあります。

商用のソフトでは

- A
- B
- C

などが対応しています。

### FrontISTRはどこからダウンロード出来ますか?

[FrontISTR研究会](https://www.frontistr.com/)の[Download](https://www.frontistr.com/download/)からダウンロードしてください。

### FrontISTRのライセンスは何ですか?

ライセンスは[MITライセンス](https://gitlab.com/FrontISTR-Commons/FrontISTR/-/blob/master/License.txt)です。

### FrontISTRのマニュアルは何処にありますか?

[FrontISTR マニュアル](https://frontistr-commons.gitlab.io/FrontISTR_manual/ja/)を参照してください。

## 解析機能についての質問

### 6面体1次要素の定式化は、デフォルトで何が使用されますか?

デフォルトでは、6面体1次要素は

 - 線形解析   非適合要素
 - 非線形解析 B-bar要素(version 5.0a以前)
 - 非線形解析 F-bar要素(version 5.0b以降)

です。[解析制御データ !SECTION(1-11)](/analysis/analysis_05.html#section-1-11)参照

