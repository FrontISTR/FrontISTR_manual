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

## 周波数応答解析

### 定式化

減衰を考慮しない場合の周波数応答解析の運動方程式は式のようになる。

$$
M \ddot{U} + K U = 0
\tag{2.6.1}$$

これを固有モードごとに展開すると、

$$
U = U_j e^{i \omega_j t}
\tag{2.6.2}$$

となる。これを式(2.6.1)に代入すると、

$$
K U_j = \omega_j^2 M U_j
\tag{2.6.3}$$

を得る。この固有振動数が実数になることを以下のように証明する。$\omega_j^2 = \lambda_j$とおき、式(2.6.3)の複素共役をとると式(2.6.4)を得る。

$$
K U_j = \lambda_j M U_j
K \overline{UJ} = \overline{\lambda_J} M \overline{U_J}
\tag{2.6.4}$$

これに$\overline{U_J}^T$をかけると、

$$
U_j^T K \overline{U_J} = \overline{\lambda_J}
U_j^T M \overline{U_J}

\overline{U_J}^T K U_j = \lambda_j \overline{U_J}^T M U_j
\tag{2.6.5}$$

を得る。式(2.6.5)より、

$$
0 = ( \lambda_j - \overline{\lambda_J} ) \overline{U_J}^T M U_j
\tag{2.6.6}$$

となる。ここで、質量マトリクスは正定値対称なのでゼロベクトルでない固有ベクトルについて

$$
\overline{U_J} M U_j > 0
\tag{2.6.7}$$

が成り立つ。ゆえに、

$$
\lambda_j =\overline{\lambda_J}
\tag{2.6.8}$$

となり、$\omega_j^2 = \lambda_j$は実数となる。ここで、2つの違うモードについて考える。

$$
K U_i = \lambda_i M U_i
K U_j = \lambda_j M U_j
\tag{2.6.9}$$

これより、

$$
( \lambda_i - \lambda_j ) U_j^T M U_i = 0
\tag{2.6.10}$$

が得られ、固有値が異なる場合には、

$$
U_j^T M U_i = 0
\tag{2.6.11}$$

となる。すなわち異なる固有モードは質量マトリクスについて直交する。
同じモードについては質量マトリクスについて規格化する(式(2.6.12))ことによって取り扱いが容易になる利点がある。

$$
U_i^T M U_i = 1
\tag{2.6.12}$$

次に、減衰を考慮した場合の周波数応答解析についての定式化を示す。対象とする運動方程式を式(2.6.13)に示す。

$$
M \ddot{U} + C} \dot{U} + K U = F
\tag{2.6.13}$$

ここでの減衰項はRayleigh型を想定して(2.6.14)のようにして表せるものとする。

$$
C = \alpha M + \beta K
\tag{2.6.14}$$

固有値解析で得られた固有ベクトルにより変位ベクトルは時刻*t*において式(2.6.15)のように展開できる。

$$
U(t) = \sum_i b_i(t) U_i
\tag{2.6.15}$$

このとき、外力項が調和振動子式の

$$
F(t) = ( F_R + i F_I )e^{i \Omega t}
\tag{2.6.16}$$

場合において$b_{j}(t)$を決定する。運動方程式(2.6.13)は強制振動の形になるので

$$
b_j (t) = (b_{jR} + b_{jI}) e^{i \Omega t}
\tag{2.6.17}$$

が成り立つ。$b_{j}(t)$の展開係数の実部および虚部を求めると式(2.6.18)および式(2.6.19)の形になる。

$$
b_{jR} = \frac{ U^T_j F_R (\omega^2_j - \Omega^2) + U^T_j F_I (\alpha + \beta \omega_j^2) \Omega}{ (\omega^2_j - \Omega^2)^2 + (\alpha + \beta \omega_j^2)^2 \Omega^2}
\tag{2.6.18}$$

$$
b_{jI} = \frac{ U^T_j F_I(\omega^2_j - \Omega^2) - U^T_j F_R(\alpha + \beta \omega_j^2) \Omega}{ (\omega^2_j - \Omega^2)^2 + (\alpha + \beta \omega_j^2)^2 \Omega^2}
\tag{2.6.19}$$

となる。
