<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {
    inlineMath: [['$','$'], ['\\(','\\)']],
    processEscapes: true},
  CommonHTML: { matchFontHeight: true },
  displayAlign: "center"
});
</script>
<script async src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML"></script>

## 微小変形線形弾性静解析

ここでは微小変形理論に基づく弾性静解析についての定式化を示す。応力・ひずみ関係として線形弾性を仮定している。

### 基礎方程式

固体力学の平衡方程式、力学的境界条件、幾何学的境界条件（基本境界条件）は次式で与えられる（図
2.1.1参照）。

$$
\nabla \bullet \boldsymbol{\sigma} + \overline{\mathbf{b}} = 0 \quad in \quad V
\tag{2.1.1}$$

$$
\boldsymbol{\sigma} \bullet \mathbf{n} = \overline{\mathbf{t}} \quad on \quad S_t
\tag{2.1.2}$$

$$
\mathbf{u} = \overline{\mathbf{u}} \quad on \quad S_u
\tag{2.1.3}$$

ここで、$\sigma$は応力、$\overline{t}$は表面力、$S_t$は物体力であり、$S_t$は力学的境界、$S_u$は幾何学的境界を表す。

![](media/image9.png){width="1.7902777777777779in"
height="1.7083333333333333in"}

図 2.1.1　固体力学における境界値問題(微小変形問題)

微小変形問題におけるひずみ・変位関係式は次式で与えられる。

$$
\boldsymbol{\varepsilon} = \nabla _s \mathbf{u}
\tag{2.1.4}$$

また、線形弾性体での応力・ひずみ関係式（構成式）は次式で与えられる。

$$
\boldsymbol{\sigma}= \mathbf{C:}\boldsymbol{ \varepsilon}
\tag{2.1.5}$$

ここで$\mathbf{C}$は4階の弾性テンソルである。

### 仮想仕事の原理

基礎方程式(2.1)(2.1.2)(2.1.3)と等価である、微小変形線形弾性問題についての仮想仕事の原理は次式のように表される。

$$
\int_{V}\boldsymbol{\sigma :} \delta \boldsymbol{\varepsilon}dV = \int_{S_{t}} \overline{\mathbf{t}} \bullet
  \delta \mathbf{u} dS + \int_{V} \overline{\mathbf{b}} \bullet \delta \mathbf{u} dV
\tag{2.1.6}$$

$$
\delta\mathbf{ u} = 0 \quad on \quad S_u
\tag{2.1.7}$$

さらに構成式(2.1.5)を考慮して式(2.1.6)は次式のように表される。

$$
\int_V (\mathbf{C}\boldsymbol{: \varepsilon} ) : \delta \boldsymbol{\varepsilon} dV = \int_{S_t}
  \overline{\mathbf{t}} \bullet \delta \mathbf{u} dS + \int_V \overline{\mathbf{b}} \bullet \delta \mathbf{u}
  dV
\tag{2.1.8}$$

式(2.1.8)において、$\boldsymbol{\varepsilon}$はひずみテンソル、$\mathbf{C}$は4階の弾性テンソルである。ここで、応力テンソル$\boldsymbol{\sigma}$とひずみテンソル!$\boldsymbol{\varepsilon}$を、それぞれベクトル形式で!
$\hat{\boldsymbol{\sigma}}$、$\hat{\boldsymbol{\varepsilon}}$と表すと、構成式(2.1.5)は次式のように表される。

$$
\hat{\boldsymbol{\sigma}} = \mathbf{D} \hat{\boldsymbol{\varepsilon}}
\tag{2.1.9}$$

ここで、**D** は弾性マトリクスである。

ベクトル形式で表された応力$\hat{\boldsymbol{\sigma}}$、$\hat{\boldsymbol{\varepsilon}}$および式(2.1.9)を考慮して、式(2.1.8)は次式のように表わされる。

$$
\int_V \hat{\boldsymbol{\varepsilon}}^T \mathbf{D} \delta \hat{\boldsymbol{\varepsilon}} dV = \int_{S_t}
  \delta\mathbf{u}^T \overline{\mathbf{t}} dS + \int_V \delta\mathbf{ u}^T\overline{\mathbf{b}}dV
\tag{2.1.10}$$

式(2.1.10)および式(2.1.7)が、本開発コードにおいて離散化される仮想仕事の原理である。

### 定式化

仮想仕事の原理式(2.1.10)を有限要素ごとに離散化して次式を得る。

$$
\sum_{e}
  \int_{V^e}\hat{\boldsymbol{\varepsilon}}^T\mathbf{D}\delta\hat{\boldsymbol{\varepsilon}}dV=\sum_{e}\int_{S^e_t}
   \delta\mathbf{u}^T \overline{\mathbf{t}} dS + \sum_{e}\int_{V^e} \delta\mathbf{
     u}^T\overline{\mathbf{b}}dV
\tag{2.1.11}$$

要素ごとに、要素を構成する節点の変位を用いて変位場を次式のように内挿する。

$$\mathbf{u}=\sum^{m}_{i=1}N_i\mathbf{u}_i=\mathbf{NU}
\tag{2.1.12}$$

このときひずみは、式(2.1.4)を用いて次式のように与えられる。

$$
\hat{\boldsymbol{\varepsilon}}=\mathbf{BU}
\tag{2.1.13}$$

式(2.1.12)(2.1.13)を式(2.1.11)に代入して、次式を得る。

$$
\sum_{e}\delta \mathbf{U^T}\left(\int_{V^e}\mathbf{B^T DB}dV\right)
\mathbf{U}=\sum_{e}\delta \mathbf{U^T}\bullet\int_{S^e_t}
\mathbf{N^T} \overline{\mathbf{t}} dS + \sum_{e}\delta \mathbf{U^T}\int_{V^e} \mathbf{N^T}
\overline{\mathbf{b}}dV
\tag{2.1.14}$$

式(2.1.14)は次式のようにまとめることができる。

$$
\delta \mathbf{U^T}\mathbf{KU}=\delta \mathbf{U^T}\mathbf{F}
\tag{2.1.15}$$

ここで

$$
\mathbf{K}=\sum_{e}\int_{V^e}\mathbf{B^T DB}dV
\tag{2.1.16}$$

$$
\mathbf{F}=\sum_{e}\left(\int_{S^e_t}\mathbf{N^T} \overline{\mathbf{t}} dS +  \int_{V^e} \mathbf{N^T}\overline{\mathbf{b}}dV\right)
\tag{2.1.17}$$


式(2.1.16)(2.1.17)で定義されるマトリクスおよびベクトルの成分は、有限要素ごとに計算し、重ねあわせることができる。

式(2.1.15)が、任意の仮想変位$\delta{U}$について成立することにより次式を得る。

$$
\mathbf{KU}=\mathbf{F}
\tag{2.1.18}$$

一方、変位境界条件式(2.1.3)は次式のように表される。

$$
\mathbf{U}=\overline{\mathbf{U}}
\tag{2.1.19}$$

式(2.1.18)を拘束条件式(2.1.19)のもとで解くことにより、節点変位$\mathbf{U}$を決定することができる。
