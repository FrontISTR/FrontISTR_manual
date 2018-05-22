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

# Frequency Response Analysis

## Formulation

When damping is not considered, the equations of motion for natural frequancy analysis are given by

$$
\begin{equation}
M \ddot{U} + K U = 0
\label{eq:2.6.1}
\end{equation}
$$

In the frequency domain, the solution of equation $\eqref{eq:2.6.1}$ can be expressed by

$$
\begin{equation}
U = U_j e^{i \omega_j t}
\label{eq:2.6.2}
\end{equation}
$$

Substituting equation $\eqref{eq:2.6.2}$ into equation $\eqref{eq:2.6.1}$ gives

$$
\begin{equation}
K U_j = \omega_j^2 M U_j
\label{eq:2.6.3}
\end{equation}
$$

The following derivation shows that the natural frequency is a real value. Substituting 。$\omega_j^2 = \lambda_j$ into equation $\eqref{eq:2.6.3}$ and complex conjugates are given by

$$
\begin{align}
K U_j &= \lambda_j M U_j \nonumber \\\
K \overline{U_J} &= \overline{\lambda_J} M \overline{U_J}
\label{eq:2.6.4}
\end{align}
$$

Multiplying equation $\eqref{eq:2.6.4}$ by $\overline{U_J}^\mathrm{T}$ gives

$$
\begin{align}
{U_j}^\mathrm{T} K \overline{U_J} &= \overline{\lambda_J} {U_j}^\mathrm{T} M \overline{U_J} \nonumber \\\
{\overline{U_J}}^\mathrm{T} K U_j &= \lambda_j \overline{U_J}^\mathrm{T} M U_j
\label{eq:2.6.5}
\end{align}
$$

Accordingly, we get

$$
\begin{equation}
0 = (\lambda_j - \overline{\lambda_J}) \overline{U_J}^\mathrm{T} M U_j
\label{eq:2.6.6}
\end{equation}
$$

Since mass matrix is a positive definite, we have the following relation for non-zero eigen vector.

$$
\begin{equation}
\overline{U_J} M U_j > 0
\label{eq:2.6.7}
\end{equation}
$$

Consequently, we get

$$
\begin{equation}
\lambda_j = \overline{\lambda_J}
\label{eq:2.6.8}
\end{equation}
$$

It also gives that ${\omega_j}^2 = \lambda_j$ is a real value. Let us consider two distinct eigenvalues.

$$
\begin{align}
K U_i &= \lambda_i M U_i \nonumber \\\
K U_j &= \lambda_j M U_j
\label{eq:2.6.9}
\end{align}
$$

From equation $\eqref{eq:2.6.9}$, we get

$$
\begin{equation}
(\lambda_i - \lambda_j) {U_j}^\mathrm{T} M U_j = 0
\label{eq:2.6.10}
\end{equation}
$$

In case the eigen values are distinct, we get

$$
\begin{equation}
{U_j}^\mathrm{T} M U_i = 0
\label{eq:2.6.11}
\end{equation}
$$

which means that the eigenvectors are said to be orthonormal with respect to the mass matrix. For the same eigenvectors, it can be easily handled by normalizing with respect to the mass matrix as shown by

$$
\begin{equation}
M \ddot{U} + C \dot{U} + K U = F
\label{eq:2.6.13}
\end{equation}
$$

Here we uses Rayleigh damping and the damping matrix can be obtained by

$$
\begin{equation}
C = \alpha M + \beta K
\label{eq:2.6.14}
\end{equation}
$$

By using the eigenvector obtained by eigenvalue analysis, the displacement in time domain can be expressed by

$$
\begin{equation}
U(t) = \sum_{i} b_i(t) U_i 
\label{eq:2.6.15}
\end{equation}
$$

Now, we determine $b_i(t)$ in case the external forces is a harmonic function.

$$
\begin{equation}
F(t) = \lbrace F_R + iF_I \rbrace e^{i\Omega t}
\label{eq:2.6.16}
\end{equation}
$$

Equation $\eqref{eq:2.6.13}$ can be considered forced vibration

$$
\begin{equation}
b_j(t) = (b_{jR} + b_{jI}) e^{j\Omega t}
\label{eq:2.6.17}
\end{equation}
$$

The real and imaginary parts of $b_i(t)$ are given by

$$
\begin{equation}
b_{jR} =
\frac{ {U_j}^\mathrm{T}F_R({\omega_j}^2 - \Omega^2) + {U_j}^\mathrm{T}F_I(\alpha+\beta{\omega_j}^2)\Omega }
     { ({\omega_j}^2 - \Omega^2)^2 + (\alpha + \beta{\omega_j}^2)^2 \Omega^2 }
\label{eq:2.6.18}
\end{equation}
$$

and 

$$
\begin{equation}
b_{jI} =
\frac{ {U_j}^\mathrm{T}F_I({\omega_j}^2 - \Omega^2) + {U_j}^\mathrm{T}F_R(\alpha+\beta{\omega_j}^2)\Omega }
     { ({\omega_j}^2 - \Omega^2)^2 + (\alpha + \beta{\omega_j}^2)^2 \Omega^2 }
\label{eq:2.6.19}
\end{equation}
$$
