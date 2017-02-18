# Documentationについて

## 概要
- ファイルはmarkdown形式で記述
- [mkdocs](http://www.mkdocs.org)でビルドするとDocumentation サイト（英語版・日本語版）を作成することができる

## フォルダ構成

- en: 英語版マニュアル
    - docs
        - install: インストールマニュアル関連ファイル
        - tutorial: チュートリアル関連ファイル
        - user: ユーザーマニュアル関連ファイル
    - mkdocs.yml: mkdocs設定ファイル
- ja: 日本語版マニュアル
    - docs
        - install: インストールマニュアル関連ファイル
        - tutorial: チュートリアル関連ファイル
        - user: ユーザーマニュアル関連ファイル
    - mkdocs.yml: mkdocs設定ファイル

## ビルド方法
[mkdocs](http://www.mkdocs.org)をインストールしておく。英語版・日本語版それぞれでビルドを実行する

1. enまたはjaフォルダに移動  
   ``` $ cd en ```  
   または  
   ``` $ cd ja ```  
2. build実行  
   ``` $ mkdocs build --clean ```
3. siteフォルダが生成されるので、中身一式を取得してupする  

## その他

- 1ファイルにつきレベル1見出しは最大一つ。
- レベル1見出しの内容が大きい場合は更にレベル2見出しでファイルを分割。mkdocs.ymlファイルの設定も、見出し構成に準じて変更する。
- 見出しの形式はatx-header形式（レベル1と2の見出しを# および## とする形式）で統一
- websiteの見栄えを変更したい場合はmkdocs.ymlを使用する
