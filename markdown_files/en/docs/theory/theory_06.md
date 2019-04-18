*** Last updated 2019-04-18 ***

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
<script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML' async></script>

# Frequency Response Analysis

## Formulation

The motion equation of frequency response analysis when damping is not considered becomes as follows: 

$$
\begin{equation}
M \ddot{U} + K U = 0
\label{eq:2.6.1}
\end{equation}
$$

If this is expanded for each eigenmode, it becomes

$$
\begin{equation}
U = U_j e^{i \omega_j t}
\label{eq:2.6.2}
\end{equation}
$$

If this is substituted into Eq.$\eqref{eq:2.6.1}$, the following equation is obtained:

$$
\begin{equation}
K U_j = \omega_j^2 M U_j
\label{eq:2.6.3}
\end{equation}
$$

The following is the proof that this eigenfrequency is real. By defining $\omega_j^2 = \lambda_j$ removing the complex conjugate of Eq.$\eqref{eq:2.6.3}$, Eq.$\eqref{eq:2.6.4}$, the following equation is obtained:

$$
\begin{align}
K U_j &= \lambda_j M U_j \nonumber \\\
K \overline{U_J} &= \overline{\lambda_J} M \overline{U_J}
\label{eq:2.6.4}
\end{align}
$$

If this multiplied by $\overline{U_J}^\mathrm{T}$, the following equation is obtained:

$$
\begin{align}
{U_j}^\mathrm{T} K \overline{U_J} &= \overline{\lambda_J} {U_j}^\mathrm{T} M \overline{U_J} \nonumber \\\
{\overline{U_J}}^\mathrm{T} K U_j &= \lambda_j \overline{U_J}^\mathrm{T} M U_j
\label{eq:2.6.5}
\end{align}
$$

From Eq.$\eqref{eq:2.6.5}$, it becomes

$$
\begin{equation}
0 = (\lambda_j - \overline{\lambda_J}) \overline{U_J}^\mathrm{T} M U_j
\label{eq:2.6.6}
\end{equation}
$$

In this case, the mass matrix is a positive-definite symmetric matrix; thus,

$$
\begin{equation}
\overline{U_J} M U_j > 0
\label{eq:2.6.7}
\end{equation}
$$

holds for eigenvectors that are not zero vectors. Therefore,

$$
\begin{equation}
\lambda_j = \overline{\lambda_J}
\label{eq:2.6.8}
\end{equation}
$$

and ${\omega_j}^2 = \lambda_j$ becomes a real number. In this case, two different modes are analyzed.

$$
\begin{align}
K U_i &= \lambda_i M U_i \nonumber \\\
K U_j &= \lambda_j M U_j
\label{eq:2.6.9}
\end{align}
$$

From this, the following is obtained:

$$
\begin{equation}
(\lambda_i - \lambda_j) {U_j}^\mathrm{T} M U_j = 0
\label{eq:2.6.10}
\end{equation}
$$

If the eigenvalue is different, it becomes

$$
\begin{equation}
{U_j}^\mathrm{T} M U_i = 0
\label{eq:2.6.11}
\end{equation}
$$

That is, different eigenmodes are orthogonal to the mass matrix. The advantage of same modes is that if they are normalized for the mass matrix Eq.$\eqref{eq:2.6.12}$, the handling becomes easier.

$$
\begin{equation}
{U_i}^T M U_i = 1
\label{eq:2.6.12}
\end{equation}
$$

Further, the frequency response analysis is formulated when damping is considered. The motion equation to be analyzed is expressed in Eq. Eq.$\eqref{eq:2.6.13}$. 

$$
\begin{equation}
M \ddot{U} + C \dot{U} + K U = F
\label{eq:2.6.13}
\end{equation}
$$

The damping term, assuming a Rayleigh-type damping, can be expressed as Eq.$\eqref{eq:2.6.13}$.

$$
\begin{equation}
C = \alpha M + \beta K
\label{eq:2.6.14}
\end{equation}
$$

With the eigenvector obtained in eigenvalue analysis, the displacement vector can be expanded at time t as in Eq.$\eqref{eq:2.6.15}$:

$$
\begin{equation}
U(t) = \sum_{i} b_i(t) U_i 
\label{eq:2.6.15}
\end{equation}
$$

where the external force term,

$$
\begin{equation}
F(t) = \lbrace F_R + iF_I \rbrace e^{i\Omega t}
\label{eq:2.6.16}
\end{equation}
$$

defines $b_j(t)$ in the harmonic oscillator equation. The following motion equation Eq.$\eqref{eq:2.6.13}$ acquires the form of forced vibration holds:

$$
\begin{equation}
b_j(t) = (b_{jR} + b_{jI}) e^{j\Omega t}
\label{eq:2.6.17}
\end{equation}
$$

If the real and imaginary parts of the expansion coefficient of $b_i(t)$ are determined, it becomes Eq.$\eqref{eq:2.6.18}$ and Eq.$\eqref{eq:2.6.19}$:

$$
\begin{equation}
b_{jR} =
\frac{ {U_j}^\mathrm{T}F_R({\omega_j}^2 - \Omega^2) + {U_j}^\mathrm{T}F_I(\alpha+\beta{\omega_j}^2)\Omega }
     { ({\omega_j}^2 - \Omega^2)^2 + (\alpha + \beta{\omega_j}^2)^2 \Omega^2 }
\label{eq:2.6.18}
\end{equation}
$$

$$
\begin{equation}
b_{jI} =
\frac{ {U_j}^\mathrm{T}F_I({\omega_j}^2 - \Omega^2) + {U_j}^\mathrm{T}F_R(\alpha+\beta{\omega_j}^2)\Omega }
     { ({\omega_j}^2 - \Omega^2)^2 + (\alpha + \beta{\omega_j}^2)^2 \Omega^2 }
\label{eq:2.6.19}
\end{equation}
$$

