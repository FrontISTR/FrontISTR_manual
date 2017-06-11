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

## 動的解析手法

本節では直接時間積分法を適用した動的問題解析手法について示す。以下に示すように、本開発コードでは、陰解法及び陽解法による時刻歴応答解析が可能である。

### 陰解法の定式化について

動的問題を対象として、下式に示す運動方程式の解法に直接時間積分法を適用した。

$$
\mathbf{M}( t + \Delta t )\ddot{\mathbf{U}}(t + \Delta t) + \mathbf{C}( t + \Delta t )\dot{\mathbf{U}}(t + \Delta t) + \mathbf{Q}( t + \Delta t ) = \mathbf{F}( t + \Delta t )
\tag{2.5.1}$$

ここでは、$\mathbf{M}$は質量マトリクス，$\mathbf{C}$は減衰マトリクス、$\mathbf{Q}$は内力ベクトル，$\mathbf{F}$は外力ベクトルである。
なお、本ソフトは質量の変化を考慮せず、質量マトリクスは非線形において変形によらず一定となる。

時間増分$\Delta t$内での変位、速度及び加速度の変化は、Newmark-$\beta$法を用いて式(2.5.2)及び式(2.5.3)に示すように近似している。

$$
\dot{\mathbf{U}}(t + \Delta t) =
\frac{\gamma}{\beta \Delta t} \Delta \mathbf{U}( t + \Delta t ) - \frac{\gamma - \beta}{\beta} \dot{\mathbf{U}}( t ) - \Delta t\frac{\gamma - 2\beta}{2\beta} \ddot{\mathbf{U}}(t)
\tag{2.5.2}$$

$$
\ddot{\mathbf{U}}(t + \Delta t) = \frac{1}{\beta \Delta t^2}\Delta \mathbf{U}(t + \Delta t) - \frac{1}{\beta \Delta t} \dot{\mathbf{U}}(t) - \frac{1 - 2\beta}{2\beta}\ddot{\mathbf{U}}(t)
\tag{2.5.3}$$

ここで、$\gamma$，$\beta$はNewmark-$\beta$法のパラメータである．

よく知られているように、$\gamma$及び$\beta$を以下の値にした場合、線形加速度法あるいは台形則に一致する。

$\gamma = \frac{1}{2}$，$\gamma = \frac{1}{6}$（線形加速度法）

$\gamma = \frac{1}{2}$，$\gamma = \frac{1}{4}$（台形則）

式(2.5.2)及び式(2.5.3)を式(2.5.1)に代入すると次式が得られる。

$$
( \frac{1}{\beta \Delta t^{2}} \mathbf{M} + \frac{\gamma}{\beta \Delta t}\mathbf{C} + \mathbf{K} ) \Delta\mathbf{U} ( t + \Delta t ) = \\
  \mathbf{F} ( t + \Delta t )
- \mathbf{Q} ( t + \Delta t )
+ \frac{1}{\beta \Delta t} \mathbf{M} \dot{\mathbf{U}} ( t )
+ \frac{1 - 2\beta}{2\beta} \mathbf{M} \ddot{\mathbf{U}} ( t )
+ \frac{\gamma - \beta}{\beta} \mathbf{C} \dot{\mathbf{U}} (t)
+ \Delta t \frac{\gamma - 2\beta}{2\beta} \mathbf{C} \ddot{\mathbf{U}}(t)
\tag{2.5.4}$$

特に、線形問題に対しては$\mathbf{{K}}\_{L}$は線形剛性マトリクスとし、$\mathbf{Q} ( t + \Delta t ) = \mathbf{K}\_{L}\mathbf{U} (t + \Delta t)$となり、この式を上式に代入すると次式が得られる。

$$
 M ( -\frac{1}{\beta \Delta t^2} U(t) -\frac{1}{\beta \Delta t}\dot U(t) - \frac{2\beta}{1-2\beta} \ddot U(t)) + C( - \frac{\gamma}{\beta \Delta t} U(t) + (1 - \frac{\gamma}{\beta}) \dot U(t) + \Delta{t}\frac{ 2\beta-\gamma}{2\beta}\ddot U(t)) + \frac{1}{\beta \Delta{t}^2} M + \frac{\gamma}{\beta \Delta{t}} C + K_L U(t+\Delta{t}) = F(t+\Delta{t})
\tag{2.5.5}$$

尚、幾何学的境界条件として加速度が指定されている箇所では、式(2.5.2)から次式の変位を得る。

$$
u_{is} (t+\Delta{t}) = u_{is} (t) + \Delta t \dot{u(t)} + \Delta t^2 (\frac{1}{2} -\beta ) {\ddot{u}}_{is} (t + \Delta t)
\tag{2.5.6}$$

同様に、速度が指定されている箇所では、式(2.76)から次式の変位を得る。

$$
u_{is}(t+\Delta{t})= u_{is}(t)+\Delta t
\frac{ \gamma - \beta}{ \gamma}\dot{u_{is}}(t)
+(\Delta{t})^2 \frac{ \gamma - 2\beta}{ 2\gamma}
\ddot{u_{is}}(t)
+\Delta t \frac{\beta}{ \gamma}\dot{u_{is}}(t+\Delta{t})
\tag{2.5.7}$$

ここで、
$u_{is}(t+\Delta{t})$：時刻$t+\Delta{t}$における節点変位
$\dot{u_{is}}(t+\Delta{t})$：時刻$t+\Delta{t}$節点速度
$\ddot{u_{is}}(t+\Delta{t})$：時刻$t+\Delta{t}$節点加速度
$i$:節点自由度番号（１〜１節点あたりの自由度数）
$s$:節点番号
また、質量項及び減衰項の取り扱いは次のとおりとした。

##### 質量項の取り扱い

質量マトリックスについては原則として集中質量マトリックスとして扱っている。

##### 減衰項の取り扱い

減衰項については式(2.5.8)で表されるRayleigh減衰として扱っている。

$$
\mathbf{C} = \mathbf{R}_m \mathbf{M} + \mathbf{R}_k \mathbf{K}_L
\tag{2.5.8}$$

ここで、

$\mathbf{\it{R}}\_{m},\mathbf{\it{R}}\_{k}$：パラメータ

### 陽解法の定式化について

陽解法では下式に示す時刻tにおける運動方程式を基にする。

$$
\mathbf{M}\ddot{\mathbf{U}}(t) + \mathbf{C}( t )\dot{\mathbf{U}}(t) + \mathbf{Q}( t ) = \mathbf{F}( t )
\tag{2.5.9}$$

ここでは、時刻t+Δt及び時刻t-Δtにおける変位を時刻tにおけるTaylor展開により表し、Δtに関する2次項までとると、次のようになる。

$$
U(t+\Delta{t})=U(t)+\dot{U}(t)(\Delta{t})
+\frac{ 1}{ 2!}\ddot{U}(\Delta{t})^2
\tag{2.5.10}$$

$$
U(t-\Delta{t})=U(t)-\dot{U}(t)(\Delta{t})
+\frac{ 1}{ 2!}\ddot{U}(\Delta{t})^2
\tag{2.5.11}$$

式(2.83)及び式(2.84)の差及び和から次式が得られる。

$$
\dot{U}(t)=\frac{ 1}{ 2\Delta{t}}
(U(t+\Delta{t})-U(t-\Delta{t}))
\tag{2.5.12}$$

$$
\ddot{U}=
\frac{ 1}{ (2\Delta{t})^2}
(U(t+\Delta{t})-2U(t)+U(t-\Delta{t}))
\tag{2.5.13}$$

式(2.5.12)及び式(2.5.13)を式(2.5.9)に代入すると次式が得られる。

$$
( \frac{1}{\Delta t^{2}}\mathbf{M} + \frac{1}{2\Delta t}\mathbf{C} )\mathbf{U}( t + \Delta t ) = \mathbf{F}(t) - \mathbf{Q}(t) - \frac{1}{\Delta t^{2}}\mathbf{M\lbrack}2\mathbf{U}( t )\mathbf{- U}( t - \Delta t )\rbrack - \frac{1}{2\Delta t}\mathbf{\text{CU}}(t - \Delta t)
\tag{2.5.14}$$

特に、線形問題に対しては$\mathbf{Q}( t ) = \mathbf{K}_{L}\mathbf{U}(t)$となり、上式は以下になる

$$
( \frac{1}{\Delta t^{2}}\mathbf{M} + \frac{1}{2\Delta t}\mathbf{C} )\mathbf{U}( t + \Delta t ) = \mathbf{F}(t) - \mathbf{K}_{L}\mathbf{U}(t) - \frac{1}{\Delta t^{2}}\mathbf{M\lbrack}2\mathbf{U}( t )\mathbf{- U}( t - \Delta t )\rbrack - \frac{1}{2\Delta t}\mathbf{C}(t - \Delta t)\mathbf{U}
\tag{2.5.15}$$

ここで、質量マトリックス及び減衰マトリックスを次のようにおくと、式(2.5.15)は連立方程式の求解操作を不要とする。

$\mathbf{M}$:質量マトリックス，集中質量マトリックス

$\mathbf{C}$:減衰マトリックス(2.5.16)

比例減衰マトリックス $\mathbf{C}=\mathbf{\it{R}}_{m}\mathbf{M}$

$\mathbf{\it{R}}_{m}$: パラメータ

従って、式(2.5.15)から**U**(t+Δt)は次式により求めることができる。

$$
\mathbf{U}( t + \Delta t ) = \frac{1}{( \frac{1}{\Delta t^{2}}\mathbf{M} + \frac{1}{2\Delta t}\mathbf{C} )}\{ \mathbf{F}(t) - \mathbf{Q}(t) - \frac{1}{\Delta t^{2}}\mathbf{M\lbrack}2\mathbf{U}( t )\mathbf{- U}( t - \Delta t )\rbrack - \frac{1}{2\Delta t}\mathbf{C}(t - \Delta t)\mathbf{U} \}
\tag{2.5.17}$$
