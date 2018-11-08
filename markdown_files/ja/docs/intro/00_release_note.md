# リリースノート

## Ver.5.0における更新内容
FrontISTR Ver.5.0において、以下に示す機能が追加された。
- ...

## Ver.3.8における更新内容
FrontISTR Ver.3.8において、以下に示す機能が追加された。

- 解析機能・アルゴリズム
    - 回転変位の境界条件の実装
    - トルクの境界条件の実装
    - 3次元線形静解析の反力計算の計算方法の変更
    - 非圧縮性流体解析機能の導入（RC版）
- 要素
    - 非圧縮性流体解析用の四面体要素（3414要素）を追加
    - （積層）シェル要素の応力値計算部分の修正
- 材料
    - メッシュファイル内の材料定義部分の読み込みを高速化
    - 解析制御ファイル内の材料定義部分の読み込みを高速化
    - 非圧縮性流体解析用の材料物性を追加
- 線形ソルバー
    - MUMPS使用時のログ出力方法を細分化
    - 4×4 CGソルバーの修正
    - 6x6 CGソルバーの修正
- メッシュ・リファイン関連
    - 大規模モデルをリファインした際の不具合を修正
- また、以下に示す修正が行われた
    - 非線形静解析の結果を引き継いだ固有値解析（!STATICEIGEN）での要素定義の不具合を修正
    - 接触解析時のscan_contact_state関数のメモリリーク
    - コンパイル時にwarningが表示される部分を修正
    - プログラムコード先頭のヘッダを変更
    - LICENSEファイルの変更

## Ver.3.7における更新内容
FrontISTR Ver.3.7において、以下に示す機能が追加された。

- 入出力
    - 6自由度ソルバにおける応力値計算部分の修正
    - 主応力・主ひずみの算出機能の追加
    - 積層シェル要素の出力部分の修正
    - 解析ファイル (cntファイル)のINCLUDE機能追加
    - !EQUATIONのMPC入力にLINKカードを追加
    - UCD出力にMaterial ID (要素形状ID)を出力するよう変更
    - !SOLVERにSTEPLOG機能の追加
    - 行列の非零要素プロット機能の追加
    - !SUBDIRフラグのMONITOR出力機能の追加
    - 刺激係数と有効質量の出力機能の追加 (固有値解析)
    - 大規模メッシュへの対応
    - !AMPLITUDEの入力時にTYPE=TIMEVALUEを追加
    - Abaqus用インプット関数の改良
    - 解析ファイル (cntファイル)に設定されたMATERIAL関数の名前検索部分の修正
    - Logfileアウトプットの修正
    - Global summaryの修正
- リファイナ
    - 接触問題のリファイン機能を追加
    - リファイン時のUCD出力の修正
- 解析
    - バネ境界条件機能の修正
    - 接触解析の接触ペア探索の高速化 (アルゴリズムの更新、OpenMP並列化を実施)
- 要素
    - TLOAD_C3D8IC機能の追加 (熱応力荷重の付加)
    - トラス要素 (301要素)と4面体1次要素 (341要素)を並列接触解析への対応
- 材料
    - OpenMP有効時の弾塑性材料の計算に関する不具合の修正
- 機能
    - flushテストの修正
- 線形ソルバ
    - ISAINV前処理・ IRIF前処理の追加
    - Intel PARDISOインターフェースの追加
    - OpenMP atomic記述子に関する部分の不具合修正
    - !SOLVERのUSEJADカードの不具合修正
    - METIS ver. 5.0への対応
    - hecmw_solver_direct ルーチンの修正
    - OpenMP=1の場合のSSOR前処理の不具合修正
    - ML前処理の剛体モードの算出部分の自由度混在要素対応
- 例題・チュートリアル
    - 自由度混在用シェル要素（761要素・781要素）の例題追加
    - バネ境界条件機能の例題追加
    - 付属チュートリアル例題の全てが正しく実行できることを確認
- パーティショナ
    - パーティショナが1領域の分散メッシュを正しく生成するよう修正
- その他軽微な修正
    - fstr_setup_util.f90における初期化忘れの修正
    - intent文の修正

## Ver.3.6における更新内容
FrontISTR Ver.3.6において、以下に示す機能が追加された。

- 入出力
    - ファイル読込の高速化
    - 781シェル要素と761シェル要素を使用した場合の出力変更
    - デバッグ用のメッセージ消去
- リファイナ
    - !EQUATIONの定義で，右辺の定数を設定した場合に，正しくリファインされない不具合を修正
- 解析
    - 周波数応答解析に関する修正
    - !SOLUTION,TYPE=STATICを通る場合の熱応力解析に関する修正
    - !SOLUTION,TYPE=NLSTATICを通る場合の圧力法線方向更新に関する修正
    - 接触剛性マトリックスのサブルーチンgetContactStiffnessの修正
- 要素
    - 要素ループのOpenMP並列化
    - B-bar要素 (ソリッド要素) に関する修正
    - シェル要素に関する修正
    - トラス要素に関する修正
    - シェル，ビーム，トラス，ソリッドが全て混在した場合に発生するメモリ不正の修正
- 材料
    - 直交異方弾性体に関する修正
- 線形ソルバー
    - 行列ダンプ機能の修正
    - 3×3 ILU前処理の省メモリ化
    - 4×4 CGソルバーの追加
    - 6×6 CGソルバーの追加
    - 3×3 CG, GMRESソルバーによる前処理適用後行列の条件数推定（試験的）
    - 3×3 CGソルバーへの発散チェック追加
    - 3×3ソルバー使用時の前処理セットアップ情報の再利用
    - 3×3ソルバー用外部AMG前処理ライブラリ（ML）へのインターフェース（試験的）
    - 3×3ソルバーの行列ベクトル積での通信隠蔽（試験的）
    - 陽的な自由度消去法による多点拘束条件処理
    - 接触解析における反復法ソルバーの利用（試験的）
- パーティショナ関連
    - ファイル入力の高速化
    - ログ出力の機能拡張
    - 分散メッシュ作成ループのOpenMP並列化

## Ver.3.5における更新内容
FrontISTR Ver.3.5において、以下に示す機能が追加された。

- 解析機能関連
    - シェル・梁要素とソリッド要素の混在解析対応（3.7、4.1、6.3(3)参照）
    - シェル要素における直交異方性材料対応（4.2.2(3)参照）
    - 積層シェル対応（4.2.2(3)参照）
    - 大変形解析の際の圧力荷重のFOLLOW機能（7.4.2(14)参照）
    - 梁要素の動解析対応（3.7参照）
    - 動解析における複数節点のモニタリング（7.4.5(1)参照）
    - 動解析における節点応力・節点ひずみのモニタリング（7.4.5(1)参照）
    - 連成解析における入力流体力へのウィンドウ関数の適用（7.4.5(4)参照）
- パーティショナ関連
    - 大幅な高速化
    - Metis Ver.5系列への対応（インストールマニュアル参照）
- メッシュ・リファイン関連
    - 要素タイプ混在モデルのリファイン対応
    - 入力温度データのリファイン情報に基づく補間に対応
- 線形ソルバ関連（7.4.6(1)参照）
    - 前処理におけるマルチカラー処理およびハイブリッド並列対応
    - ベクトル計算機向けオーダリング
    - 自由度３の問題で利用可能な前処理と反復解法の組み合わせの拡大
    - 行列データのダンプ機能
- また、以下に示す修正が行われた
    - シェル要素のDrilling DOFの修正
    - 非線形解析における収束判定の修正
    - 線形動解析のリスタート時の時刻の修正
    - 連成解析時のメッセージ内の節点番号表示の修正
    - ILU前処理の修正
    - 一部のコンパイラによる最適化時の不具合回避