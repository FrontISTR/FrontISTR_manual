
## 周波数応答解析

### 定式化

減衰を考慮しない場合の周波数応答解析の運動方程式は式のようになる。

\[
\begin{equation}
M \ddot{U} + K U = 0
\label{eq:2.6.1}
\end{equation}
\]

これを固有モードごとに展開すると、

\[
\begin{equation}
U = U_j e^{i \omega_j t}
\label{eq:2.6.2}
\end{equation}
\]

となる。これを式\(\eqref{eq:2.6.1}\)に代入すると、

\[
\begin{equation}
K U_j = \omega_j^2 M U_j
\label{eq:2.6.3}
\end{equation}
\]

を得る。この固有振動数が実数になることを以下のように証明する。\(\omega_j^2 = \lambda_j\)とおき、式\(\eqref{eq:2.6.3}\)の複素共役をとると式\(\eqref{eq:2.6.4}\)を得る。

\[
\begin{equation}
K U_j = \lambda_j M U_j
K \overline{UJ} = \overline{\lambda_J} M \overline{U_J}
\label{eq:2.6.4}
\end{equation}
\]

これに\(\overline{U}_J^T\)をかけると、

\[
\begin{equation}
U_j^T K \overline{U}_J = \overline{\lambda}_J
U_j^T M \overline{U}_J
\overline{U}_J^T K U_j = \lambda_j \overline{U}_J^T M U_j
\label{eq:2.6.5}
\end{equation}
\]

を得る。式\(\eqref{eq:2.6.5}\)より、

\[
\begin{equation}
0 = ( \lambda_j - \overline{\lambda_J} ) \overline{U_J}^T M U_j
\label{eq:2.6.6}
\end{equation}
\]

となる。ここで、質量マトリクスは正定値対称なのでゼロベクトルでない固有ベクトルについて

\[
\begin{equation}
\overline{U_J} M U_j > 0
\label{eq:2.6.7}
\end{equation}
\]

が成り立つ。ゆえに、

\[
\begin{equation}
\lambda_j =\overline{\lambda_J}
\label{eq:2.6.8}
\end{equation}
\]

となり、\(\omega_j^2 = \lambda_j\)は実数となる。ここで、2つの違うモードについて考える。

\[
\begin{equation}
K U_i = \lambda_i M U_i
K U_j = \lambda_j M U_j
\label{eq:2.6.9}
\end{equation}
\]

これより、

\[
\begin{equation}
( \lambda_i - \lambda_j ) U_j^T M U_i = 0
\label{eq:2.6.10}
\end{equation}
\]

が得られ、固有値が異なる場合には、

\[
\begin{equation}
U_j^T M U_i = 0
\label{eq:2.6.11}
\end{equation}
\]

となる。すなわち異なる固有モードは質量マトリクスについて直交する。
同じモードについては質量マトリクスについて規格化する(式\(\eqref{eq:2.6.12}\))ことによって取り扱いが容易になる利点がある。

\[
\begin{equation}
U_i^T M U_i = 1
\label{eq:2.6.12}
\end{equation}
\]

次に、減衰を考慮した場合の周波数応答解析についての定式化を示す。対象とする運動方程式を式\(\eqref{eq:2.6.13}\)に示す。

\[
\begin{equation}
M \ddot{U} + C \dot{U} + K U = F
\label{eq:2.6.13}
\end{equation}
\]

ここでの減衰項はRayleigh型を想定して\(\eqref{eq:2.6.14}\)のようにして表せるものとする。

\[
\begin{equation}
C = \alpha M + \beta K
\label{eq:2.6.14}
\end{equation}
\]

固有値解析で得られた固有ベクトルにより変位ベクトルは時刻*t*において式\(\eqref{eq:2.6.15}\)のように展開できる。

\[
\begin{equation}
U(t) = \sum_i b_i(t) U_i
\label{eq:2.6.15}
\end{equation}
\]

このとき、外力項が調和振動子式の

\[
\begin{equation}
F(t) = ( F_R + i F_I )e^{i \Omega t}
\label{eq:2.6.16}
\end{equation}
\]

場合において\(b_{j}(t)\)を決定する。運動方程式\(\eqref{eq:2.6.13}\)は強制振動の形になるので

\[
\begin{equation}
b_j (t) = (b_{jR} + b_{jI}) e^{i \Omega t}
\label{eq:2.6.17}
\end{equation}
\]

が成り立つ。\(b_{j}(t)\)の展開係数の実部および虚部を求めると式\(\eqref{eq:2.6.18}i\)および式\(\eqref{eq:2.6.19}\)の形になる。

\[
\begin{equation}
b_{jR} = \frac{ U^T_j F_R (\omega^2_j - \Omega^2) + U^T_j F_I (\alpha + \beta \omega_j^2) \Omega}{ (\omega^2_j - \Omega^2)^2 + (\alpha + \beta \omega_j^2)^2 \Omega^2}
\label{eq:2.6.18}
\end{equation}
\]

\[
\begin{equation}
b_{jI} = \frac{ U^T_j F_I(\omega^2_j - \Omega^2) - U^T_j F_R(\alpha + \beta \omega_j^2) \Omega}{ (\omega^2_j - \Omega^2)^2 + (\alpha + \beta \omega_j^2)^2 \Omega^2}
\label{eq:2.6.19}
\end{equation}
\]

となる。



