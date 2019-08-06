## Step control

### About time on analysis

In the analysis of FrontISTR, following definitions of "time" are used:

  - Current time : Total time from start of analysis.
  - Step time : Time from start in each of step.
  - Time span : Duration of time for each step.
  - Relative time : Ratio of "Step time" to Time span".
  - Time increment : Increment from "Current time" to "time at which the equilibrium is attained".

![Definition of terms for analysis time](media/analysis07_01.png){.center width="80%"}

Figure 4.7.1 Definition of terms for analysis time


### Control for static analysis

In static analysis of FrontISTR holds one analysis step  or multiple continuous analysis steps. In each step, analysis gives a  pair of  basic boundary condition that is incremental method analysis.

Below, iteration of analysis is called "step loop", and incremental method is called "sub-step loop".

Incremental control of static analysis could be choose from the following solution.

- Analyze with fixed time increments. If convergence fails, the calculation will be stoped immediately.
- Automatic time increment and cutback. Depending on the convergence, change the increment width. If the calculation fails, recalculate after decreasing the increment width

#### Automatic time increment and cut-back

Flow is automatic time increment and cut-back is as follows(Figure 4.7.2).

![Flow of automatic time increment and cut-back](media/analysis07_02.png){.center width="80%"}
Figure 4.7.2 Flow of automatic time increment and cut-back

図4.7.2　増分制御フロー

フローの骨格は次の通りである。

1. ステップ1から最終ステップN_stepまで、下記2.以降の手続きを繰り返す：
2. 時間増分の基準値dtime_baseを、現在のdtime_baseと前サブステップでの収束状況か
ら定める。初回は初期時間増分initdtを用いる。
1. 実際の時間増分dtimeを、ステップ終了または直近の出力指定時刻までの残り時間とdt
ime_baseの小さい方で定める。
1. 時刻time+dtimeでのつり合い計算を試みる
1. 収束に成功した場合は時刻をdtimeだけ進め、失敗した場合は時刻timeの状態を復元し
て2.に戻る。
1. timeがステップ終了時刻に到達したらステップを終了する

解析途中で下記に挙げるケースに該当した場合、非線形静解析の手続きは失敗と判断され
、エラー終了する。

- timeがステップ終了時刻に到達する前にサブステップ数が上限に到達した場合
- 時間増分の基準値dtime_baseが時間増分下限mindtを下回った場合
- 指定された N_C 回連続して収束に失敗した場合

#### 時間増分基準値dtime_baseの調整

ステップ初回のdtime_baseは、指定された初期時間増分initdtの値に設定される。
それ以外の場合は、前のサブステップの収束状況に応じて次の通り設定される。

1. 収束に失敗した場合（カットバックされた場合）…dtime_baseにカットバック縮小率 R
_C を乗じた値
1. 収束に成功した場合
    1. 減少条件に該当する場合：dtime_baseに減少率 R_S を乗じた値
    2. 減少条件に該当せず、増加条件に該当する場合：dtime_baseに増加率 R_L を乗じ
た値と、時間増分上限maxdtの小さい方
    3. 減少条件にも増加条件にも該当しない場合：dtime_baseは変化しない

#### 増加・減少条件

自動増分調整機能では、増分を増加・減少させる条件を以下の変数を用いて判定する：

- N_max：前サブステップにおけるNewton法反復回数の最大値
- N_sum：前サブステップにおけるNewton法反復回数の合計値（接触反復が無い場合は N_
max に一致）
- N_cont：前サブステップにおける接触反復回数

減少条件は以下の両方が満たされるときである：

- N_max, N_sum,N_contの「いずれか一つ」が、各々の閾値NS_max, NS_sum,NS_contを上
回る
- 上記の状態が、N_S 回以上連続したサブステップで満たされる

増加条件は以下の両方が満たされるときである：

- N_max, N_sum,N_contの「すべて」が、各々の閾値NL_max, NL_sum, NL_cont以内である
- 上記の状態が、N_L 回以上連続したサブステップで満たされる

#### 計算および出力時刻の指定

自動時間増分は収束状況によって増分が変化するため、どの時刻につりあい計算および結
果出力が行われるか事前に決定できない。これが不便である場合に、出力時刻のリストを
与えることによって、希望する時刻におけるつり合い計算および結果出力を実行させるこ
とができる。出力時刻のリストが与えられたステップでは、指定された時刻にて必ず計算
が行われるように、時間増分dtimeの値が調整される。

#### 時間増分の使用方法

本機能に関する設定はすべて解析制御ファイルで行う。
自動増分調整・カットバック機能は!STEPカードでTYPE_INC=AUTOを指定することで有効に
なる。
時間増分の調整関連のパラメータは、!AUTOINC_PARAMを定義の上、!STEP, AUTOINCPARAM
パラメータで各ステップごとに指定する。指定がない場合は!AUTOINC_PARAMのデフォルト
パラメータが使用される。
出力時刻の指定は、!TIME_POINTSで時刻リストの定義の上、!STEP, TIMEPOINTSパラメー
タで各ステップごとに行う。

##### Example

自動増分調整を有効にし、初期時間増分0.01、ステップ時間幅2.5、時間増分下限1E-5、
時間増分上限0.3、最大サブステップ数を200に設定する。自動増分のパラメータセットは
AP1（セット名）、出力時刻1.5, 2.7, 3.9を指定する。

```
    !AUTOINC_PARAM, NAME=AP1
    0.25, 10, 50, 10, 1
    1.25,  1,  1,  1, 2
    0.25,  5
    !TIME_POINTS, TIME=TOTAL, TIME=,NAME=TP1
    1.5
    2.7
    3.9
    !STEP, INC_TYPE=AUTO, SUBSTEPS=200, AUTOINCPARAM=AP1, TIMEPOINTS=TP1
    0.01, 2.5, 1E-5, 0.3
```

### Control of dynamic analysis

本開発コードにおいて、動解析直接時間積分法は１つの解析ステップからなる。また動解
析の増分制御は固定増分のみであり、自動時間増分機能を使用することはできない。


