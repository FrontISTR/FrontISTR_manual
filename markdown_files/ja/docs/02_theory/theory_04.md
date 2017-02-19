<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {
    inlineMath: [['$','$'], ['\\(','\\)']],
    processEscapes: true
  },
  CommonHTML: { matchFontHeight: false },
  displayAlign: "left",
  displayIndent: "2em"
});
</script>
<script async src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML"></script>

## 熱伝導解析

本開発コードで用いられる有限要素法（Finite Element
Method）による固体についての熱伝導解析手法を示す。

### 基礎方程式

連続体中での熱伝導方程式は以下のようになる。

$$
\rho{c}\frac{\partial T}{\partial t}=
\frac{\partial }{\partial x}\left(kxx\frac{\partial T}{\partial x}\right)
+
\frac{\partial }{\partial y}\left(kyy\frac{\partial T}{\partial y}\right)
+
\frac{\partial }{\partial z}\left(kzz\frac{\partial T}{\partial z}\right)+Q
\tag{2.4.1}$$

ただし、

$\rho=\rho(x)$　　　　　　　質量（密度）

$c=c(x,T)$　　　　　　比熱

$T=T(x,t)$ 　　　　　　温度

$k=k(x,T)$　　　　　　熱伝導率

$Q=Q(x,T,t)$　　　　　発熱量

である。ここで$x$は位置、$T$は温度、$t$は時間を表す。

考慮している領域を$S$、その周囲を$\Gamma$とする。$\Gamma$上では、Dirichet型かNeumann型のいずれかの境界条件が、いたるところで与えられるものと仮定すると境界条件は以下のようになる。


$$
T=T_1(x,t)\quad\quad\quad x\in\Gamma_1
\tag{2.4.2}$$

$$
k\frac{\partial T}{\partial n}=q(x,T,t)
\quad\quad\quad x\in\Gamma_2
\tag{2.4.3}$$

ただし、$T_1$，$q$は関数形が既知とする。$q$は境界からの流出熱流束である。本プログラムでは、3種類の熱流束が考慮できる。

$$
q=-q_s+q_c+q_r
\tag{2.4.4}$$

$$
q_s=q_s(x,t)
\tag{2.4.5}$$

$$
q_c=hc(T-Tc)
\tag{2.4.6}$$

$$
q_r=hr(T^4-Tr^4)
\tag{2.4.7}$$

$q_s$は分布熱流束、$q_c$は対流熱伝達による熱流束、$q_r$は輻射熱伝達による熱流束である。ただし、

$Tc=Tc(x,t)$ 対流熱伝達率雰囲気温度

$hc=hc(x,t)$ 対流熱伝達係数

$Tr=Tr(x,t)$ 輻射熱伝達率雰囲気温度

$hr=\varepsilon \sigma{F}= {hr(x,t)}$ 輻射熱伝達係数

$\varepsilon$： 輻射率，$\sigma$： StefanBoltzmann定数，$F$： 形態係数

### 離散化

方程式(2.4.1)をGalerkin法によって離散化すると、

$$
[\mathbf{K}]\{T\}+[\mathbf{M}]\frac{\partial T}{\partial t}=\{F\}
\tag{2.4.8}$$

ただし、

$$
[\mathbf{K}]=\int\left(
kxx\frac{\partial \{N\}^T}{\partial x}\frac{\partial \{N\}}{\partial x}
+
kyy\frac{\partial \{N\}^T}{\partial y}\frac{\partial \{N\}}{\partial y}
+
kzz\frac{\partial \{N\}^T}{\partial z}\frac{\partial \{N\}}{\partial z}
\right)dV\\
+\int{hc}\{N\}^T\{N\}ds+\int{hr}\{N\}^T\{N\}ds\qquad\qquad\qquad\qquad\qquad\qquad
\tag{2.4.9}$$

$$
[\mathbf{M}]=\int{\rho{c}}\{N\}^T\{N\}dV
\tag{2.4.10}$$

$$
\{F\}=\int{Q}\{N\}^TdV-\int{q_s}\{N\}^TdS
+\int{hc}Tc\{N\}^TdS\\
+\int{hcTr}\left({T+Tr}\right)\left({T^2+Tr^2}\right)
\{N\}^TdS\qquad\qquad
\tag{2.4.11}$$

$$
\{N\}=\left(N^1,N^2,...\right),\qquad{Ni=Ni(x)}
\tag{2.4.12}$$

：形状関数

方程式(2.4.8)は非線形かつ非定常の方程式である。
いま、時間に関して後退オイラー法により離散化して、時刻$t=t_0$における温度が既知のとき時刻$t=t_{0+\Delta{t}}$での温度を次式を用いて計算することにする。

$$
[\mathbf{K}]_{t=t_{0+\Delta{t}}}\{T\}_{t=t_{0+\Delta{t}}}+[\mathbf{M}]_{t=t_{0+\Delta{t}}}
\frac{\{T\}_{t=t_{0+\Delta{t}}}-\{T\}_{t=t_{0}}}
{\Delta{t}}=\{F\}_{t=t_{0+\Delta{t}}}
\tag{2.4.13}$$

ここでの式(2.4.13)を近似的にみたす温度ベクトル$\{T\}\_{t=t\_{0+\Delta{t}}}^{(i)}$
を改善して、精度の良い解$\{T\}\_{t=t\_{0+\Delta{t}}}^{(i)+1}$を求めることを考える。

そのために、まず、温度ベクトルを次のようにあらわす。

$$
\{T\}_{t=t_{0+\Delta{t}}}=
\{T\}_{t=t_{0+\Delta{t}}}^{(i)}
+\{\Delta{T}\}_{t=t_{0+\Delta{t}}}^{(i)}
\tag{2.4.14}$$

熱伝導マトリクスと温度ベクトルとの積、質量マトリクスなどを次式のように近似的にあらわす。

$$
[\mathbf{K}]_{t=t_{0+\Delta{t}}}\{T\}_{t=t_{0+\Delta{t}}}
\approx
[\mathbf{K}]^{(i)}_{t=t_{0+\Delta{t}}}\{T\}_{t=t_{0+\Delta{t}}}^{(i)}
\\
\qquad\qquad\quad+\frac{\partial {[\mathbf{K}]^{(i)}_{t=t_{0+\Delta{t}}}} {\{T\}_{t=t_{0+\Delta{t}}}^{(i)}}}{\partial {\{T\}_{t=t_{0+\Delta{t}}}^{(i)}}}\{\Delta{T}\}_{t=t_{0+\Delta{t}}}^{(i)}
\tag{2.4.15}$$

$$
[\mathbf{M}]_{t=t_{0+\Delta{t}}}
\approx
[\mathbf{M}]_{t=t_{0+\Delta{t}}}^{(i)}
+
\frac{\partial {[\mathbf{M}]_{t=t_{0+\Delta{t}}}^{(i)}}}{\partial \{T\}_{t=t_{0+\Delta{t}}}^{(i)}}
\{\Delta{T}\}_{t=t_{0+\Delta{t}}}^{(i)}
\tag{2.4.16}$$

式(2.4.14)(2.4.15)(2.4.16)を式(2.4.13)に代入して二次以上の項を省略すると次式を得る。

$$
\left(\frac{[\mathbf{M}]_{t=t_{0+\Delta{t}}}^{(i)}}{\Delta{t}}
+
\frac{\partial {[\mathbf{M}]_{t=t_{0+\Delta{t}}}^{(i)}}
\{T\}_{t=t_{0+\Delta{t}}}^{(i)}
}{\partial \{T\}_{t=t_{0+\Delta{t}}}^{(i)}}
\frac{ \{T\}_{t=t_{0+\Delta{t}}}^{(i)}-\{T\}_{t=t_{0}}}{\Delta{t}}
+
\frac{\partial {[\mathbf{K}]^{(i)}_{t=t_{0+\Delta{t}}}} {\{T\}_{t=t_{0+\Delta{t}}}^{(i)}}}{\partial {\{T\}_{t=t_{0+\Delta{t}}}^{(i)}}}
\right)
\{\Delta{T}\}_{t=t_{0+\Delta{t}}}^{(i)}\\
=
\{F\}_{t=t_0+\Delta{t}}
-
[\mathbf{M}]_{t=t_{0+\Delta{t}}}^{(i)}
\frac{ \{T\}_{t=t_{0+\Delta{t}}}^{(i)}-\{T\}_{t=t_{0}}}{\Delta{t}}
-
[\mathbf{K}]_{t=t_{0+\Delta{t}}}^{(i)}
\{T\}_{t=t_{0+\Delta{t}}}^{(i)}
\tag{2.4.17}$$

さらに左辺の係数マトリクスを次式をもちいて近似評価する。

$$
[\mathbf{K}^{*}]^{(i)}
=
\frac{[\mathbf{M}]_{t=t_0+\Delta{t}}^{(i)}}{\Delta{t}}
+
\frac{\partial{[\mathbf{K}]_{t=t_0+\Delta{t}}^{(i)}}}{\partial{\{T\}^{(i)}_{t=t_0+\Delta{t}}}}\{T\}^{(i)}_{t=t_0+\Delta{t}}\\
=
\frac{[\mathbf{M}]_{t=t_0+\Delta{t}}^{(i)}}{\Delta{t}}
+
[\mathbf{K}_{T}]^{(i)}_{t=t_0+\Delta{t}}
\tag{2.4.18}$$

ここで$[\mathbf{K}\_{T}]^{(i)}\_{t=t_0+\Delta{t}}$は接線剛性マトリクスである。

結局次式を用いて反復計算を行うことによって時刻 $t=t\_0+\Delta{t}$での温度を計算することができる。

$$
[\mathbf{K}^{*}]^{(i)}\{T\}_{t=t_{0+\Delta{t}}}^{(i)}
\qquad\qquad\qquad\qquad\qquad\qquad\qquad\qquad\\
=\{F\}_{t=t_0+\Delta{t}}
-
[\mathbf{M}]_{t=t_{0+\Delta{t}}}^{(i)}
\frac{ \{T\}_{t=t_{0+\Delta{t}}}^{(i)}-\{T\}_{t=t_{0}}}{\Delta{t}}
-
[\mathbf{K}]^{(i)}\{T\}_{t=t_{0+\Delta{t}}}^{(i)}
\tag{2.4.19}$$

特に定常解析においては次式を用いて反復計算を行う。

$$
[\mathbf{K}_{T}]^{(i)}\{\Delta{T}\}^{(i)}_{t=\infty}=\{F\}_{t=\infty}
-
[\mathbf{K}_{T}]^{(i)}
\{\Delta{T}\}^{(i)}_{t=\infty}\\

\{T\}_{t=\infty}^{(i+1)}=
\{T\}_{t=\infty}^{(i)}
+\{\Delta{T}\}_{t=\infty}^{(i)}

\tag{2.4.20}$$

非定常解析において時間増分⊿ｔの選び方は、時間に関する離散化に陰解法を採用しているので、一般にその大きさの制約を受けない。ただし時間増分⊿ｔが大きすぎると、反復計算における収束回数は増加する。そこで本プログラムは、反復計算過程における残差ベクトルの大きさをつねにモニターし、反復計算の収束がおそすぎれば時間増分⊿ｔを減少させ、反復計算回数が少なくなると時間増分⊿ｔを増加される自動増分機能を備えている。

