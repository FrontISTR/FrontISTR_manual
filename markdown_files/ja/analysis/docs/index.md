<!-- 表記は FrontISTR ver. 0.0 で統一します -->
# FrontISTR 解析マニュアル

本ソフトウェアは文部科学省次世代ＩＴ基盤構築のための研究開発「イノベーション基盤シミュレーションソフトウェアの研究開発」プロジェクトによる成果をシーズとして，継続的に開発されている並列有限要素解析プログラムです。
本ソフトウェアを無償または営利目的でご使用になる場合、「MITライセンス」をご了承頂くことが前提となります。

<img src="./image/FrontISTR_logo.png" width="350px">

| 項目 | 説明 |
|:---------:|:---------|
| ソフトウェア名称 | FrontISTR |
| バージョン | 5.0 |
| ライセンス形態 | MIT License |
| 問い合わせ先 | FrontISTR研究会<br> 〒277-8563 千葉県柏市柏の葉5-1-5<br> 東京大学大学院新領域創成科学研究科 奥田研究室（気付）<br> E-mail：fstr_seminar@multi.k.u-tokyo.ac.jp |

## マニュアルリスト

  - [FrontISTR ver. 5.0 ユーザーマニュアル]()
  - [FrontISTR ver. 5.0 インストールマニュアル]()
  - [FrontISTR ver. 5.0 理論マニュアル]()
  - [FrontISTR ver. 5.0 解析マニュアル]()
  - [FrontISTR ver. 5.0 チュートリアルマニュアル]()

<!-- ここまでテンプレート -->
---

本マニュアルでは、大規模並列FEM非線形構造解析プログラムFrontISTRのデータ入力方法と実行方法を説明します。

## 本マニュアルの記載内容

- [解析の流れ](./analysis_01)
- [入力ファイル](./analysis_01)
    - [全体制御データ (hecmw_ctrl.dat)](./analysis_02)
    - [領域分割制御データ (hecmw_ctrl_part.dat)](./analysis_03)
    - [メッシュデータ (mesh.msh)](./analysis_04)
    - [解析制御データ (mesh.cnt)](./analysis_05)
    - [可視化制御データ (hecmw_vis.ini)](./analysis_05)
- [出力ファイル](./analysis_01)
    - [ログデータ](./analysis_05)
    - [リザルトデータ (mesh.res)](./analysis_05)
    - [リスタートデータ (mesh.restart)](./analysis_05)
    - [可視化データ](./analysis_05)
- [要素リスト](./analysis_06)
- [材料リスト](./analysis_07)
- [ユーザーサブルーチン](./analysis_08)
