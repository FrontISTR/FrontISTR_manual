## リリースノート

### Ver.5.4における更新内容

- 機能改良
    - issue 141: FLOPS値を出しておく
    - issue 425: 接触解析のテストサンプル追加
    - issue 459: hecmw_mat_conの効率化
- 仕様変更
    - issue 101: Lagrange乗数行列をHEC-MWで定義
    - issue 316: Remove Document(Manual)-CI from FrontISTR's gitlab-ci.
    - issue 421: 接触解析の行列構造体に常時 conMAT を利用する
    - issue 422: fstr_matrix_con_contactのリファクタリング
    - issue 423: fstrMAT を rename しミドルウェア側に移動する
    - issue 424: FrontISTR 側の solve_LINEQ_contact 系ソルバのリファクタリング
    - issue 438: cmake_minimum_requiredの整理
- 不具合修正
    - issue 205: シェル要素の層別結果出力においてmises応力が出力されない
    - issue 338: 座標値に仮数部の有効数字が1桁である浮動小数点数が含まれるとエラー停止する
    - issue 371: Occurrence of division by zero in certain development environments
    - issue 378: SURF-SURF接触がある動解析のリスタート入出力の不具合
    - issue 381: チュートリアル 04_hyperelastic_spring が収束しない問題
    - issue 397: クリープNorton則の温度（2つ以上の温度）依存性物性値の読み込みエラー
    - issue 409: 接触モデルのパーティショニング時のSIGSEGV
    - issue 411: [bug] 並列計算における接触解析機能について（問い合わせ1220302050の続き） (1562686629)
    - issue 427: 接触ありモデルの領域分割に失敗する
    - issue 428: Rank 0よりもホスト名が長いRankがある場合にエラー
    - issue 429: Lagrange乗数法と自由度消去法のMPC拘束を並列解析で併用すると、 各々の行列サイズ変更処理（hecmw_mpc_mat_ass等）が整合せず、解析失敗
    - issue 439: 非定常熱伝導解析の複数ステップの解析で、totaltimeの進み方がおかしい
    - issue 457: 接触ペアの名前解決の不具合
    - issue 458: hecmw_solver_las_22でhecmw_update_3_Rではなく2_Rを呼ばなければならない
    - issue 460: 逐次接触解析で内部直接法とDIRECTmklが使えない
    
### Ver.5.3における更新内容
- 機能改良
    - issue 103: Allow contact parameters to be specified as input data
    - issue 266: Enable MKL for windows executables.
    - issue 339: Enable trilinos(AMG) amesos in windows binary.
    - issue 364: Multi-arch CI
    - issue 388: Illegal memory access when monitoring non-existent node with global id 0
    - issue 387: Visualization of nodal and element numbers
    - issue 384: Ability to specify parameter beta in heat transfer analysis
- 仕様変更
    - issue 352: Fix macro naming notation errors.
    - issue 358: Rethinking the default settings of AMG preprocessing by ML
    - issue 359: Output messages when Amesos and MUMPS are not available in ML.
    - issue 360: Simplify ML configuration log.
- 不具合修正
    - issue 125: Eigenvalues of 0 do not appear in constraint-free eigenvalue analysis
    - issue 301: Discussion on how to handle serial version of MUMPS with FrontISTR cmake.
    - issue 329: In iterative contact analysis with friction, convergence behavior of NR method is significantly different between sequential and distributed runs.
    - issue 333: mumps solver does not work on Windows x64 executable (MPI ver.)
    - issue 336: Binary VTK output by windows binary cannot be read by paraview.
    - issue 340: Deviation of calculation results of eigenvalue analysis due to differences in usage environment.
    - issue 343: The program crashes when a large number of contact points (about several thousand) are judged to be in contact.
    - issue 350: When building serial version, if MKL is enabled, clustermkl is also enabled, resulting in link error.
    - issue 351: When building serial version with setup.sh, MKL is not enabled even if --with-mkl is specified.
    - issue 363: Ctrl+x does not work when starting FrontISTR with docker run.
    - issue 365: Refiner in binary distribution (Docker/Windows binary) has a bug.
    - issue 366: Error when specifying contact pressure visualization file output for models with no contact.
    - issue 368: Enable parallel make when using setup.sh
    - issue 369: Avoid error when element output is specified for !OUTPUT_VIS
    - issue 376: Name resolution bug in setting up orthotropic anisotropic material
    - issue 377: The default setting of DWITH_MPI option in cmake should be ON, but it is OFF.
    - issue 380: Regarding the creation of hecmw_vis.ini, errors due to timing inconsistencies between MPI processes
    
### Ver.5.2における更新内容

- 機能改良
    - issue 079: 単位面積あたりの接触法線力、摩擦力出力
    - issue 142: hecmw_part1 command line argumentで num of partを指定する
    - issue 218: 計算結果（res）ファイルフォーマットをドキュメントに記載する
    - issue 298: DockerコンテナのCluster Paradisoの対応
    - issue 303: 内部直接法でMetisのオーダリングを利用可能にする
    - issue 305: 内部直接法でRCMオーダリングを利用可能にする
    - issue 313: JAD SpMV is not OpenMP parallelized
    - issue 314: BLAS Lv.1 operations are not OpenMP parallelized
    - issue 315: CG法に並列化したBLAS Lv1関数を適用する
    - issue 324: 異方性超弾性
- 仕様変更
    - issue 239: 標準出力の build date と execute date の形式が違う。
    - issue 262: 接触・MPCで作られる内部パッチ要素の結果出力を除外する
    - issue 274: INFINITEをINFINITESIMALに修正する
    - issue 302: 内部直接法のリファクタリング
    - issue 307: Windowsバイナリ作成のためのmingwビルドイメージの更新
    - issue 309: MUMPSがあってscalapackがないときにFATAL errorはやりすぎ
    - issue 326: 不要もしくは重要でないバージョン表記は消す
- 不具合修正
    - issue 045: 内部直接法の動作が変？
    - issue 111: 境界条件のAMPLITUDEの指定が、AMP= 以外でもできてしまう
    - issue 280: Trilinos-13.0.0を用いるとFrontISTR-5.1もしくはmasterブランチでコンパイル出来ない
    - issue 290: 実行時のバージョン番号が実際のバージョンと異なる
    - issue 292: README.md のマニュアルへのリンクが更新されていなかった
    - issue 300: !DLOADに複数の面グループを設定した場合のバグ
    - issue 304: RCMオーダリングの修正
    - issue 306: msmpi.dllが同梱されていない。
    - issue 327: DEBUGビルドが通らない不具合の修正
    - issue 328: SURF-SURF接触定義時にISTRESS/ISTRAIN出力を指定するとエラーが発生する
    - issue 332: setup.shでビルドできなくなっていた


### Ver.5.1.1における更新内容

- 機能改良
    - issue 108: 時系列のVTK出力時に時刻情報を合わせて出力したい
- 仕様変更
    - issue 156: testの誤差判定を相対的にする。
    - issue 237: add cmake rules for new MUMPS version
    - issue 247: autoinc example の修正
    - issue 282: Dockerコンテナ提供FrontISTRでMPI並列するとエラーメッセージが大量にでる。
    - issue 284: Gitlab CI/CD の DAG機能に対応する。
    - issue 288: Intel MKLをcmakeでfindできるようになった。
- 不具合修正
    - issue 026: ELEMCHECK Sparsity Overflow
    - issue 052: コンパイル時のワーニングつぶし(ongoing)
    - issue 244: Compiling error by gfortran-10
    - issue 245: bug : unable to compile in setup.sh
    - issue 259: MPCで自由度消去を用いる場合の不具合修正
    - issue 278: 細かい不具合の修正
    - issue 279: cmakeでmklが見つからない
    - issue 281: スペルミス
    - issue 283: Fbar要素の微修正
    - issue 285: 741 Shellでの固有値解析で落ちることがある。
    - issue 287: macのbashでのテストが実行できない問題
    - issue 289: test_hybridでheat/exU2が数値誤差により時々failする

### Ver.5.1における更新内容

- 機能改良
    - issue 207: ビルド時の日付を出力する機能追加
    - issue 204: 非定常熱伝導解析のサンプル追加
    - issue 195: リファイナ関係のデバッグ出力
    - issue 194: MPCを含むモデルをリファインした際に陽的自由度消去が利用可能に
    - issue 183: ML のインターフェースを整理・拡張
    - issue 169: linux バイナリ配布
    - issue 143: conrod モデルを tutorial に追加
    - issue 140: CI による Manuals 生成
    - issue 136: OpenMP thread 並列および MPI 並列へのテスト対応
    - issue 132: OpenMP thread 並列および MPI 並列使⽤時の使用コア数出力
    - issue 067: 弾塑性の consistent 接線剛性実装（Misesのみ）
    - issue 036: ⾃動時間増分の熱伝導結果ファイルの読み込みにおける時刻情報を用いた補間
- 外部仕様変更
    - issue 131: FrontISTR starter の削除
- 内部仕様変更
    - issue 158: 接触⾯ペアを面-面で入力した際に内部で自動生成される節点グループの命名規則
    - issue 122: テスト機能の拡充
    - issue 121: gitlab-ci の 修正（テスト機能の拡充）
    - issue 107: HCEMW を利⽤した FILM、RADIATE 関数の実装
    - issue 056: 重複コード削除：fistr1/src/lib/physics/ElasticNeoHooke.f90
    - issue 046: プログラマ情報の確認
    - issue 044: 出⼒機能の統合（静的と動的）
    - issue 037: res_bin_io.inc と res_txt_io.inc の拡張⼦変更
- 不具合修正
    - issue 203: 611 梁要素の不具合修正とテスト例題追加
    - issue 185: 固有値解析の結果ファイル(.res) への書き出し不具合修正
    - issue 184: 線形動解析（陰解法）の線形解析対応
    - issue 181: 541 インターフェース要素使⽤時の質量⾏列の不具合修正
    - issue 159: 内部変数の可読性向上（DISTCLR_CONT など）
    - issue 123: 熱伝導解析への ML 前処理適⽤時の不具合修正
    - issue 114: VTK ファイルの出⼒にサブディレクトリを設定した時の不具合修正
    - issue 113: 出⼒に関するいくつかの不具合修正
    - issue 055: サブルーチン fstr_solve_dynamic_nlimplicit の変数 iexit の初期化
    - issue 054: 関数 read_user_matl で使⽤している fstr_ctrl_get_data_array_ex の引数修正
    - issue 053: 動的非線形並列解析でメモリリークの修正（SOR 前処理との兼ね合い）
    - issue 026: !ELEMCHECK の Sparsity 値の修正


### Ver.5.0における更新内容

FrontISTR Ver.5.0において、以下に示す機能が追加された。

- 解析機能・アルゴリズム
    - 接触解析機能の改善：探索の高速化、リファイン対応、ほか多数の不具合修正含む
    - シェル要素の質量マトリックス計算
    - 動的接触陽解法の追加
    - Lagrange乗数法接触におけるfollower force更新タイミングをサブステップ冒頭からNR反復内部に移動（接触なしNR法との仕様統一）
- 入出力
    - 要素主ひずみ/主応力の出力
    - resultファイルへのグローバル変数出力の追加：時刻、固有値など
    - 解析制御ファイルでの!INITIAL指定
- 線形ソルバー
    - intel MKL pardiso直接法ソルバI/Fの非接触解析および分散並列対応
- 起動方法
    - openMP並列数指定オプション –t の追加
- チュートリアル
    - Tutorial 01の荷重量を変更（線形解析としては大きすぎる変形）
- 不具合修正
    - 動解析陰解法における変数未初期化
    - SSOR前処理のメモリリーク
    - fstr_make_dynamic_resultでのsegmentation fault
    - いくつかのtest exampleがfailする問題
    - 熱伝導解析の自動時間増分
    - 熱伝導解析のopenmp並列対応
    - 反復法前処理のメモリ解放漏れ
    - AMG前処理（MLパッケージ）で不要なML_Set_Symmetrizeの呼び出し
    - !SUBDIRがthread-safeでない問題
    - 33シェルと33梁の混在計算ができない問題

### Ver.3.8における更新内容

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

### Ver.3.7における更新内容

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

### Ver.3.6における更新内容

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

### Ver.3.5における更新内容

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

