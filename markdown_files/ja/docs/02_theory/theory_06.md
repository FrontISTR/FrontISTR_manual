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

## 周波数応答解析

### 定式化

減衰を考慮しない場合の周波数応答解析の運動方程式は式のようになる。

$$
\mathbf{M}\ \ddot{\mathbf{U}} + \mathbf{\text{KU}} = \mathbf{0}
\tag{2.6.1}$$

これを固有モードごとに展開すると、

$$
\mathbf{U} = \mathbf{U}_{j}e^{i\omega_{j}t}
\tag{2.6.2}$$

となる。これを式(2.6.1)に代入すると、

$$
\mathbf{K}\mathbf{U}_{j} = \omega_{j}^{2}\mathbf{M}\mathbf{U}_{j}
\tag{2.6.3}$$

を得る。この固有振動数が実数になることを以下のように証明する。$\omega\_{j}^{2} = \lambda\_{j}$とおき、式(2.6.3)の複素共役をとると式(2.6.4)を得る。

$$
\mathbf{K}\ \mathbf{U}_{j} = \lambda_{j}\mathbf{M}\mathbf{U}_{j}
\\
\mathbf{K}
\overline{{\mathbf{U}_{J}} }= \overline{{\lambda_{J}}}\mathbf{M}\overline{{\mathbf{U}_{J}}}
\tag{2.6.4}$$

これに${\overline{\mathbf{U}\_{J}}}^{T}$をかけると、

$$
\mathbf{U}_{j}^{T}\mathbf{K}\overline{{\mathbf{U}_{J}}} = \overline{\lambda_{J}}
\mathbf{U}_{j}^{T}\mathbf{M}\overline{\mathbf{U}_{J}}\\
\overline{\mathbf{U}_{J}}^{T}\mathbf{K}\mathbf{U}_{j} = \lambda_{j}\overline{\mathbf{U}_{J}}^T\mathbf{M}\mathbf{U}_{j}
\tag{2.6.5}$$

を得る。式(2.6.5)より、

$$
0 = \left( \lambda_{j} - \overline{\lambda_{J}} \right)\overline{\mathbf{U}_{J}}^{T}\mathbf{M}\mathbf{U}_{j}
\tag{2.6.6}$$

となる。ここで、質量マトリクスは正定値対称なのでゼロベクトルでない固有ベクトルについて

$$
\overline{\mathbf{U}_{J}} \mathbf{M}\mathbf{U}_{j}\  > 0
\tag{2.6.7}$$

が成り立つ。ゆえに、

$$
\lambda_{j} =\overline{\lambda_{J}}
\tag{2.6.8}$$

となり、$\omega\_{j}^{2} = \lambda\_{j}$は実数となる。ここで、2つの違うモードについて考える。

$$
\mathbf{K}\mathbf{U}_{i} = \lambda_{i}\ \mathbf{\text{M}}\mathbf{U}_{i}\\
\mathbf{K}\mathbf{U}_{j}\  = \lambda_{j}\ \mathbf{\text{M }}\mathbf{U}_{j}
\tag{2.6.9}$$

これより、

$$
\left( \lambda_{i} - \lambda_{j} \right)\mathbf{U}_{j}^{T}\mathbf{M}\mathbf{U}_{i} = 0
\tag{2.6.10}$$

が得られ、固有値が異なる場合には、

$$
\mathbf{U}_{j}^{T}\mathbf{\text{M}}\mathbf{U}_{i} = 0
\tag{2.6.11}$$

となる。すなわち異なる固有モードは質量マトリクスについて直交する。同じモードについては質量マトリクスについて規格化する(式(2.6.12))ことによって取り扱いが容易になる利点がある。

$$
\mathbf{U}_{i}^{T}\ \mathbf{M}\mathbf{U}_{i}\  = 1
\tag{2.6.12}$$

次に、減衰を考慮した場合の周波数応答解析についての定式化を示す。対象とする運動方程式を式(2.6.13)に示す。

$$
\mathbf{M}\ \ddot{\mathbf{U}} + \mathbf{C}\ \dot{\mathbf{U}} +\mathbf{\text{KU}} = \mathbf{F}
\tag{2.6.13}$$

ここでの減衰項はRayleigh型を想定して(2.6.14)のようにして表せるものとする。

$$
\mathbf{C} = \alpha \mathbf{M} + \beta \mathbf{K}
\tag{2.6.14}$$

固有値解析で得られた固有ベクトルにより変位ベクトルは時刻*t*において式(2.6.15)のように展開できる。

$$
\mathbf{U}(t) = \sum_{i}^{}b_{i}(t) \mathbf{U}_{i}
\tag{2.6.15}$$

このとき、外力項が調和振動子式の

$$
\mathbf{F}(t) =\left\{ \mathbf{F}_{R}+i \mathbf{F}_{I} \right\}e^{i \Omega t}
\tag{2.6.16}$$

場合において$b_{j}(t)$を決定する。運動方程式(2.6.13)は強制振動の形になるので

$$
b_{j}(t) =(b_{jR}+b_{jI})e^{i \Omega t}
\tag{2.6.17}$$

が成り立つ。$b_{j}(t)$の展開係数の実部および虚部を求めると式(2.6.18)および式(2.6.19)の形になる。

$$
b_{jR} =\frac{ \mathbf{U}^{T}_{j} \mathbf{F}_{R}(\omega^{2}_{j}-\Omega^{2})+\mathbf{U}^{T}_{j} \mathbf{F}_{I}(\alpha
  + \beta \omega_{j}^{2})\Omega}{ (\omega^{2}_{j}-\Omega^{2})^{2}+(\alpha + \beta\omega_{j}^{2})^{2}\Omega^{2}}
\tag{2.6.18}$$

$$
b_{jI} =\frac{ \mathbf{U}^{T}_{j} \mathbf{F}_{I}(\omega^{2}_{j}-\Omega^{2})-\mathbf{U}^{T}_{j} \mathbf{F}_{R}(\alpha
  + \beta \omega_{j}^{2})\Omega}{ (\omega^{2}_{j}-\Omega^{2})^{2}+(\alpha + \beta\omega_{j}^{2})^{2}\Omega^{2}}
\tag{2.6.19}$$

となる。
