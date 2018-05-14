<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {
    inlineMath: [['$','$'], ['\\(','\\)']],
    processEscapes: true
  },
  TeX: {
    equationNumbers: {
      autoNumber: "AMS"
    }
  },
  CommonHTML: { matchFontHeight: true },
  displayAlign: "center"
});
</script>
<script async src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML"></script>

# 非線形静解析手法

前述したように微小変形問題の解析においては、平衡方程式などの基礎方程式と等価な仮想仕事の原理を用いて、この式を有限要素により離散化することによって有限要素解析を行うことができる。 構造物の大変形を扱う有限変形問題の解析においても基本的には仮想仕事の原理が用いられる点は同様である。

しかしながら、有限変形問題においては、たとえ材料の線形性を仮定しても仮想仕事の原理式は変位に関して非線形な方程式になる。
非線形式を解くためには通常、反復法による繰り返し計算が用いられる。

その反復計算においては、ある小さな荷重増分に対して区分的に行なわれ、それを積み重ねて最終的な変形状態へと至る増分解析手法が用いられる。
微小変形問題を仮定した場合、ひずみや応力を定義するための配置は、変形前と変形後とでとくに区別を行なっていなかった。
すなわち、微小変形を仮定している場合には基礎方程式を記述する配置は変形前であっても変形後であっても問題にはならなかった。

しかしながら、有限変形問題において増分解析を実施する場合、参照配置として最初の状態を参照するか、増分の開始点を参照するかの選択が可能である。
前者をtotal Lagrange法、後者をupdated Lagrange法と呼ぶ。詳細については章末参考文献などを参照されたい。

本開発コードでは、total Lagrange法およびupdated Lagrange法の双方を採用している。

## 幾何学的非線形解析手法

### 仮想仕事式の増分分解

時刻$t$までの状態が既知であり、時刻$t’=t + \Delta t$の状態を未知とする増分解析を想定する（図2.2.1参照）。
静的境界値問題の平衡方程式、力学的境界条件、幾何学的境界条件（基本境界条件）は次の通りである。

$$
\begin{equation}
\nabla_{t'_x} \cdot ^{t'} \sigma +^{t'} \overline{b} =0 \; in \; V
\label{eq:2.2.1}
\end{equation}
$$

$$
\begin{equation}
^{t'} \sigma \cdot^{t'} n = ^{t'} \overline{t} \; on \; ^{t'}s_t
\label{eq:2.2.2}
\end{equation}
$$

$$
\begin{equation}
^{t'} u = ^{t'} \overline{u} \; on \; ^{t'} s_u
\label{eq:2.2.3}
\end{equation}
$$

ただし$^{t'} \sigma$，$^{t'} \overline{b}$，$^{t'} n$，$^{t'} \overline{t}$，$^{t'} \overline{u}$は、それぞれ時刻$t’$におけるCauchy応力(真応力)、物体力、物体表面での外向き単位法線ベクトル、既定された表面力、既定された変位である。
これらの式は、時刻$t’$での配置$^{t'}v$, $^{t'}s\_t$, $^{t'}s\_u$に対して記述されるものである。

![](media/image02_01.png){width="3.40625in" height="1.5833333333333333in"}

図 2.2.1　増分解析の概念

## 仮想仕事の原理

式$\eqref{eq:2.2.1}$の平衡方程式と式$\eqref{eq:2.2.2}$の力学的境界条件と等価な仮想仕事の原理は次式で与えられる。

$$
\begin{equation}
\int_{^{t'}v}{^{t'} \sigma} : \delta^{t'} A\_{(L)} \, d^{t'}v =
\int_{^{t'} s\_{t}}^{t'}
\overline{t}
\cdot \delta u \, d^{t'}s +
\int_{V}^{t'}
\overline{b} \cdot \delta u \, d^{t'}v
\label{eq:2.2.4}
\end{equation}
$$

ここで、$^{t'} A\_L$はAlmansiひずみテンソルの線形部分であり、具体的には次式で表される。

$$
\begin{equation}
^{t'} A_{(L)} = \frac{1}{2}
\left\lbrace \frac{\partial ^{t'} u}{\partial ^{t'} x} + \left( \frac{ \partial ^{t'} u}{\partial ^{t'} x} \right) ^T \right\rbrace
\label{eq:2.2.5}
\end{equation}
$$

式$\eqref{eq:2.2.4}$を幾何学的境界条件、ひずみ変位関係式、応力ひずみ関係式とともに解けばよいのであるが、
式$\eqref{eq:2.2.4}$は時刻$t’$の配置で記述されており、現段階で時刻$t’$の配置は未知である。
そこで、時刻$0$の配置$V$または時刻$t$での配置$^{t'} v$を参照した定式化が行われる。

### total Lagrange法の定式化

ここでは、開発コードで用いられるtotal Lagrange法に基づく定式化を示す。

時刻$0$の初期配置を基準とする時刻$t’$での仮想仕事の原理式は、次式で与えられる。

$$
\begin{equation}
\int_{V}\,^{t'}_{0} S:\delta_0^{t'}
E dV=^{t'}\delta R
\label{eq:2.2.6}
\end{equation}
$$

$$
\begin{equation}
^{t'} \delta R=
\int_{S_t}\,
^{t'}\_{0} \overline{t} \cdot \delta u dS+
\int_{V}\,
^{t'}\_{0} \overline{b} \cdot \delta u dV
\label{eq:2.2.7}
\end{equation}
$$

ただし$^{t'}\_{0} S$, $^{t'}\_{0} E$は、それぞれ時刻$0$の初期配置を基準とする時刻$t’$での2nd Piola-Kirchhoff応力テンソル、Green-Lagrangeひずみテンソルを表す。
また、$_{0}^{t'}\overline{t}$, $\,\_{0}^{t'}\overline{b}$は、公称表面力ベクトル、初期配置の単位体積あたりに換算した物体力であり、式$\eqref{eq:2.2.1}$、式$\eqref{eq:2.2.2}$、式$\eqref{eq:2.2.3}$と関連させて、次式で与えられる。

$$
\begin{equation}
^{t'}\_0\overline{t}=\frac{d^{t'}s\_{t'}}{dS}\overline{t}
\label{eq:2.2.8}
\end{equation}
$$

$$
\begin{equation}
^{t'}\_0\overline{b}=\frac{d^{t'}v\_{t'}}{dV}\overline{b}
\label{eq:2.2.9}
\end{equation}
$$

時刻$t$におけるGreen-Lagrangeひずみテンソルは次式で定義される。

$$
\begin{equation}
^{t'}\_{0} E=\frac{1}{2}
\left\lbrace
  \frac{\partial ^{t}u}{\partial X}
 +\left(\frac{\partial ^{t} u}{\partial X} \right)^T
 +\left(\frac{\partial ^{t} u}{\partial X}\right)^T
 \cdot \frac{\partial ^{t} u}{\partial X}
\right\rbrace
\label{eq:2.2.10}
\end{equation}
$$

ここで、時刻$t'$における変位、2nd Piola-Kirchhoff応力$^{t'} u$, $_{0}^{t'} S$を次式のように増分分解して表す。

$$
\begin{equation}
^{t'} u =^{t} u + \Delta u
\label{eq:2.2.11}
\end{equation}
$$

$$
\begin{equation}
\_{0}^{t'} S = _{0}^{t} S + \Delta S
\label{eq:2.2.12}
\end{equation}
$$

このとき、変位増分に関連して、Green-Lagrangeひずみの増分は次式で定義される。

$$
\begin{equation}
\_{0}^{t'} E = _{0}^{t} E + \Delta E
\label{eq:2.2.13}
\end{equation}
$$

$$
\begin{equation}
\Delta E = \Delta E\_{L} + \Delta E_{NL}
\label{eq:2.2.14}
\end{equation}
$$

$$
\begin{equation}
\Delta E\_{L}=\frac{1}{2}
\left\lbrace
\frac{\partial \Delta u}{\partial X}
+\left(\frac{\partial \Delta u}{\partial X}\right)^T 
+\left(\frac{\partial \Delta u}{\partial X} \right)^T\cdot
\frac{\partial ^{t} u}{\partial X}
+\left(\frac{\partial ^{t} u}{\partial X} \right)^T
\cdot\frac{\partial \Delta u}{\partial X} \right\rbrace
\label{eq:2.2.15}
\end{equation}
$$

$$
\begin{equation}
\Delta E_{NL} = \frac{1}{2}\left(\frac{\partial \Delta u}{\partial X}\right)^T\cdot\frac{\partial \Delta u}{\partial X}
\label{eq:2.2.16}
\end{equation}
$$

式$\eqref{eq:2.2.11}$、式$\eqref{eq:2.2.12}$、式$\eqref{eq:2.2.13}$、式$\eqref{eq:2.2.14}$、式$\eqref{eq:2.2.15}$、式$\eqref{eq:2.2.16}$を、式$\eqref{eq:2.2.6}$、式$\eqref{eq:2.2.7}$に代入して次式を得る。

$$
\begin{equation}
\int_{V} \Delta S: (\delta \Delta E\_{L} + \delta \Delta E\_{NL})dV + \int_{V}\,\_{0}^{t} S : \delta \Delta E\_{NL} dV = ^{t'} \delta R - \int_V{\_{0}^t S} : \delta \Delta E\_{L}dV
\label{eq:2.2.17}
\end{equation}
$$

ここで、$\Delta S$は、$\Delta E\_L$と4階テンソル$^{t}\_{0} C$と関連づけて次式のように表されると仮定する。

$$
\begin{equation}
\Delta S=^t_0 C:\Delta_t E_{L}
\label{eq:2.2.18}
\end{equation}
$$

式$\eqref{eq:2.2.17}$に式$\eqref{eq:2.2.18}$を代入し、$\Delta u $の二次以上の項を有する$\Delta S :\delta \Delta E_{NL}$を省略して次式を得る。

$$
\begin{equation}
\int_V ( ^t\_{0}
C \Delta E\_{L} ) : \delta \Delta E\_{L} dV + \int_V\,^t\_{0} S : \delta \Delta E\_{NL} dV = \_{0}^{t'}\delta R - \int_V{\_{0}^t S} : \delta \Delta E_{L} dV
\label{eq:2.2.19}
\end{equation}
$$

式$\eqref{eq:2.2.19}$を有限要素により離散化して次式を得る。

$$
\begin{equation}
\delta U^T ( ^t\_{0} K\_{L} + ^t\_{0} K\_{NL} ) \Delta U = \delta U^{T}\,\_{0}^{t'} F - \partial U^T\,^t\_{0} Q
\label{eq:2.2.20}
\end{equation}
$$

ここで、$^t_0\ K\_L$, $^t\_0 K\_{NL}$, $\_0^{t'} F$, $^t\_0 Q$ は、それぞれ、初期変位マトリクス、初期応力マトリクス、外力ベクトル、内力ベクトルである。

したがって、時刻$t$の状態から、時刻$t’$の状態を求めるための漸化式は次式で与えられる。

$i = 0$

Step1 :
$ \,^{t'}\_0 K^{(0)}=^{t}\_0 K\_L+^{t}\_0 K\_{NL};\,^{t'}\_0 Q^{(0)}=^{t}\_0 Q;\, U^{(0)}=^{t} U $

Step2 :
$ ^{t'}\_0 K^{(i)}\Delta U^{(i)}=^{t'}\_0 F-^{t'}\_0 Q^{(i-1)} $

Step3 :
$ \,^{t'} U^{(i)}=^{t'} U^{(i-1)} + \Delta U^{(i)} $

$i=0$

### updated Lagrange法の定式化

時刻$t$の現配置を基準とする時刻$t’$での仮想仕事の原理式は、次式で与えられる。

$$
\begin{equation}
\int_{V}\,^{t'}_{t} S:\delta_t^{t'}
E dV=\,^{t'}\delta R
\label{eq:2.2.21}
\end{equation}
$$

$$
\begin{equation}
^{t'}\delta R = \int_{S_t}\,^{t'}\_{t}\overline{t} \cdot \delta u dS + \int_{V}\,^{t'}\_{t}\overline{b} \cdot \delta u dV
\label{eq:2.2.22}
\end{equation}
$$

ただし

$$
\begin{equation}
^{t'}\_{t} \overline{t} = \frac{d^{t'}s\_{t'}}{d^ts}\overline{t}
\label{eq:2.2.23}
\end{equation}
$$

$$
\begin{equation}
^{t'}\_{t} \overline{b} = \frac{d^{t'}v\_{t'}}{d^tv}\overline{b}
\label{eq:2.2.24}
\end{equation}
$$

テンソル$^{t'}\_{t} S$,$^{t'}\_{t} E$やベクトル、$^{t'}\_t\overline{t}$、$^{t'}\_t\overline{b}$が時刻$t$の現配置を基準としているが、Green-Lagrangeひずみについては初期変位(時刻$t$までの変位)$^t u$を含まず

$$
\begin{equation}
^{t'}\_{t} E = \Delta\_{t} E\_{L} + \Delta\_{t} E\_{NL}
\label{eq:2.2.25}
\end{equation}
$$

ただし

$$
\begin{equation}
\Delta\_{t} E\_{L}=\frac{1}{2}
\left\lbrace \frac{\partial \Delta u}{\partial^t\, x} + \left(\frac{ \partial \Delta u}{\partial ^t\,x}\right)^T \right\rbrace
\label{eq:2.2.26}
\end{equation}
$$

$$
\begin{equation}
\Delta_t E_{NL} = \frac{1}{2} \left( \frac{ \partial \Delta u}{\partial ^t\,x}\right)^T \cdot \frac{ \partial \Delta u}{\partial^t\,x}
\label{eq:2.2.27}
\end{equation}
$$

の形になる。一方

$$
\begin{equation}
\_{t'}^{t} S = \_{t}^{t} S + \Delta \_{t} S
\label{eq:2.2.28}
\end{equation}
$$

であるから、これを式$\eqref{eq:2.2.21}$、式$\eqref{eq:2.2.22}$と式$\eqref{eq:2.2.25}$に代入し整理すると解くべき方程式が次のように与えられる。

$$
\begin{equation}
\int_{t_{v}} \Delta\_{t} S : (\delta \Delta\_{t}{E\_{L}} + \delta \Delta\_t{E\_{NL}})d^t{v} + \int_{t\_{v}}{\_{t}^{t'}S} : \delta \Delta\_{t} {E\_{NL}}d^t{v}=^{t'} \delta R - \int_{t\_{v}}{\_{t}^t S} : \delta \Delta\_{t} E\_{L}d^t{v}
\label{eq:2.2.29}
\end{equation}
$$

ここで、$\Delta\_t S$は、$\Delta\_{t}{E_{L}}$と4階テンソル$^t\_t C$と関連づけて次式のように表されると仮定する。

$$
\begin{equation}
\Delta_t S = ^t_t C : \Delta_t E_{L}
\label{eq:2.2.30}
\end{equation}
$$

これを式$\eqref{eq:2.2.29}$に代入し、次式を得る。

$$
\begin{equation}
\int_V ( ^t_t C \Delta\_{t} E\_{L} ) : \delta \Delta\_{t} E\_{L} dV+\int_V{^t\_{t} S} : \delta \Delta\_{t} E\_{NL} dV = ^{t'} \delta R - \int_V{\_{t}^t S} : \delta \Delta_t E\_{L} dV
\label{eq:2.2.31}
\end{equation}
$$

式$\eqref{eq:2.2.31}$を有限要素により離散化して次式を得る。

$$
\begin{equation}
\delta U^T ( ^t_t K\_{L} + ^t_t K\_{NL} ) \Delta U = \delta U^{T}\, {\_{t}^{t'}} F - \partial U^T\, {^t\_{t} Q}
\label{eq:2.2.32}
\end{equation}
$$

ここで、$^t\_t K\_L$, $^t\_t K\_{NL}$, ${\_t^{t'}} F$, ${^t\_t Q}$は、それぞれ、初期変位マトリクス、初期応力マトリクス、外力ベクトル、内力ベクトルである。

したがって、時刻$t$の状態から、時刻$t’$の状態を求めるための漸化式は次式で与えられる。

$i = 0$

Step1 :
$\,\,\,^{t'}\_t K^{(i)}=\,^{t}\_t K\_L+^{t}\_t K\_{NL};\,^{t'}\_t Q^{(i)}=\, ^{t}\_t Q;\, U^{(i)}=\,^{t} U$

Step2 :
$\,\,\,^{t'}\_t K^{(i)} \Delta U^{(i)}=\, ^{t'}\_t F - ^{t'}\_t Q^{(i-1)}$

Step3 :
$\,\,\,^{t'} U^{(i)}=\, ^{t'} U^{(i-1)} + \Delta U^{(i)}$

$i = i + 1$

## 材料非線形解析手法

本開発コードでは、等方性超弾性および弾塑性二種類の非線形材料を解析することができる。

解析で対象とする材料は弾塑性材である場合では、updated Lagrange法を適用し、超弾性材である場合では、total Lagrange法を適用している。
また、反復解析手法にはNewton-Raphson法を適用している。

以下にこれらの材料構成式の概要を示す。

### 超弾性材料

等方性超弾性材料における弾性ポテンシャルエネルギーは、応力の作用していない初期状態からの等方性を持った応答から得られるものであり、
右Cauchy-Green変形テンソル$C$の主不変量$( I\_1, I\_2, I\_3 )$、または体積変化を除いた変形テンソルの主不変量$(\overline{I}\_1 , \overline{I}\_2 , \overline{I}\_3)$の関数,つまり、$ W = W ( I\_1, I\_2, I\_3 )$あるいは$W = W ( \overline{I}\_1 , \overline{I}\_2 , \overline{I}\_3)$として表すことができる。

超弾性材の構成式は2nd Piola-Kirchhoff応力とGreen-Lagrangeひずみの関係で定義され、その変形解析はtotal Lagrange法を適用する。

以下では本開発コードに含まれた超弾性モデルの弾性ポテンシャルエネルギー$W$を列挙する。
弾性ポテンシャルエネルギー$W$がわかれば、以下のように2nd Piola-Kirchhoff応力および応力－ひずみ関係を計算できる

$$
\begin{equation}
S = 2\frac{\partial W}{\partial C}
\label{eq:2.2.33}
\end{equation}
$$

$$
\begin{equation}
C = 4 \frac{ \partial^2 W}{\partial C \partial C}
\label{eq:2.2.34}
\end{equation}
$$

#### (1) Neo Hookean超弾性モデル

Neo-Hookean超弾性モデルは等方性を持つ線形則(Hooke則)を大変形問題へ対応できるように拡張したものである。
その弾性ポテンシャルは以下のとおりである。

$$
\begin{equation}
W = C\_{10} ( {\overline I\_{1}} - 3 ) + \frac{1}{D_1} ( J - 1 )^2
\label{eq:2.2.35}
\end{equation}
$$

ここで、$C\_{10}$と$D\_1 $は材料定数である。

#### (2) Mooney Rivlin超弾性モデル

$$
\begin{equation}
W = C\_{10} ( \overline{I}\_1 - 3 ) + C\_{01} ( \overline{I}\_2 - 3 ) + \frac{1}{D_1} ( J - 1 )^2
\label{eq:2.2.36}
\end{equation}
$$

ここで、$C\_{10}$, $C\_{01}$と$D\_1$は材料定数である。

#### (3) Arruda Boyce超弾性モデル

$$
\begin{align}
W &= \mu \left[ \frac{1}{2} ( {\overline{I}}_1 - 3 )
   + \frac{1}{20 {\lambda_m}^2} ( \ {{\overline{I}}_1}^2 - 9 ) 
   + \frac{11}{1050 {\lambda_m}^2} ( {{\overline{I}}_1}^3 - 27 ) \\\
   + \frac{19}{7000 {\lambda_m}^2} ( {{\overline{I}}_1}^4 - 81 )
   + \frac{519}{673750 {\lambda_m}^2} ( {{\overline{I}}_1}^5 - 243 ) \right] \\\
  &+ \frac{1}{D} \left( \frac{J^2 - 1}{2} - \ln J \right)
\label{eq:2.2.37}
\end{align}
$$

$$
\begin{equation}
\mu = \frac{\mu_0}{1 + \frac{3}{5 \lambda_m^2} + \frac{99}{175 \lambda_m^4} + \frac{513}{875 \lambda_m^6} + \frac{42039}{67375 \lambda_m^8}}
\label{eq:2.2.38}
\end{equation}
$$

ここで、$\mu$, $\lambda_m$と$D$は材料定数である。

### 弾塑性材料

本開発コードでは、関連流れ則に準じる弾塑性構成式を適用している。
また、その構成式はKirchhoff応力のJaumman速度と変形速度テンソルの関係を表し、その変形解析はupdated Lagrange法を適用する。

#### (1) 弾塑性構成式

弾塑性体の降伏条件が次のように与えられるものとする。

初期の降伏条件

$$
\begin{equation}
F( \sigma, \sigma_{y_0})
\label{eq:2.2.39}
\end{equation}
$$

後続の降伏条件

$$
\begin{equation}
F(\sigma, \sigma_y (\overline{e}^p))
\label{eq:2.2.40}
\end{equation}
$$

ここで、

  - $F$ : 降伏関数
  - $\sigma_{y_0}$ : 初期降伏応力
  - $\sigma_y$ : 後続の降伏応力
  - $\sigma$ : 応力テンソル
  - $e$ : 微小ひずみテンソル
  - $e^p$ : 塑性ひずみテンソル
  - $\overline{e}^p$ : 相当塑性ひずみ

降伏応力-相当塑性ひずみ関係が、単軸状態での応力-塑性ひずみ関係に一致するものとする。

**単軸状態での応力-塑性ひずみ関係**

$$
\begin{equation}
\sigma = H(e^p)
\label{eq:2.2.41}
\end{equation}
$$

$$
\begin{equation}
\frac{d \sigma}{d e^p} = H'
\label{eq:2.2.42}
\end{equation}
$$

ここで、$H'$は歪硬化係数である

**相当応力-相当塑性ひずみ関係**

$$
\begin{equation}
\overline{\sigma} = H(\overline{e}^p)
\label{eq:2.2.43}
\end{equation}
$$

$$
\begin{equation}
\dot{\overline{\sigma}} = H' \dot{\overline{e}^p}
\label{eq:2.2.44}
\end{equation}
$$

後続の降伏関数は一般には温度、塑性ひずみ仕事の関数であるが、ここでは簡単のため相当塑性ひずみ$\overline{e}^p$のみの関数であるものとする。
塑性変形の進行中は$F=0$が満たされ続ける為、次式が成立しなければならない。

$$
\begin{equation}
\dot{F} = \frac{\partial F}{\partial \sigma} : \dot{\sigma} + \frac{\partial F}{\partial e^p} : \dot{e}^p = 0
\label{eq:2.2.45}
\end{equation}
$$

式$\eqref{eq:2.2.45}$中の$\dot{F}$は$F$の時間導関数を表しており、以後、ある量$A$の時間導関数を$\dot{A}$で表す。

ここで、塑性ポテンシャル$\Theta$の存在を仮定し、塑性ひずみ速度を次式で表すものとする。

$$
\begin{equation}
\dot{e}^p=\dot{\lambda}\frac{\partial \Theta}{\partial \sigma}
\label{eq:2.2.46}
\end{equation}
$$

ここで$\dot{\lambda}$は係数である。

さらに、塑性ポテンシャル$\Theta$が降伏関数Fに等しいものとして、次式の関連流れ則を仮定する。

$$
\begin{equation}
\dot{e}^p = \dot{\lambda} \frac{\partial F}{\partial \sigma}
\label{eq:2.2.47}
\end{equation}
$$

この式を式$\eqref{eq:2.2.45}$に代入し、下式が得られる。

$$
\begin{equation}
\dot{\lambda} = \frac{a^T : d_D }{A + a^T : D : a}\dot{e}
\label{eq:2.2.48}
\end{equation}
$$

ここで、$D$は弾性マトリクスであり、

$$
\begin{align}
  a^T &= \frac{\partial F}{\partial \sigma}
& d_D &= D a^T
&   A &= -\frac{ a }{\dot{\lambda}} \frac{\partial F}{\partial e^p} : \dot{e}^p
\label{eq:2.2.49}
\end{align}
$$

弾塑性の応力―ひずみ関係式は以下のように書ける。

$$
\begin{equation}
\sigma = \left\lbrace D - \frac{ d\_D \otimes d^T\_D}{ A + d^T\_D a} \right\rbrace : \dot{e}
\label{eq:2.2.50}
\end{equation}
$$

弾塑性材の降伏関数$F$がわかれば、この式からその構成式が得られる。

#### (1) 降伏関数

以下では本開発コードに含まれた弾塑性降伏関数を列挙する

-  Von Mises降伏関数

$$
\begin{equation}
F = \sqrt{3 J\_2} - \sigma\_y = 0
\label{2.2.51}
\end{equation}
$$

-  Mohr-Coulomb降伏関数

$$
\begin{equation}
F = \sigma_1 - \sigma_3 + \ ( \ \sigma_1 + \sigma_3\  )\sin \phi - 2 \ c \cos \phi = 0
\label{eq:2.2.52}
\end{equation}
$$

-  Drucker-Prager降伏関数

$$
\begin{equation}
F = \sqrt{J\_2} - \ \alpha\ \sigma \ : I - \sigma_y = 0
\label{eq:2.2.53}
\end{equation}
$$

ここでは、材料定数$\alpha$と$\sigma_{y}$は材料の粘着力と摩擦角から以下のように計算する

$$
\begin{align}
  \alpha &= \frac{2 \sin \phi}{3 + \sin \phi}\
& \sigma_y &= \frac{6\ c \cos \phi}{3 + \sin \phi}
\label{eq:2.2.54}
\end{align}
$$

### 粘弾性材料

本開発コードでは、一般化されたMaxwellモデルを適用している。
その構成式は以下のように偏差ひずみ$e$と偏差粘性ひずみ$q$の関数になる。

$$
\begin{equation}
\sigma \ (t) = Ktr \varepsilon I + 2 G ( \mu_0 e + \mu q )
\label{eq:2.2.55}
\end{equation}
$$

ここでは

$$
\begin{equation}
\mu q = \sum_{m = 1}^{M} \mu_{m} q^{(m)} \sum_{m = 0}^{M} \mu_{m} = 1
\label{eq:2.2.56}
\end{equation}
$$

である。また、$q$は

$$
\begin{equation}
{\dot{q}}^{(m)} + \frac{1}{\lambda_{m}} q^{(m)} = \dot{e}
\label{eq:2.2.57}
\end{equation}
$$

から求められる。ここでは$\lambda_m$はリラクゼーションである。また、リラクゼーション係数$G$は、以下のProny級数で表す。

$$
\begin{equation}
G (t) = G \left[ \mu_0 + \sum_{i = 1}^M {\mu_m \exp\left( \frac{-t}{\lambda_m \ } \right)} \right]
\label{eq:2.2.58}
\end{equation}
$$

### クリープ材料

応力一定の状況下において時間依存性のある変位は「クリープ」と呼ばれる現象である。

前述した粘弾性挙動も一種の線形なクリープ現象と考えることができる。
ここでは、いくつかの非線形なクリープの説明を行うこととする。この現象は瞬間的に発生するひずみに追加することで構成式とする方法が一般的に用いられ、
ある定荷重が継続している間のひずみをクリープひずみ$\varepsilon^c\ $とする。
クリープを考慮した構成式は、通常、応力と全クリープひずみの関数として定義されるクリープひずみ速度${\dot{\varepsilon}}^c\ $が用いられる。

$$
\begin{equation}
{\dot{\varepsilon}}^c \equiv \frac{\partial \varepsilon^c}{\partial t} = \beta ( \,\sigma,\ \varepsilon^c\  )
\label{eq:2.2.59}
\end{equation}
$$

ここで、瞬間的に発生するひずみが弾性ひずみ$\varepsilon^e $であるとすると、全ひずみはクリープひずみを加えた次式のように表される。

$$
\begin{equation}
\varepsilon = \varepsilon^e + \varepsilon^c
\label{eq:2.2.60}
\end{equation}
$$

ここで、

$$
\begin{equation}
\varepsilon^e = {c^e}^{-1}\ : \sigma
\label{eq:2.2.61}
\end{equation}
$$

である。

前述の塑性材料でも示したように、クリープを示す構成式に対して数値解析上の時間積分の方法を示さなければならい。
クリープを考慮したときの構成式は、

$$
\begin{equation}
\sigma\_{n + 1} = c\ :\ ( \varepsilon\_{n + 1} - \varepsilon\_{n + 1}^c )
\label{eq:2.2.62}
\end{equation}
$$

$$
\begin{equation}
\varepsilon\_{n + 1}^c = \varepsilon\_n^c + \ \Delta t\ \beta\_{n + \theta}
\label{eq:2.2.63}
\end{equation}
$$

ここで、$\ \beta_{n + \theta}\ $は、

$$
\begin{equation}
\beta_{n + \theta} = ( 1 - \theta  ) \beta\_n + \theta \beta\_{n + 1}
\label{eq:2.2.64}
\end{equation}
$$

とする。また、クリープひずみ増分$\Delta \varepsilon^c\ $は、非線形方程式を単純化した

$$
\begin{equation}
R\_{n + 1} = \varepsilon\_{n + 1} - \ c^{- 1}\ : \sigma\_{n + 1} - \ \varepsilon\_n^c - \ \Delta t\ \beta\_{n + \theta} = \mathbf{0}
\label{eq:2.2.65}
\end{equation}
$$

とする。

Newton-Raphson法での反復計算では、初期値を$\sigma\_{n + 1} = \sigma\_n\ $および有限要素法から求められるひずみ増分として、反復解と増分解は次式とする。

$$
\begin{equation}
R\_{n + 1}^{(k + 1)} = \mathbf{0} = \ R_{n + 1}^{(k)} - ( \ c^{- 1} + \Delta t\ c\_{n + 1}^c\  ) d \sigma\_{n + 1}^{(k)}
\label{eq:2.2.66}
\end{equation}
$$

ここで、

$$
\begin{equation}
c\_{n + 1}^c = \frac{ \partial \beta} {\partial \sigma}\  |\_{n + \theta} = \theta \frac{ \partial \beta}{\partial \sigma}\ |\_{n + 1}
\label{eq:2.2.67}
\end{equation}
$$

とする。
式$\eqref{eq:2.2.65}$と式$\eqref{eq:2.2.66}$の解を使って残差$R$が$\mathbf{0}$になるまで反復解法を行うとき、応力$\sigma_{n + 1}$と接線係数

$$
\begin{equation}
c\_{n + 1}^* = ( c^{-1} + \Delta t c\_{n + 1}^c )^{- 1}
\label{eq:2.2.68}
\end{equation}
$$

を用いる。

式$\eqref{eq:2.2.59}$の具体的な式として、本開発コードは、以下のようなNortonモデルを適用している。
その構成式は下式のような相当クリップひずみ${\dot{\varepsilon}}^{cr}$がmises応力$q$と時間$t$の関数と表す。

$$
\begin{equation}
{\dot{\varepsilon}}^{cr} = A q^n t^m
\label{eq:2.2.69}
\end{equation}
$$

ここでは、$A$,$m$,$n$は材料定数である。

## 接触解析手法

2つの物体が接触すると、接触面を介して接触力$t_c$が伝達される。
仮想仕事の原理式（2.2.4）を以下のように書きかえる。

$$
\begin{equation}
\int^{t'}\_{^{t'}v}\,^{t'} \sigma : \delta^{t'} A\_{(L)} d^{t'}v = \int^{t'}\_{^{t'}S\_{t}}\,^{t'} \overline{t} \cdot \delta u d^{t'}s+ \int^{t'}\_{V} \overline{b} \cdot \delta u d^{t'}v + \int^{t'}\_{^{t'} S \_{c}}t\_{c}[\delta u^{(1)} - u^{(2)}]
\label{eq:2.2.70}
\end{equation}
$$

ここで、$S_c$は接触面積、$u^{(1)}$と$u^{(2)}$はそれぞれ接触物体1と接触物体2の変位を表している。

接触解析では、接触する可能性のある面を対にして指定する。
この面の対の片方をマスター面、もう片方をスレーブ面とする。
このマスタースレーブ解析手法では、接触拘束条件を以下のように仮定する。

  1.  スレーブ節点は，マスター面を貫通しない。
  2.  接触があった時、スレーブ節点は接触位置とし、この接触点を通じマスター面とスレーブ面が互いに接触力，摩擦力を伝達する。

式$\eqref{eq:2.2.70}$の最後の項を有限要素により離散化して次式を得る

$$
\begin{equation}
\int^{t'}\_{^{t'}S\_{c}} t\_c [\delta u^{(1)} - \delta u^{(2)}] \approx \delta UK\_c \Delta U + \delta UF\_c
\label{eq:2.2.71}
\end{equation}
$$

ここでは、$K_c$と$F_c$はそれぞれ接触剛性マトリクスおよび接触力を表す。
この式を式$\eqref{eq:2.2.20}あるいは$\eqref{eq:2.2.32}に代入すると、接触拘束を考慮したtotal Lagrange法およびupdated Lagrange法の有限要素法定式は以下のようになる。

$$
\begin{equation}
\delta U^T ( ^t\_0 K\_L + ^t\_0 K\_{NL} + K\_c ) \Delta U = \delta U^T {\_0^{t'} F} - \partial U^T {^t\_0 Q} + \delta UF\_c
\label{eq:2.2.72}
\end{equation}
$$

$$
\begin{equation}
\delta U^T (^t\_t K\_L + ^t\_t K\_{NL} + K\_c ) \Delta U = \delta U^T {\_{t} ^{t'} F} - \partial U^T {^t\_t Q}+ \delta UF\_c
\label{eq:2.2.73}
\end{equation}
$$

本開発ソフトは変形体同士間の接触変形解析ができ、ユーザーから以下の解析機能を選択できる。

-  微小すべり接触問題：この解析では接触点の位置変化がないと仮定している。
-  有限すべり接触問題：この解析は、変形と伴い接触位置変化のある場合に対応している。
-  摩擦なし接触問題
-  摩擦あり接触問題：この解析はCoulomb摩擦則に対応している。

ただし、微小変形線形弾性解析を選択した場合は、微小すべり摩擦なし問題となる。

また、現時点では一次ソリッド要素（要素番号341, 351, 361）の接触解析のみ対応している。

