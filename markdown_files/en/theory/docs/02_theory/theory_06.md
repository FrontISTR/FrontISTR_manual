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
