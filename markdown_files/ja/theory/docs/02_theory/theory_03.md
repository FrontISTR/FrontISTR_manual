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

## 動的解析手法

本節では直接時間積分法を適用した動的問題解析手法について示す。以下に示すように、本開発コードでは、陰解法及び陽解法による時刻歴応答解析が可能である。

### 陰解法の定式化について

動的問題を対象として、下式に示す運動方程式の解法に直接時間積分法を適用した。

$$
\begin{equation}
M( t + \Delta t ) \ddot{U} (t + \Delta t) + C( t + \Delta t ) \dot{U}(t + \Delta t) + Q( t + \Delta t ) = F( t + \Delta t )
\label{eq:2.5.1}
\end{equation}
$$

ここでは、$M$は質量マトリクス，$C$は減衰マトリクス、$Q$は内力ベクトル，$F$は外力ベクトルである。
なお、本ソフトは質量の変化を考慮せず、質量マトリクスは非線形において変形によらず一定となる。

時間増分$\Delta t$内での変位、速度及び加速度の変化は、Newmark-$\beta$法を用いて式$\eqref{eq:2.5.2}$及び式$\eqref{eq:2.5.3}$に示すように近似している。

$$
\begin{equation}
\dot{U}(t + \Delta t) =
\frac{\gamma}{\beta \Delta t} \Delta U( t + \Delta t ) - \frac{\gamma - \beta}{\beta} \dot{U}( t ) - \Delta t \frac{\gamma - 2\beta}{2\beta} \ddot{U}(t)
\label{eq:2.5.2}
\end{equation}
$$

$$
\begin{equation}
\ddot{U}(t + \Delta t) = \frac{1}{\beta \Delta t^2}\Delta U(t + \Delta t) - \frac{1}{\beta \Delta t} \dot{U}(t) - \frac{1 - 2\beta}{2\beta} \ddot {U}(t)
\label{eq:2.5.3}
\end{equation}
$$

ここで、$\gamma$，$\beta$はNewmark-$\beta$法のパラメータである．

よく知られているように、$\gamma$及び$\beta$を以下の値にした場合、線形加速度法あるいは台形則に一致する。

$\gamma = \frac{1}{2}$，$\gamma = \frac{1}{6}$（線形加速度法）

$\gamma = \frac{1}{2}$，$\gamma = \frac{1}{4}$（台形則）

式$\eqref{eq:2.5.2}$、式$\eqref{eq:2.5.3}$を式$\eqref{eq:2.5.1}$に代入すると次式が得られる。

$$
\begin{align}
\nonumber \left( \frac{1}{\beta \Delta t^2} \mathbf{M} + \frac{\gamma}{\beta \Delta t} C + K \right) \Delta U ( t + \Delta t ) &= F ( t + \Delta t )
- Q ( t + \Delta t ) \\\
\nonumber &+ \frac{1}{\beta \Delta t} M \dot{U} ( t )
           + \frac{1 - 2\beta}{2\beta} M \ddot{U} ( t ) \\\
&+ \frac{\gamma - \beta}{\beta} C \dot{U} (t)
           + \Delta t \frac{\gamma - 2\beta}{2 \beta} C \ddot{U}(t)
\label{eq:2.5.4}
\end{align}
$$

特に、線形問題に対しては$K_L$は線形剛性マトリクスとし、$Q ( t + \Delta t ) = K_L U (t + \Delta t)$となり、この式を上式に代入すると次式が得られる。

$$
\begin{align}
\nonumber M \left\lbrace -\frac{1}{\beta \Delta t^2} U(t) -\frac{1}{\beta \Delta t}\dot U(t) - \frac{2\beta}{1-2\beta} \ddot U(t) \right\rbrace
&+ C\left\lbrace - \frac{\gamma}{\beta \Delta t} U(t) + \left(1 - \frac{\gamma}{\beta}\right) \dot U(t) + \Delta{t}\frac{ 2\beta-\gamma}{2\beta}\ddot U(t)\right\rbrace \\\
 & + \frac{1}{\beta \Delta{t}^2} M + \frac{\gamma}{\beta \Delta{t}} C + K_L U(t+\Delta{t}) = F(t+\Delta{t})
\label{eq:2.5.5}
\end{align}
$$

なお、幾何学的境界条件として加速度が指定されている箇所では、式\eqref{eq:2.5.2}から次式の変位を得る。

$$
\begin{equation}
u_{is} (t+\Delta{t}) = u_{is} (t) + \Delta t \dot{u}(t) + \Delta t^2 \left(\frac{1}{2} -\beta \right) {\ddot{u}}_{is} (t + \Delta t)
\label{eq:2.5.6}
\end{equation}
$$

同様に、速度が指定されている箇所では、式$\eqref{eq:2.5.6}$から次式の変位を得る。

$$
\begin{equation}
u_{is}(t+\Delta{t})= u_{is}(t)+\Delta t
\frac{ \gamma - \beta}{ \gamma}\dot{u_{is}}(t)
+(\Delta{t})^2 \frac{ \gamma - 2\beta}{ 2\gamma}
\ddot{u_{is}}(t)
+\Delta t \frac{\beta}{ \gamma}\dot{u_{is}}(t+\Delta{t})
\label{eq:2.5.7}
\end{equation}
$$

ここで、
$u_{is}(t+\Delta{t})$は時刻$t+\Delta{t}$における節点変位、$\dot{u_{is}}(t+\Delta{t})$は時刻$t+\Delta{t}$の節点速度、
$\ddot{u_{is}}(t+\Delta{t})$は時刻$t+\Delta{t}$の節点加速度、$i$は節点自由度番号、$s$は節点番号である．
また、質量項及び減衰項の取り扱いは次のとおりとした。

##### 質量項の取り扱い

質量マトリックスについては原則として集中質量マトリックスとして扱っている。

##### 減衰項の取り扱い

減衰項については式$\eqref{eq:2.5.8}$で表されるRayleigh減衰として扱っている。

$$
\begin{equation}
C = R_m M + R_k K_L
\label{eq:2.5.8}
\end{equation}
$$

ここで、$R_m$、$R_k$はRayleigh減衰のパラメータである。

### 陽解法の定式化について

陽解法では下式に示す時刻tにおける運動方程式を基にする。

$$
\begin{equation}
M \ddot{U}(t) + C (t) \dot{U}(t) + Q(t) = F(t)
\label{eq:2.5.9}
\end{equation}
$$

ここでは、時刻$t + \Delta t$及び時刻$t - \Delta t$における変位を時刻$t$におけるTaylor展開により表し、$\Delta t$に関する2次項までとると、次のようになる。

$$
\begin{equation}
U(t+\Delta{t}) = U(t)+\dot{U}(t)(\Delta{t})
+\frac{1}{2!}\ddot{U}(\Delta{t})^2
\label{eq:2.5.10}
\end{equation}
$$

$$
\begin{equation}
U(t-\Delta{t})=U(t)-\dot{U}(t)(\Delta{t})
+\frac{1}{2!}\ddot{U}(\Delta{t})^2
\label{eq:2.5.11}
\end{equation}
$$

式$\eqref{eq:2.5.3}$、式$\eqref{eq:2.5.4}$の差及び和から次式が得られる。

$$
\begin{equation}
\dot{U}(t)=\frac{1}{2\Delta{t}}
(U(t+\Delta{t})-U(t-\Delta{t}))
\label{eq:2.5.12}
\end{equation}
$$

$$
\begin{equation}
\ddot{U}=
\frac{1}{(2\Delta{t})^2}
(U(t+\Delta{t})-2U(t)+U(t-\Delta{t}))
\label{eq:2.5.13}
\end{equation}
$$

式$\eqref{eq:2.5.12}、式$\eqref{eq:2.5.13}を式$\eqref{eq:2.5.9}$に代入すると次式が得られる。

$$
\begin{equation}
\left( \frac{1}{\Delta t^{2}} M + \frac{1}{2\Delta t} C \right) U ( t + \Delta t ) \\\
= F(t) - Q(t) - \frac{1}{\Delta t^{2}} 2 U(t) - U( t - \Delta t) - \frac{1}{2\Delta t} C U(t - \Delta t)
\label{eq:2.5.14}
\end{equation}
$$

特に、線形問題に対しては$Q(t) = K_L U(t)$となり、上式は以下になる

$$
\begin{equation}
\left( \frac{1}{\Delta t^{2}} M + \frac{1}{2\Delta t} C \right) U( t + \Delta t ) \\\
= F(t) - K_L U(t) - \frac{1}{\Delta t^{2}} M U(t) - U(t - \Delta t) - \frac{1}{2\Delta t} C U (t - \Delta t)
\label{eq:2.5.15}
\end{equation}
$$

ここで、質量マトリックス$M$を集中質量マトリックス、減衰マトリックスを比例減衰マトリックス $C = R_m M$のようにおくと、式\eqref{eq:2.5.15}は連立方程式の求解操作を不要とする。

従って、式$\eqref{eq:2.5.15}$から$U(t+\Delta t)$は次式により求めることができる。

$$
\begin{equation}
U( t + \Delta t ) \\\
= \frac{1}{( \frac{1}{\Delta t^{2}} M + \frac{1}{2\Delta t} C )} \{ F(t) - Q(t) - \frac{1}{\Delta t^{2}} M U(t) - U(t - \Delta t) - \frac{1}{2\Delta t} C U(t - \Delta t) \}
\label{eq:2.5.17}
\end{equation}$$
