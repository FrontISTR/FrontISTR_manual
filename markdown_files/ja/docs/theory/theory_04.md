
## 熱伝導解析

本開発コードで用いられる有限要素法（Finite ElementMethod）による固体についての熱伝導解析手法を示す。

### 基礎方程式

連続体中での熱伝導方程式は以下のようになる。

\[
\begin{equation}
  \rho c \frac{\partial T}{\partial t} =
  \frac{\partial}{\partial x}\left(k_x \frac{\partial T}{\partial x}\right)
+ \frac{\partial}{\partial y}\left(k_y \frac{\partial T}{\partial y}\right)
+ \frac{\partial}{\partial z}\left(k_z \frac{\partial T}{\partial z}\right) + Q
\label{eq:2.4.1}
\end{equation}
\]

ここで、\(\rho=\rho(x)\)は質量（密度）、\(c=c(x,T)\)は比熱、\(T=T(x,t)\)は温度、\(k=k(x,T)\)は熱伝導率、\(Q=Q(x,T,t)\)は発熱量、
\(x\)は位置、\(T\)は温度、\(t\)は時間を表す。

考慮している領域を\(S\)、その周囲を\(\Gamma\)とする。
\(\Gamma\)上では、Dirichet型かNeumann型のいずれかの境界条件が、いたるところで与えられるものと仮定すると境界条件は以下のようになる。

\[
\begin{equation}
T = T_1(x,t), \; x \in \Gamma_1
\label{eq:2.4.2}
\end{equation}
\]

\[
\begin{equation}
k \frac{\partial T}{\partial n} = q(x,T,t), \; x \in \Gamma_2
\label{eq:2.4.3}
\end{equation}
\]

ただし、\(T_1\)，\(q\)は関数形が既知とする。\(q\)は境界からの流出熱流束である。
本プログラムでは、3種類の熱流束が考慮できる。

\[
\begin{equation}
q=-q_s+q_c+q_r
\label{eq:2.4.4}
\end{equation}
\]

\[
\begin{equation}
q_s=q_s(x,t)
\label{eq:2.4.5}
\end{equation}
\]

\[
\begin{equation}
q_c=hc(T-Tc)
\label{eq:2.4.6}
\end{equation}
\]

\[
\begin{equation}
q_r=hr(T^4-Tr^4)
\label{eq:2.4.7}
\end{equation}
\]

ここで、\(q_s\)は分布熱流束、\(q_c\)は対流熱伝達による熱流束、\(q_r\)は輻射熱伝達による熱流束である。

ただし、
\(Tc=Tc(x,t)\)は対流熱伝達率雰囲気温度、
\(hc=hc(x,t)\)は対流熱伝達係数、
\(Tr=Tr(x,t)\)は輻射熱伝達率雰囲気温度、
\(hr=\varepsilon \sigma F = {hr(x,t)}\)は輻射熱伝達係数、
\(\varepsilon\)は輻射率，\(\sigma\)はStefanBoltzmann定数、\(F\)は形態係数である．

### 離散化

方程式\(\eqref{eq:2.4.1}\)をGalerkin法によって離散化すると、

\[
\begin{equation}
K T + M \frac{\partial T}{\partial t} = F
\label{eq:2.4.8}
\end{equation}
\]

ただし、

\[
\begin{equation}
K = \int\left( k_x \frac{\partial N^T}{\partial x}\frac{\partial N}{\partial x}
+ k_y \frac{\partial N^T}{\partial y}\frac{\partial N}{\partial y}
+ k_z \frac{\partial N^T}{\partial z}\frac{\partial N}{\partial z} \right) dV
+ \int hc N^T N ds + \int hr N^T N ds
\label{eq:2.4.9}
\end{equation}
\]

\[
\begin{equation}
M = \int \rho c N^T N dV
\label{eq:2.4.10}
\end{equation}
\]

\[
\begin{equation}
F = \int Q N^T dV - \int q_s N^T dS
+ \int{hc} T c N^T dS
+ \int{hcTr} ({T+Tr}) ({T^2 + T r^2}) N^T dS
\label{eq:2.4.11}
\end{equation}
\]

\[
\begin{equation}
N = (N^1, N^2, \ldots, Ni)
\label{eq:2.4.12}
\end{equation}
\]

方程式\(\eqref{eq:2.4.8}\)は非線形かつ非定常の方程式である。
いま、時間に関して後退オイラー法により離散化して、時刻\(t=t_0\)における温度が既知のとき時刻\(t=t_{0+\Delta t}\)での温度を次式を用いて計算することにする。

\[
\begin{equation}
K_{t=t_{0+\Delta t}} T_{t=t_{0+\Delta t}} + M_{t=t_{0 + \Delta t}} \frac{T_{t=t_{0 + \Delta t}} - T_{t=t_0}}{\Delta t} = F_{t=t_{0+\Delta t}}
\label{eq:2.4.13}
\end{equation}
\]

ここでの式\(\eqref{eq:2.4.13}\)を近似的にみたす温度ベクトル\(T_{t=t_{0+\Delta t}}^{(i)}\)
を改善して、精度の良い解\(T_{t=t_{0+\Delta t}}^{(i)+1}\)を求めることを考える。

そのために、まず、温度ベクトルを次のようにあらわす。

\[
\begin{equation}
T_{t=t_{0+\Delta t}}=
T_{t=t_{0+\Delta t}}^{(i)} + \Delta T_{t=t_{0+\Delta t}}^{(i)}
\label{eq:2.4.14}
\end{equation}
\]

熱伝導マトリクスと温度ベクトルとの積、質量マトリクスなどを次式のように近似的にあらわす。

\[
\begin{equation}
K_{t=t_{0+\Delta t}} T_{t=t_{0+\Delta t}}
K_{t=t_{0+\Delta t}}^{(i)} T_{t=t_{0+\Delta t}}^{(i)}
\frac{\partial K_{t=t_{0+\Delta t}}^{(i)}}{T_{t=t_{0+\Delta t}}^{(i)}}
\partial T_{t=t_{0+\Delta t}}^{(i)} \Delta T_{t=t_{0+\Delta t}}^{(i)}
\label{eq:2.4.15}
\end{equation}
\]

\[
\begin{equation}
M_{t=t_{0+\Delta t}}
M_{t=t_{0+\Delta t}}^{(i)}
+ \frac{\partial M_{t=t_{0+\Delta t}}^{(i)}}{\partial T_{t=t_{0+\Delta t}}^{(i)}}
\Delta T_{t=t_{0+\Delta t}}^{(i)}
\label{eq:2.4.16}
\end{equation}
\]

式\(\eqref{eq:2.4.14}\)、式\(\eqref{eq:2.4.15}\)、式\(\eqref{eq:2.4.16}\)を式\(\eqref{eq:2.4.13}\)に代入して二次以上の項を省略すると次式を得る。

\[
\begin{equation}
(\frac{M_{t=t_{0+\Delta t}}^{(i)}}{\Delta t}
+ \partial M_{t=t_{0+\Delta t}}^{(i)} T_{t=t_{0+\Delta t}}^{(i)}
\partial T_{t=t_{0+\Delta t}}^{(i)}
\frac{T_{t=t_{0+\Delta t}}^{(i)} - T_{t=t_0}}{\Delta t}
+ \frac{\partial K_{t=t_{0+\Delta t}}^{(i)}}{T_{t=t_{0+\Delta t}}^{(i)}}
\partial T_{t=t_{0+\Delta t}}^{(i)})
\Delta T_{t=t_{0+\Delta t}}^{(i)} \\\ 
= F_{t=t_0+\Delta t} - M_{t=t_{0+\Delta t}}^{(i)}
\frac{T_{t=t_{0+\Delta t}}^{(i)} - T_{t=t_0}}{\Delta t}
- K_{t=t_{0+\Delta t}}^{(i)} T_{t=t_{0+\Delta t}}^{(i)}
\label{eq:2.4.17}
\end{equation}
\]


さらに左辺の係数マトリクスを次式を用いて近似評価する。

\[
K^{(i)} = \frac{M_{t=t_0+\Delta t}^{(i)}}{\Delta t} +
\frac{\partial K_{t=t_0+\Delta t}^{(i)}}{\partial T^{(i)}_{t=t_0+\Delta t}}
\]

\[
\begin{equation}
T_{t=t_0+\Delta t}^{(i)}
= \frac{M_{t=t_0+\Delta t}^{(i)}}{\Delta t} + K_{T_{t=t_0+\Delta t}^{(i)}}
\label{eq:2.4.18}
\end{equation}
\]

ここで\(K_{T_{t=t_0+\Delta t}}^{(i)}\)は接線剛性マトリクスである。

結局次式を用いて反復計算を行うことによって時刻 \(t=t_0+\Delta t\)での温度を計算することができる。

\[
\begin{equation}
K^{(i)} T_{t=t_{0+\Delta t}}^{(i)} = F_{t=t_0+\Delta t} - M_{t=t_{0+\Delta t}}^{(i)} \frac{T_{t=t_{0+\Delta t}}^{(i)} - T_{t=t_0}}{\Delta t} - K^{(i)} T_{t=t_{0+\Delta t}}^{(i)}
\label{eq:2.4.19}
\end{equation}
\]

特に定常解析においては次式を用いて反復計算を行う。

\[
K_T^{(i)} \Delta T_{t=\infty}^{(i)} = F_{t=\infty} - K_T^{(i)} \Delta T_{t=\infty}^{(i)}
\]

\[
\begin{equation}
T_{t=\infty}^{(i+1)} = T_{t=\infty}^{(i)} + \Delta{T}_{t=\infty}^{(i)}
\label{eq:2.4.20}
\end{equation}
\]

非定常解析において時間増分$\Delta t$の選び方は、時間に関する離散化に陰解法を採用しているので、一般にその大きさの制約を受けない。ただし時間増分\(\Delta t\)が大きすぎると、反復計算における収束回数は増加する。
そこで本プログラムは、反復計算過程における残差ベクトルの大きさをつねにモニターし、反復計算の収束がおそすぎれば時間増分\(\Delta t\)を減少させ、反復計算回数が少なくなると時間増分\(\Delta t\)を増加される自動増分機能を備えている。


