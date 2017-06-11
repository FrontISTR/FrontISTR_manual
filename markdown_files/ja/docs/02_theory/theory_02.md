<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {
    inlineMath: [['$','$'], ['\\(','\\)']],
    processEscapes: true
  },
  CommonHTML: { matchFontHeight: true },
  displayAlign: "center"
});
</script>
<script async src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML"></script>

## 非線形静解析手法

前述したように微小変形問題の解析においては、平衡方程式などの基礎方程式と等価な仮想仕事の原理を用いて、この式を有限要素により離散化することによって有限要素解析を行うことができる。構造物の大変形を扱う有限変形問題の解析においても基本的には仮想仕事の原理が用いられる点は同様である。しかしながら、有限変形問題においては、たとえ材料の線形性を仮定しても仮想仕事の原理式は変位に関して非線形な方程式になる。非線形式を解くためには通常、反復法による繰り返し計算が用いられる。その反復計算においては、ある小さな荷重増分に対して区分的に行なわれ、それを積み重ねて最終的な変形状態へと至る増分解析手法が用いられる。微小変形問題を仮定した場合、ひずみや応力を定義するための配置は、変形前と変形後とでとくに区別を行なっていなかった。すなわち、微小変形を仮定している場合には基礎方程式を記述する配置は変形前であっても変形後であっても問題にはならなかった。しかしながら、有限変形問題において増分解析を実施する場合、参照配置として最初の状態を参照するか、増分の開始点を参照するかの選択が可能である。前者をtotal
Lagrange法、後者をupdated
Lagrange法と呼ぶ。詳細については章末参考文献などを参照されたい。

本開発コードでは、total Lagrange法およびupdated
Lagrange法の双方を採用している。

### 幾何学的非線形解析手法

#### 仮想仕事式の増分分解

時刻ｔまでの状態が既知であり、時刻t’=t+Δｔの状態を未知とする増分解析を想定する。（図
2.2.1参照）静的境界値問題の平衡方程式、力学的境界条件、幾何学的境界条件（基本境界条件）は次の通りである。

$$
\nabla_{t'_{\mathbf x}} \cdot ^{t'}\boldsymbol{\sigma} +^{t'} \overline{\mathbf{b}} =0\quad in \quad {V}
\tag{2.2.1}$$

$$
^{t'}\boldsymbol{\sigma} \cdot^{t'}\mathbf{ n}= ^{t'}\overline{\mathbf{t}} \quad on \quad ^{t'}s_{t}
\tag{2.2.2}$$

$$
^{t'}\mathbf{u}= ^{t'} \overline{\mathbf{u}}\quad on \quad^{t'} s_{u}
\tag{2.2.3}$$

ただし$^{t'}\boldsymbol{\sigma}$，$^{t'} \overline{\mathbf{b}}$，$^{t'}\mathbf{ n}$，$^{t'}\overline{\mathbf{t}}$，$^{t'} \overline{\mathbf{u}}$は、それぞれ時刻t’におけるCauchy応力（真応力）、物体力、物体表面での外向き単位法線ベクトル、既定された表面力、既定された変位である。これらの式は、時刻t’での配置$^{t'}v,^{t'}s\_{t},^{t'}s\_{u}$に対して記述されるものである。

![](media/image38.png){width="3.40625in" height="1.5833333333333333in"}

図 2.2.1　増分解析の概念

#### 仮想仕事の原理

式(2.2.1)の平衡方程式と式(2.2.2)の力学的境界条件と等価な仮想仕事の原理は次式で与えられる。

$$
\int_{^{t'}v}{^{t'}\boldsymbol{\sigma}} : \delta^{t'}\mathbf{A}\_{(L)} d^{t'}v = 
\int_{^{t'} s\_{t}}^{t'}
\overline{\mathbf{t}}
\cdot \delta \mathbf{u} d^{t'}s + 
\int_{V}^{t'}
\overline{\mathbf{b}} \cdot \delta \mathbf{u} d^{t'}v
\tag{2.2.4}$$

ここで、$^{t'}\mathbf{A}\_{(L)}$はAlmansiひずみテンソルの線形部分であり、具体的には次式で表される。

$$
^{t'}\mathbf{A}_{(L)}=\frac{ 1}{ 2}
( \frac{\partial ^{t'}\mathbf u}{\partial ^{t'}\mathbf x}+(\frac{\partial ^{t'}\mathbf u}{\partial ^{t'}\mathbf x})^T )
\tag{2.2.5}$$

式(2.2.4)を幾何学的境界条件、ひずみ変位関係式、応力ひずみ関係式とともに解けばよいのであるが、式(2.2.4)は時刻t’の配置で記述されており、現段階で時刻t’の配置は未知である。そこで、時刻0の配置Ｖまたは時刻ｔでの配置$^{t'}v$を参照した定式化が行われる。

#### total Lagrange法の定式化

ここでは、開発コードで用いられるtotal Lagrange法に基づく定式化を示す。

時刻0の初期配置を基準とする時刻t’での仮想仕事の原理式は、次式で与えられる。

$$
\int_{V}\,^{t'}_{0}\mathbf{S}:\delta_0^{t'}
\mathbf{E}dV=^{t'}\delta \mathbf{R}
\tag{2.2.6}$$

$$
^{t'}\delta\mathbf{R}=
\int_{S_t}\,
^{t'}\_{0} \overline{\mathbf{t}} \cdot \delta\mathbf{u}dS+
\int_{V}\,
^{t'}\_{0} \overline{\mathbf{b}} \cdot \delta\mathbf{u}dV
\tag{2.2.7}$$

ただし$^{t'}\_{0}\mathbf{S},\,^{t'}\_{0}\mathbf{E}$は、それぞれ時刻0の初期配置を基準とする時刻t’での2nd
Piola-Kirchhoff応力テンソル、Green-Lagrangeひずみテンソルを表す。また、$_{0}^{t'}\overline{\mathbf{t}}$,$\,\_{0}^{t'}\overline{\mathbf{b}}$は、公称表面力ベクトル、初期配置の単位体積あたりに換算した物体力であり、式(2.2.1)(2.2.2)(2.2.3)と関連させて、次式で与えられる。

$$
^{t'}\_0\overline{\mathbf{t}}=\frac{d^{t'}s\_{t'}}{dS}\overline{\mathbf{t}}
\tag{2.2.8}$$

$$
^{t'}\_0\overline{\mathbf{b}}=\frac{d^{t'}v\_{t'}}{dV}\overline{\mathbf{b}}
\tag{2.2.9}$$

時刻tにおけるGreen-Lagrangeひずみテンソルは次式で定義される。

$$
^{t'}\_{0} \mathbf{E}=\frac{1}{2} ( \frac{\partial ^{t}\mathbf{u}}{\partial \mathbf{X}}+\left(\frac{\partial
^{t}\mathbf{u}}{\partial \mathbf{X}}\right)^T+\left(\frac{\partial ^{t}\mathbf{u}}{\partial
\mathbf{X}}\right)^T \cdot \frac{\partial ^{t}\mathbf{u}}{\partial \mathbf{X}} )
\tag{2.2.10}$$

ここで、時刻t’における変位、2nd
Piola-Kirchhoff応力$^{t'}\mathbf{u},\,\_{0}^{t'}\mathbf{S}$を次式のように増分分解して表す。

$$
^{t'}\mathbf{u}=^{t}\mathbf{u}+\Delta \mathbf{u}
\tag{2.2.11}$$

$$
\_{0}^{t'}\mathbf{S}=_{0}^{t}\mathbf{S}+\Delta \mathbf{S}
\tag{2.2.12}$$

このとき、変位増分に関連して、Green-Lagrangeひずみの増分は次式で定義される。

$$
\_{0}^{t'}\mathbf{E}=_{0}^{t}\mathbf{E}+\Delta \mathbf{E}
\tag{2.2.13}$$

$$
\Delta \mathbf{E}=\Delta \mathbf{E}\_{L} + \Delta \mathbf{E}_{NL}
\tag{2.2.14}$$

$$
\Delta \mathbf{E}\_{L}=\frac{1}{2} ( \frac{\partial \Delta\mathbf{u}}{\partial \mathbf{X}}+\left(\frac{\partial
\Delta\mathbf{u}}{\partial \mathbf{X}}\right)^T+\left(\frac{\partial \Delta\mathbf{u}}{\partial
\mathbf{X}}\right)^T\cdot\frac{\partial ^{t}\mathbf{u}}{\partial \mathbf{X}}+\left(\frac{\partial
^{t}\mathbf{u}}{\partial \mathbf{X}}\right)^T\cdot\frac{\partial \Delta\mathbf{u}}{\partial
\mathbf{X}} )
\tag{2.2.15}$$

$$
\Delta \mathbf{E}_{NL}=\frac{1}{2}\left(\frac{\partial \Delta\mathbf{u}}{\partial
\mathbf{X}}\right)^T\cdot\frac{\partial \Delta\mathbf{u}}{\partial \mathbf{X}}
\tag{2.2.16}$$

式(2.2.11)(2.2.12)(2.2.13)(2.2.14)(2.2.15)(2.2.16)を、式(2.2.6)(2.2.7)に代入して次式を得る。

$$
\int_{V}\Delta\mathbf{S}:(\delta\Delta\mathbf{E}\_{L}+\delta\Delta\mathbf{E}\_{NL})dV+\int_{V}\,\_{0}^{t}\mathbf{S}:\delta\Delta\mathbf{E}\_{NL}dV=^{t'}\delta\mathbf{R}-\int_V{\_{0}^t\mathbf{S}}:\delta\Delta\mathbf{E}\_{L}dV
\tag{2.2.17}$$

ここで、$\Delta\mathbf{S}$は、$\Delta\mathbf{E}\_L$と４階テンソル$\Delta^{t}\_{0}\mathbf{C}$と関連づけて次式のように表されると仮定する。

$$
\Delta \mathbf{S}=^t_0 \mathbf{C}:\Delta_t\mathbf{E}_{L}
\tag{2.2.18}$$

式(2.2.17)に式(2.2.18)を代入し、$\Delta{u}$の二次以上の項を有する$\Delta\mathbf{S}:\delta\Delta\mathbf{E}_{NL}$を省略して次式を得る。

$$
\int_V ( ^t\_{0}
\mathbf{C}\Delta\mathbf{E}\_{L} ) :\delta\Delta\mathbf{E}\_{L} dV+\int_V\,^t\_{0} \mathbf{S}:\delta\Delta\mathbf{E}\_{NL}dV=\_{0}^{t'}\delta\mathbf{R}-\int_V{\_{0}^t\mathbf{S}}:\delta\Delta\mathbf{E}_{L}dV
\tag{2.2.19}$$

式(2.2.19)を有限要素により離散化して次式を得る。

$$
\delta\mathbf{U}^T ( ^t\_{0} \mathbf{K}\_{L}+^t\_{0} \mathbf{K}\_{NL} ) \Delta\mathbf{U}=\delta\mathbf{U}^{T}\,\_{0}^{t'}\mathbf{F}-\partial\mathbf{U}^T\,^t\_{0} \mathbf{Q}
\tag{2.2.20}$$

ここで、$^t_0\mathbf{K}\_L$,$^t\_0\mathbf{K}\_{NL}$,$\_0^{t'}\mathbf{F}$,$^t\_0\mathbf{Q}$は、それぞれ、初期変位マトリクス、初期応力マトリクス、外力ベクトル、内力ベクトルである。

したがって、時刻tの状態から、時刻t’の状態を求めるための漸化式は次式で与えられる。

Step1 :
$\,\,\, i=0$
    $\,\,\,^{t'}\_0\mathbf{K}^{(0)}=^{t}\_0\mathbf{K}\_L+^{t}\_0\mathbf{K}\_{NL};\,^{t'}\_0\mathbf{Q}^{(0)}=^{t}\_0\mathbf{Q};\,\mathbf{U}^{(0)}=^{t}\mathbf{U}$


Step2 :
$\,\,\,
^{t'}\_0\mathbf{K}^{(i)}\Delta \mathbf{U}^{(i)}=^{t'}\_0\mathbf{F}-^{t'}\_0\mathbf{Q}^{(i-1)}$

Step3 :
$\,\,\,^{t'}\mathbf{U}^{(i)}=^{t'}\mathbf{U}^{(i-1)}+\Delta\mathbf{U}^{(i)}$
$\,\,\, i=0$


#### updated Lagrange法の定式化

時刻tの現配置を基準とする時刻t’での仮想仕事の原理式は、次式で与えられる。

$$
\int_{V}\,^{t'}_{t}\mathbf{S}:\delta_t^{t'}
\mathbf{E}dV=\,^{t'}\delta \mathbf{R}
\tag{2.2.21}$$

$$
^{t'}\delta\mathbf{R}=\int_{S_t}\,^{t'}\_{t}\overline{\mathbf{t}}\cdot\delta\mathbf{u}dS+\int_{V}\,^{t'}\_{t}\overline{\mathbf{b}}\cdot\delta\mathbf{u}dV
\tag{2.2.22}$$

ただし

$$
^{t'}\_{t} \overline{\mathbf{t}}=\frac{d^{t'}s\_{t'}}{d^ts}\overline{\mathbf{t}}
\tag{2.2.23}$$

$$
^{t'}\_{t} \overline{\mathbf{b}}=\frac{d^{t'}v\_{t'}}{d^tv}\overline{\mathbf{b}}
\tag{2.2.24}$$

テンソル$^{t'}\_{t}\mathbf{S}$,$^{t'}\_{t}\mathbf{E}$やベクトル、$^{t'}\_t\overline{\mathbf{t}}$、$^{t'}\_t\overline{\mathbf{b}}$が時刻tの現配置を基準としているが、Green-Lagrangeひずみについては初期変位（時刻tまでの変位）$^t\mathbf{u}$を含まず

$$
^{t'}\_{t} \mathbf{E}=\Delta\_{t} \mathbf{E}\_{L} + \Delta\_{t} \mathbf{E}\_{NL}
\tag{2.2.25}$$

ただし

$$
\Delta\_{t} \mathbf{E}\_{L}=\frac{1}{2}
( \frac{\partial \Delta\mathbf{u}}{\partial^t\,x}+(\frac{\partial \Delta\mathbf{u}}{\partial ^t\,x})^T )
\tag{2.2.26}$$

$$
\Delta_t\mathbf{E}_{NL}=\frac{1}{2}\left(\frac{\partial \Delta\mathbf{u}}{\partial
^t\,x}\right)^T\cdot\frac{\partial \Delta\mathbf{u}}{\partial^t\,x}
\tag{2.2.27}$$

の形になる。一方

$$
\_{t'}^{t} \mathbf{S}=\_{t}^{t}\mathbf{S}+\Delta \_{t} \mathbf{S}
\tag{2.2.28}$$

であるから、これを式(2.2.21)(2.2.22)と式(2.2.25)に代入し整理すると解くべき方程式が次のように与えられる。

$$
\int_{t_{v}} \Delta\_{t} \mathbf{S}:(\delta\Delta\_{t}{\mathbf{E}\_{L}}+\delta\Delta\_t{\mathbf{E}\_{NL}})d^t{v}+\int_{t\_{v}}{\_{t}^{t'}\mathbf{S}}:\delta\Delta\_{t} {\mathbf{E}\_{NL}}d^t{v}=^{t'}\delta\mathbf{R}-\int_{t\_{v}}{\_{t}^t\mathbf{S}}:\delta\Delta\_{t}\mathbf{E}\_{L}d^t{v}
\tag{2.2.29}$$

ここで、$\Delta\_t\mathbf{S}$は、$\Delta\_{t}{\mathbf{E}_{L}}$と４階テンソル$^t\_t\mathbf{C}$と関連づけて次式のように表されると仮定する。

$$
 \Delta_t\mathbf{S}=^t_t \mathbf{C}:\Delta_t\mathbf{E}_{L}
\tag{2.2.30}$$

これを式(2.2.29)に代入し、次式を得る。

$$
\int_V ( ^t_t
\mathbf{C}\Delta\_{t} \mathbf{E}\_{L} ) :\delta\Delta\_{t}\mathbf{E}\_{L} dV+\int_V{^t\_{t} \mathbf{S}}:\delta\Delta\_{t} \mathbf{E}\_{NL} dV=^{t'}\delta\mathbf{R}-\int_V{\_{t}^t\mathbf{S}}:\delta\Delta_t\mathbf{E}\_{L}dV
\tag{2.2.31}$$

式(2.2.31)を有限要素により離散化して次式を得る。

$$
\delta\mathbf{U}^T ( ^t_t\mathbf{K}\_{L} + ^t_t\mathbf{K}\_{NL} ) \Delta\mathbf{U}=\delta\mathbf{U}^{T}\,{\_{t}^{t'}}\mathbf{F}-\partial\mathbf{U}^T\,{^t\_{t} \mathbf{Q}}
\tag{2.2.32}$$

ここで、$^t\_t\mathbf{K}\_L,^t\_t\mathbf{K}\_{NL},{\_t^{t'}}\mathbf{F},{^t\_t\mathbf{Q}}$は、それぞれ、初期変位マトリクス、初期応力マトリクス、外力ベクトル、内力ベクトルである。

したがって、時刻tの状態から、時刻t’の状態を求めるための漸化式は次式で与えられる。

Step1 :
$\,\,\, i=0$
    $\,\,\,^{t'}\_t\mathbf{K}^{(i)}=\,^{t}\_t\mathbf{K}\_L+^{t}\_t\mathbf{K}\_{NL};\,^{t'}\_t\mathbf{Q}^{(i)}=\,^{t}\_t\mathbf{Q};\,\mathbf{U}^{(i)}=\,^{t}\mathbf{U}$


Step2 :
$\,\,\,
^{t'}\_t\mathbf{K}^{(i)}\Delta \mathbf{U}^{(i)}=\,^{t'}\_t\mathbf{F}-^{t'}\_t\mathbf{Q}^{(i-1)}$

Step3 :
$\,\,\,^{t'}\mathbf{U}^{(i)}=\,^{t'}\mathbf{U}^{(i-1)}+\Delta\mathbf{U}^{(i)}$
$\,\,\, i=i+1$


### 材料非線形解析手法

本開発コードでは、等方性超弾性および弾塑性二種類の非線形材料を解析することができる。解析で対象とする材料は弾塑性材である場合では、updated
Lagrange法を適用し、超弾性材である場合では、total
Lagrange法を適用している。また、反復解析手法にはNewton-Raphson法を適用している。

以下にこれらの材料構成式の概要を示す。

#### 超弾性材料

等方性超弾性材料における弾性ポテンシャルエネルギーは、応力の作用していない初期状態からの等方性を持った応答から得られるものであり、右Cauchy-Green変形テンソルCの主不変量$\mathbf{\ }\left( \mathbf{\ }\mathbf{I}\_{\mathbf{1}}\mathbf{,}\mathbf{I}\_{\mathbf{2}}\mathbf{,}\mathbf{I}\_{\mathbf{3}}\mathbf{\ } \right)\mathbf{\ }$、または体積変化を除いた変形テンソルの主不変量$\left(\mathbf{\overline{I}}\_1 \mathbf{,}\mathbf{\overline{I}}\_2 \mathbf{,}\mathbf{\overline{I}}\_3\right)$の関数,つまり、$\mathbf{\ W = W}\left( \mathbf{\ }\mathbf{I}\_{\mathbf{1}}\mathbf{,\ }\mathbf{I}\_{\mathbf{2}}\mathbf{,\ }\mathbf{I}\_{\mathbf{3}} \right)\mathbf{\ }$あるいは$\mathbf{W = W}\left(\mathbf{\overline{I}}\_1 \mathbf{,}\mathbf{\overline{I}}\_2 \mathbf{,}\mathbf{\overline{I}}\_3\right)$として表すことができる。

超弾性材の構成式は2nd
Piola-Kirchhoff応力とGreen-Lagrangeひずみの関係で定義され、その変形解析はtotal
Lagrange法を適用する。

以下では本開発コードに含まれた超弾性モデルの弾性ポテンシャルエネルギーWを列挙する。弾性ポテンシャルエネルギーWがわかれば、以下のように2nd
Piola-Kirchhoff応力および応力－ひずみ関係を計算できる

$$
S = 2\frac{\partial W}{\partial C}
\tag{2.2.33}$$

$$
C = 4\frac{\partial^{2}W}{\partial C\partial C}
\tag{2.2.34}$$

（１）Neo Hookean超弾性モデル

Neo-Hookean超弾性モデルは等方性を持つ線形則（Hooke則）を大変形問題へ対応できるように拡張したものである。
その弾性ポテンシャルは以下のとおりである。

$$
W = C\_{10} ( {\overline {I}\_{1}} - 3 ) + \frac{1}{D_{1}} ( J - 1 )^{2}
\tag{2.2.35}$$

ここで、$C\_{10}$と$D\_{1}\ $は材料定数である。

（２）Mooney Rivlin超弾性モデル

$$
W = C\_{10} ( \overline{{I}}\_{1}- 3 ) + C\_{01} ( \overline{{I}}\_{2} - 3 ) + \frac{1}{D_{1}} ( J - 1 )^{2}
\tag{2.2.36}$$

ここで、$\ C\_{10},\ C\_{01}$と$\ D\_{1}\ $は材料定数である。

（３）Arruda Boyce超弾性モデル

$$
W = \mu ( \frac{1}{2} ( {\overline{I}}\_{1} - 3 ) + \frac{1}{20\lambda\_{m}^{2}} ( \ {\overline{I}}\_{1}^{2} - 9 ) + \frac{11}{1050\lambda\_{m}^{2}} ( {\overline{I}}\_{1}^{3} - 27 ) + \frac{19}{7000\lambda\_{m}^{2}} ( {\overline{I}}\_{1}^{4} - 81 )
+ \frac{519}{673750\lambda\_{m}^{2}} ( {\overline{I}}\_{1}^{5} - 243 ) ) + \frac{1}{D} ( \frac{J^{2} - 1}{2} - \ln J )
\tag{2.2.37}$$

$$
\mu = \frac{\mu_{0}}{1 + \frac{3}{5{\lambda_{m}}^{2}} + \frac{99}{175{\lambda_{m}}^{4}} + \frac{513}{875{\lambda_{m}}^{6}} + \frac{42039}{67375{\lambda_{m}}^{8}}}
\tag{2.2.38}$$

ここで、$\mu$, $\lambda_{m}$と$D$は材料定数である。

#### 弾塑性材料

本開発コードでは、関連流れ則に準じる弾塑性構成式を適用している。
また、その構成式はKirchhoff応力のJaumman速度と変形速度テンソルの関係を表し、その変形解析はupdated Lagrange法を適用する。

（１）弾塑性構成式

弾塑性体の降伏条件が次のように与えられるものとする。

初期の降伏条件

$$
F\left(\boldsymbol{\sigma},\sigma_{y_0}\right)
\tag{2.2.39}$$

後続の降伏条件

$$
F\left(\boldsymbol{\sigma},\sigma_{y}\left(\overline{e}^p\right)\right)
\tag{2.2.40}$$

ここで、

*F*:　降伏関数

$\sigma_{y_0}$:初期降伏応力、　　　　$\sigma_{y}$:後続の降伏応力

**σ**: 応力テンソル、　　　**e**: 微小ひずみテンソル

$\mathbf{e}^{p}$:塑性ひずみテンソル$\,{\overline{e}}^{p}:$ 相当塑性ひずみ

降伏応力-相当塑性ひずみ関係が、単軸状態での応力-塑性ひずみ関係に一致するものとする。

単軸状態での応力-塑性ひずみ関係：

$$
\sigma=H\left(e^p\right)
\tag{2.2.41}$$

$$
\frac{d\sigma}{de^p}=H'
\tag{2.2.42}$$

ここで、

$H'$：歪硬化係数

相当応力-相当塑性ひずみ関係：

$$
\overline{\sigma}=H\left(\overline{e}^p\right)
\tag{2.2.43}$$

$$
\dot{\overline{\sigma}}=H'\dot{\overline{e}^p}
\tag{2.2.44}$$

後続の降伏関数は一般には温度、塑性ひずみ仕事の関数であるが、ここでは簡単のため相当塑性ひずみ$\overline{e}^p$のみの関数であるものとする。塑性変形の進行中は$F=0$が満たされ続ける為、次式が成立しなければならない。

$$
\dot{F}=\frac{\partial F}{\partial {\boldsymbol{\sigma}}}\boldsymbol{:\dot{\sigma}}+\frac{\partial F}{\partial {\boldsymbol{e}}}\boldsymbol{:\dot{e}}^p
\tag{2.2.45}$$

式(2.2.45)中の$\dot{F}$は$F$の時間導関数を表しており、以後、ある量$A$の時間導関数を$\dot{A}$で表す。

ここで、塑性ポテンシャル$\boldsymbol{\Theta}$の存在を仮定し、塑性ひずみ速度を次式で表すものとする。

$$
\boldsymbol{\dot{e}}^p=\dot{\lambda}\frac{\partial \Theta}{\partial \boldsymbol{\sigma}}
\tag{2.2.46}$$

ここで$\dot{\lambda}$は係数である。

さらに、塑性ポテンシャル$\Theta$が降伏関数Fに等しいものとして、次式の関連流れ則を仮定する。

$$
\boldsymbol{\dot{e}}^p=\dot{\lambda}\frac{\partial F}{\partial \boldsymbol{\sigma}}
\tag{2.2.47}$$

この式を式(2.4.45)に代入し、下式が得られる。

$$
\dot{\lambda}=\frac{\mathbf{\text{a}}^{T}:\mathbf{\text{d}}_D}{A+\mathbf{\text{a}}^{T}:\mathbf{\text{D}}:\mathbf{\text{a}}}\mathbf{\dot{e}}
\tag{2.2.48}$$

ここで、**D**は弾性マトリクスであり、

$$
\mathbf{\text{a}}^{T}=\frac{\partial F}{\partial {\boldsymbol{\sigma}}}\qquad \mathbf{\text{d}}_D=\mathbf{\text{Da}}^T \qquad A=-\frac{ 1}{ \dot{\lambda}}\frac{\partial F}{\partial {\boldsymbol{e}^p}}\boldsymbol{:\dot{e}}^p
\tag{2.2.49}$$

弾塑性の応力―ひずみ関係式は以下のように書ける。

$$
\boldsymbol{\dot{\sigma}}=( \mathbf{\text{D}}-\frac{ \mathbf{\text{d}}\_{D}\otimes\mathbf{\text{d}}^{T}\_{D}}{ A+\mathbf{\text{d}}^{T}\_{D}\mathbf{\text{a}}} ):\boldsymbol{\dot{e}}
\tag{2.2.50}$$

弾塑性材の降伏関数Fがわかれば、この式からその構成式が得られる。

（１）降伏関数

以下では本開発コードに含まれた弾塑性降伏関数を列挙する

・Von Mises降伏関数

$$
F = \sqrt{3\mathbf{J}\_{2}} - \sigma\_{y} = 0
\tag{2.2.51}$$

・Mohr-Coulomb降伏関数

$$
F = \sigma_{1} - \sigma_{3} + \ \left( \ \sigma_{1} + \sigma_{3}\  \right)\sin\phi - 2\ c\cos\phi = 0
\tag{2.2.52}$$

・Drucker-Prager降伏関数

$$
F = \sqrt{\mathbf{J}\_{2}} - \ \alpha\ \boldsymbol{\sigma}\ :\mathbf{I} - \sigma_{y} = 0
\tag{2.2.53}$$

ここでは、材料定数$\alpha$と$\sigma_{y}$は材料の粘着力と摩擦角から以下のように計算する

$$
\alpha = \frac{2\sin\phi}{3 + \sin\phi}\ \ ,\ \ \ \ \ \ \ \ \sigma_{y} = \frac{6\ c\cos\phi}{3 + \sin\phi}
\tag{2.2.54}$$

#### 粘弾性材料

本開発コードでは、一般化されたMaxwellモデルを適用している。その構成式は以下のように偏差ひずみ**e**と偏差粘性ひずみ**q**の関数になる。

$$
\boldsymbol{\sigma}\ \left( \text{t } \right) = \rm{ Ktr}\boldsymbol{\varepsilon I +}2\text{G}\left( \mu_{0}\mathbf{e} + \mu\mathbf{q} \right)
\tag{2.2.55}$$

ここでは

$$
\mu\mathbf{q =}\sum_{\mathbf{m = 1}}^{\mathbf{M}}\mu_{\mathbf{m}}\mathbf{q}^{\mathbf{(m)}}\mathbf{;\ \ \ \ \ \ \ \ }\sum_{\mathbf{m = 0}}^{\mathbf{M}}\mu_{\mathbf{m}}\mathbf{=}1
\tag{2.2.56}$$

である。また、qは

$$
{\dot{\mathbf{q}}}^{(m)} + \frac{1}{\lambda_{m}}\mathbf{q}^{\left( m \right)} = \dot{\mathbf{e}}
\tag{2.2.57}$$

から求められる。ここでは$\lambda_{m}$はリラクゼーションである。また、リラクゼーション係数Gは、以下のProny級数で表す。

$$
\text{G}\left( t\right) = \text{ G}\left\lbrack \mu_{0} + \sum_{i = 1}^{M}{\mu_{m}\exp\left( \frac{- t}{\lambda_{m}\ } \right)} \right\rbrack
\tag{2.2.58}$$

#### クリープ材料

応力一定の状況下において時間依存性のある変位は「クリープ」と呼ばれる現象である。前述した粘弾性挙動も一種の線形なクリープ現象と考えることができる。ここでは、いくつかの非線形なクリープの説明を行うこととする。この現象は瞬間的に発生するひずみに追加することで構成式とする方法が一般的に用いられ、ある定荷重が継続している間のひずみをクリープひずみ$\mathbf{\ }\mathbf{\varepsilon}^{c}\ $とする。クリープを考慮した構成式は、通常、応力と全クリープひずみの関数として定義されるクリープひずみ速度$\mathbf{\ }{\dot{\mathbf{\varepsilon}}}^{c}\ $が用いられる。

$$
{\dot{\boldsymbol{\varepsilon}}}^{c} \equiv \frac{\partial\boldsymbol{\varepsilon}^{c}}{\partial t} = \boldsymbol{\beta}\ \left( \,\boldsymbol{\sigma},\ \boldsymbol{\varepsilon}^{c}\  \right)
\tag{2.2.59}$$

ここで、瞬間的に発生するひずみが弾性ひずみ$\ \mathbf{\varepsilon}^{e}\ $であるとすると、全ひずみはクリープひずみを加えた次式のように表される。

$$
\mathbf{\varepsilon} = \mathbf{\varepsilon}^{e} + \ \mathbf{\varepsilon}^{c}
\tag{2.2.60}$$

ここで、

$$
\boldsymbol{\varepsilon}^{e} = {\mathbf{c}^{e}}^{- 1}\ : \boldsymbol{\sigma}
\tag{2.2.61}$$

である。

前述の塑性材料でも示したように、クリープを示す構成式に対して数値解析上の時間積分の方法を示さなければならい。
クリープを考慮したときの構成式は、

$$
\boldsymbol{\sigma}\_{n + 1} = \mathbf{c}\ :\ ( \boldsymbol{\varepsilon}\_{n + 1} - \boldsymbol{\varepsilon}\_{n + 1}^{c} )
\tag{2.2.62}$$

$$
\boldsymbol{\varepsilon}\_{n + 1}^{c} = \boldsymbol{\varepsilon}\_{n}^{c} + \ \Delta t\ \boldsymbol{\beta}\_{n + \theta}
\tag{2.2.63}$$

ここで、$\ \boldsymbol{\beta}_{n + \theta}\ $は、

$$
\boldsymbol{\beta}_{n + \theta} = ( 1 - \theta  ) \boldsymbol{\beta}\_{n} + \theta \boldsymbol{\beta}\_{n + 1}
\tag{2.2.64}$$

とする。また、クリープひずみ増分$\boldsymbol{\Delta\varepsilon}^{c}\ $は、非線形方程式を単純化した

$$
\mathbf{R}\_{n + 1} = \boldsymbol{\varepsilon}\_{n + 1} - \ \mathbf{c}^{- 1}\ :\boldsymbol{\sigma}\_{n + 1} - \ \boldsymbol{\varepsilon}\_{n}^{c} - \ \Delta t\ \boldsymbol{\beta}\_{n + \theta} = \mathbf{0}
\tag{2.2.65}$$

とする。

　Newton-Raphson法での反復計算では、初期値を$\mathbf{\sigma}\_{n + 1} = \mathbf{\sigma}\_{n}\ $および有限要素法から求められるひずみ増分として、反復解と増分解は次式とする。

$$
\mathbf{R}\_{n + 1}^{(k + 1)} = \mathbf{0} = \ \mathbf{R}_{n + 1}^{(k)} - ( \ \mathbf{c}^{- 1} + \Delta t\ \mathbf{c}\_{n + 1}^{c}\  )\text{ d}\boldsymbol{\sigma}\_{n + 1}^{(k)}
\tag{2.2.66}$$

ここで、

$$
\mathbf{c}\_{n + 1}^{c} =  \frac{\partial\boldsymbol{\beta}}{\partial\boldsymbol{\sigma}}\  |\_{n + \theta} = \boldsymbol{\theta} \frac{\partial\boldsymbol{\beta}}{\partial\boldsymbol{\sigma}}\  |\_{n + 1}
\tag{2.2.67}$$

とする。式(2.2.65)と式(2.2.66)の解を使って残差$\ \mathbf{R}\ $が$\ \mathbf{0}\ $になるまで反復解法を行うとき、応力$\mathbf{\ }\mathbf{\sigma}_{n + 1}\mathbf{\ }$と接線係数

$$
\mathbf{c}\_{n + 1}^{*} = ( \mathbf{c}^{- 1} + \Delta t\ \mathbf{c}\_{n + 1}^{c} )^{- 1}
\tag{2.2.68}$$

を用いる。

式(2.2.59)の具体的な式として、本開発コードは、以下のようなNortonモデルを適用している。その構成式は下式のような相当クリップひずみ${\dot{\varepsilon}}^{\text{cr}}$がmises応力qと時間tの関数と表す。

$$
{\dot{\varepsilon}}^{\text{cr}} = Aq^{n}t^{m}
\tag{2.2.69}$$

ここでは、$A$,$m$,$n$は材料定数である。

### 接触解析手法

2つの物体が接触すると、接触面を介して接触力$\mathbf{t}_{c}$が伝達される。仮想仕事の原理式（2.2.4）を以下のように書きかえる。

$$
\int^{t'}\_{^{t'}v}\,^{t'}\boldsymbol{\sigma}: \delta^{t'}\mathbf{A}\_{(L)} d^{t'}v = \int^{t'}\_{^{t'}S\_{t}}\,^{t'}\overline{\mathbf{t}} \cdot\delta \mathbf{u} d^{t'}s+ \int^{t'}\_{V} \overline{\mathbf{b}} \cdot \delta \mathbf{u} d^{t'}v+\int^{t'}\_{^{t'}S\_{c}}\mathbf{t}\_{c}[\delta \mathbf{u}^{(1)}-\mathbf{u}^{(2)}]
\tag{2.2.70}$$

ここで、$S_{c}$は接触面積、$\mathbf{u}^{(1)}$と$\mathbf{u}^{(2)}$はそれぞれ接触物体1と接触物体2の変位を表している。

接触解析では、接触する可能性のある面を対にして指定する。この面の対の片方をマスター面、もう片方をスレーブ面とする。このマスタースレーブ解析手法では、接触拘束条件を以下のように仮定する。

1)  スレーブ節点は，マスター面を貫通しない。

2)  接触があった時、スレーブ節点は接触位置とし、この接触点を通じマスター面とスレーブ面が互いに接触力，摩擦力を伝達する。

式(2.2.70)の最後の項を有限要素により離散化して次式を得る

$$
\int^{t'}\_{^{t'}S\_{c}}\mathbf{t}\_{c}[\delta \mathbf{u}^{(1)}-\delta\mathbf{u}^{(2)}]\approx\delta\mathbf{\text{UK}}\_{c}\Delta\mathbf{\text{U}}+\delta\mathbf{\text{UF}}\_c
\tag{2.2.71}$$

ここでは、$\mathbf{\text{K}}_c$と$\mathbf{\text{F}}_c$はそれぞれ接触剛性マトリクスおよび接触力を表す。この式を式(2.2.20)あるいは(2.2.32)に代入すると、接触拘束を考慮したtotal
Lagrange法およびupdated Lagrange法の有限要素法定式は以下のようになる。

$$
\delta\mathbf{U}^T ( ^t\_{0} \mathbf{K}\_{L}+^t\_{0} \mathbf{K}\_{NL}+\mathbf{K}\_{c} ) \Delta\mathbf{U}=\delta\mathbf{U}^{T}{\_{0}^{t'}\mathbf{F}}-\partial\mathbf{U}^T{^t\_{0}\mathbf{Q}}+\delta\mathbf{\text{UF}}\_{c}
\tag{2.2.72}$$

$$
\delta\mathbf{U}^T (^t\_{t} \mathbf{K}\_{L} +^t\_{t} \mathbf{K}\_{NL}+\mathbf{K}\_{c} ) \Delta\mathbf{U}=\delta\mathbf{U}^{T}{\_{t} ^{t'}\mathbf{F}}-\partial\mathbf{U}^T{^t\_{t} \mathbf{Q}}+\delta\mathbf{\text{UF}}\_{c}
\tag{2.2.73}$$

本開発ソフトは変形体同士間の接触変形解析ができ、ユーザーから以下の解析機能を選択できる。

・　微小すべり接触問題：この解析では接触点の位置変化がないと仮定している。

・　有限すべり接触問題：この解析は、変形と伴い接触位置変化のある場合に対応している。

・　摩擦なし接触問題

・　摩擦あり接触問題：この解析はCoulomb摩擦則に対応している。

ただし、微小変形線形弾性解析を選択した場合は、微小すべり摩擦なし問題となる。

また、現時点では一次ソリッド要素（要素番号341,351,361）の接触解析のみ対応している。

