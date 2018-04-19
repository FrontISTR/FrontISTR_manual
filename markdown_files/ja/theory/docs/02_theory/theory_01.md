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

## 微小変形線形弾性静解析

ここでは微小変形理論に基づく弾性静解析についての定式化を示す。応力・ひずみ関係として線形弾性を仮定している。

### 基礎方程式

固体力学の平衡方程式、力学的境界条件、幾何学的境界条件（基本境界条件）は次式で与えられる（図2.1.1参照）。

$$
\nabla \cdot \sigma + \overline{b} = 0 \; in \; V
\tag{2.1.1}$$

$$
\sigma \cdot n = \overline{t} \; on \; S_t
\tag{2.1.2}$$

$$
u = \overline{u} \; on \; S_u
\tag{2.1.3}$$

ここで、$\sigma$は応力、$\overline{t}$は表面力、$S_t$は物体力であり、$S_t$は力学的境界、$S_u$は幾何学的境界を表す。

図 2.1.1 固体力学における境界値問題(微小変形問題)

微小変形問題におけるひずみ・変位関係式は次式で与えられる。

$$
\varepsilon = \nabla _s u
\tag{2.1.4}$$

また、線形弾性体での応力・ひずみ関係式（構成式）は次式で与えられる。

$$
\sigma = C : \varepsilon
\tag{2.1.5}$$

ここで$C$は4階の弾性テンソルである。

### 仮想仕事の原理

基礎方程式(2.1)、式(2.1.2)、式(2.1.3)と等価である、微小変形線形弾性問題についての仮想仕事の原理は次式のように表される。

$$
\int_V \sigma : \delta \varepsilon dV = \int_{S_t} \overline{t} \cdot \delta u dS + \int_V \overline{b} \cdot \delta u dV
\tag{2.1.6}$$

$$
\delta u = 0 \; on \; S_u
\tag{2.1.7}$$

さらに構成式(2.1.5)を考慮して式(2.1.6)は次式のように表される。

$$
\int_V (C : \varepsilon) : \delta \varepsilon dV = \int_{S_t} \overline{t} \cdot \delta u dS + \int_V \overline{b} \cdot \delta u dV
\tag{2.1.8}$$

式(2.1.8)において、$\varepsilon$はひずみテンソル、$C$は4階の弾性テンソルである。
ここで、応力テンソル$\sigma$とひずみテンソル$\varepsilon$を、
それぞれベクトル形式で$\hat{\sigma}$、$\hat{\varepsilon}$と表すと、構成式(2.1.5)は次式のように表される。

$$
\hat{\sigma} = D \hat{\varepsilon}
\tag{2.1.9}$$

ここで、$D$ は弾性マトリクスである。

ベクトル形式で表された応力$\hat{\sigma}$、$\hat{\varepsilon}$および式(2.1.9)を考慮して、式(2.1.8)は次式のように表わされる。

$$
\int_V \hat{\varepsilon}^T D \delta \hat{\varepsilon} dV = \int_{S_t}
\delta u^T \overline{t} dS + \int_V \delta u^T \overline{b} dV
\tag{2.1.10}$$

式(2.1.10)および式(2.1.7)が、本開発コードにおいて離散化される仮想仕事の原理である。

### 定式化

仮想仕事の原理式(2.1.10)を有限要素ごとに離散化して次式を得る。

$$
\sum_{e} = \int_{V^e} \hat{\varepsilon}^T D \delta \hat{\varepsilon} dV = \sum_{e} \int_{S^e_t}
\delta u^T \overline{t} dS + \sum_{e} \int_{V^e} \delta u^T \overline{b} dV
\tag{2.1.11}$$

要素ごとに、要素を構成する節点の変位を用いて変位場を次式のように内挿する。

$$u = \sum^m_{i=1} N_i u_i = N U
\tag{2.1.12}$$

このときひずみは、式(2.1.4)を用いて次式のように与えられる。

$$
\hat{\varepsilon} = B U
\tag{2.1.13}$$

式(2.1.12)、式(2.1.13)を式(2.1.11)に代入して、次式を得る。

$$
\sum_e \delta U^T ( \int_{V^e} B^T DB dV )
U = \sum_e \delta U^T \cdot \int_{S_t^e}
N^T \overline{t} dS + \sum_{e} \delta U^T \int_{V^e} N^T
\overline{b} dV
\tag{2.1.14}$$

式(2.1.14)は次式のようにまとめることができる。

$$
\delta U^T K U = \delta U^T F
\tag{2.1.15}$$

ここで、
式(2.1.16)、式(2.1.17)で定義されるマトリクスおよびベクトルの成分は、有限要素ごとに計算し、重ねあわせることができる。

$$
K = \sum_e \int_{V^e} B^T DB dV
\tag{2.1.16}$$

$$
F = \sum_e (\int_{S_t^e} N^T \overline{t} dS + \int_{V^e} N^T \overline{b} dV )
\tag{2.1.17}$$

式(2.1.15)が、任意の仮想変位$\delta U$について成立することにより次式を得る。

$$
K U = F
\tag{2.1.18}$$

一方、変位境界条件式(2.1.3)は次式のように表される。

$$
U = \overline{U}
\tag{2.1.19}$$

式(2.1.18)を拘束条件式(2.1.19)のもとで解くことにより、節点変位$U$を決定することができる。
