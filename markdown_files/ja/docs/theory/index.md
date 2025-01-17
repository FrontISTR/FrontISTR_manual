---
title: FrontISTR 理論マニュアル
date: \today
author: FrontISTR Commons
---
<!-- 表記は FrontISTR ver. 0.0 で統一します -->
# FrontISTR 理論マニュアル

<figure markdown>
  [![FrontISTR](../image/FrontISTR_logo.png){width="350"}](https://www.frontistr.com)
</figure>

本ソフトウェアは文部科学省次世代IT基盤構築のための研究開発「イノベーション基盤シミュレーションソフトウェアの研究開発」プロジェクトによる成果をシーズとして，継続的に開発されている並列有限要素解析プログラムです。
本ソフトウェアを無償または営利目的でご使用になる場合、「MITライセンス」をご了承頂くことが前提となります。

| 項目             | 説明                                                            |
|------------------|-----------------------------------------------------------------|
| ソフトウェア名称 | FrontISTR                                                       |
| バージョン       | 5.6                                                             |
| ライセンス形態   | MIT License                                                     |
| 問い合わせ先     | 一般社団法人 FrontISTR Commons<br>東京都文京区弥生二丁目11番16号<br>(東京大学大学院工学系研究科 総合研究機構内)<br>E-mail：support@frontistr.org |

## マニュアルリスト

- [イントロダクション](../intro/index.md)
- [インストールマニュアル](../install/index.md)
- [理論マニュアル](../theory/index.md)
- [解析マニュアル](../analysis/index.md)
- [チュートリアル](../tutorial/index.md)
- [FAQ](../faq/index.md)

<!-- ここまでテンプレート -->

本マニュアルでは、大規模並列FEM非線形構造解析プログラムFrontISTRで用いられる、有限要素法（Finite Element Method）による解析手法について説明します。

固体の応力解析手法については、まず微小変形線形弾性静解析手法について示し、引き続き大変形問題を扱う際に必要となる幾何学的非線形解析手法、弾塑性解析手法について示します。
さらにFEMによる応力解析の結果を利用して得られる破壊力学パラメータを評価する方法についてまとめたものを示します。
次に、固有値解析および熱伝導解析手法について示します。

## 本マニュアルの記載内容

- [PDF](theory_ja.pdf)

- 静的解析
    - [微小変形線形弾性静解析](theory_01.md)
    - [非線形静解析手法](theory_02.md)
- 動的解析
    - [動的解析手法](theory_03.md)
    - [固有値解析](theory_05.md)
    - [周波数応答解析](theory_06.md)
- [熱伝導解析](theory_04.md)
- [参考文献](theory_07.md)


