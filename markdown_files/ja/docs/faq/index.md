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

FrontISTR Commons正会員限定で提供しているツールは

- [Advance REVOCAP_PrePost for FrontISTR](https://www.frontistr.com/download/)
※サポートはありません。

があります。

商用のソフトでは

- 

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

です。[解析制御データ !SECTION(1-11)](../analysis/analysis_05.html#section-1-11)参照

### 直接法と反復法で、多点拘束(MPC)時の計算結果が違いますが、なぜですか?

`SOLVER`によって、多点拘束条件の処理手法のデフォルトが変わります。

- 直接法(DIRECTmkl, MUMPS)を指定した場合、ペナルティ法
- 反復法(CG法、GMRES法等)を指定した場合、陽的自由度消去法

ペナルティ法は、10^{-4}以下の誤差が生じます。
陽的自由度消去法は、拘束条件が厳密に満足されるため誤差は生じません。ただし、ペナルティ法に比べ計算負荷が高くなります。

`MPCMETHOD`パラメータで変更することができます(※MPC-CG方法メンテナンスされていないため非推奨) 。
[ソルバー制御データ 6-1 !SOLVER](https://manual.frontistr.com/ja/analysis/analysis_05.html#6-1-solver) 参照

