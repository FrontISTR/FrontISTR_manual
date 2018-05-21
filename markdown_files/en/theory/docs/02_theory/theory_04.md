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

# Heat Conduction Analysis

The heat conduction analysis method for solid by the finite element method used in this development code is shown in the following.

## Basic Equation

The heat conduction equation during the continuum is as follows.

$$
\begin{equation}
  \rho c \frac{\partial T}{\partial t} =
  \frac{\partial}{\partial x}\left(k_x \frac{\partial T}{\partial x}\right)
+ \frac{\partial}{\partial y}\left(k_y \frac{\partial T}{\partial y}\right)
+ \frac{\partial}{\partial z}\left(k_z \frac{\partial T}{\partial z}\right) + Q
\label{eq:2.4.1}
\end{equation}
$$

However,

|                  |                      |
|------------------|----------------------|
| $\rho = \rho(x)$ | Mass (Density)       |
| $c = c(x, T)$    | Specific heat        |
| $T=T(x, t)$      | Temperature          |
| $K=k(x, T)$      | Thermal conductivity |
| $Q=Q(x, T, t)$   | Calorific value      |

Herein, $x$ expresses the position, $T$ is the temperature and $t$ is the time.

The area being considered is $S$ and periphery is $\Gamma$. When assuming the boundary conditions of either the Dirichet type of the Neumann type is given everywhere on $\Gamma$, the boundary conditions become as follows.

$$
\begin{equation}
T = T_1(x,t), \; x \in \Gamma_1
\label{eq:2.4.2}
\end{equation}
$$

$$
\begin{equation}
k \frac{\partial T}{\partial n} = q(x,T,t), \; x \in \Gamma_2
\label{eq:2.4.3}
\end{equation}
$$

However, the function form $T_1$, $q$ is already known. $q$ is the heat flux outflow from the boundary. Three types of heat flux can be considered in this program.

$$
\begin{equation}
q=-q_s+q_c+q_r
\label{eq:2.4.4}
\end{equation}
$$

$$
\begin{equation}
q_s=q_s(x,t)
\label{eq:2.4.5}
\end{equation}
$$

$$
\begin{equation}
q_c=hc(T-Tc)
\label{eq:2.4.6}
\end{equation}
$$

$$
\begin{equation}
q_r=hr(T^4-Tr^4)
\label{eq:2.4.7}
\end{equation}
$$

$q_s$ is the distributed heat flux, $q_c$ is the heat flux by the convective heat transfer, and $q_r$ is the heat flux by the radiant heat transfer.

However,

|                                  |                                                          |
|----------------------------------|----------------------------------------------------------|
| $Tc=Tc(x,t)$                     | Convective heat transfer coefficient ambient temperature |
| $hc=hc(x,t)$                     | Convective heat transfer factor                          |
| $Tr=Tr(x,t)$                     | Radiant heat transfer coefficient ambient temperature    |
| $hr=\varepsilon\sigma F=hr(x,t)$ | Radiant heat transfer factor                             |

$\varepsilon$: Radiant rate, $\sigma$: Stefan-Boltzmann constant, $F$: Shape factor

## Discretization

When equation $\eqref{eq:2.4.1}$ is discretized by the Galerkin method, it becomes as follows.

$$
\begin{equation}
[K]\\{T\\} + [M] \frac{\partial T}{\partial t} = \\{F\\}
\label{eq:2.4.8}
\end{equation}
$$

However,

$$
\begin{align}
[K]
&= \int\left( k_x \frac{\partial \\{N\\}^T}{\partial x}\frac{\partial \\{N\\}}{\partial x}
+ k_y \frac{\partial \\{N\\}^T}{\partial y}\frac{\partial \\{N\\}}{\partial y}
+ k_z \frac{\partial \\{N\\}^T}{\partial z}\frac{\partial \\{N\\}}{\partial z} \right) dV \nonumber \\\
&+ \int hc \\{N\\}^T \\{N\\} ds + \int hr \\{N\\}^T \\{N\\} ds
\label{eq:2.4.9}
\end{align}
$$

$$
\begin{equation}
[M] = \int \rho c \\{N\\}^T \\{N\\} dV
\label{eq:2.4.10}
\end{equation}
$$

$$
\begin{align}
\\{F\\} 
&= \int Q \\{N\\}^T dV - \int q_s \\{N\\}^T dS
+ \int{hc} T c \\{N\\}^T dS \nonumber \\\
&+ \int{hcTr} ({T+Tr}) ({T^2 + T r^2}) \\{N\\}^T dS
\label{eq:2.4.11}
\end{align}
$$

$$
\begin{equation}
\\{N\\} = (N^1, N^2, \ldots, Ni) : Form\ function
\label{eq:2.4.12}
\end{equation}
$$

Equation $\eqref{eq:2.4.8}$ is a nonlinear and unsteady equation. Now, when the time is discretized by the backward Euler's rule and the temperature at time $t = t_0$ is already known, the temperature at $t = t_{0+\Delta t}$ is calculated using the following equation.

$$
\begin{equation}
[K]\_{t=t\_{0+\Delta t}} \\{T\\}\_{t=t\_{0+\Delta t}} + [M]\_{t=t\_{0+\Delta t}}
\frac{\\{T\\}_{t=t\_{0+\Delta t}} - \\{T\\}\_{t=t_0}} {\Delta t}
= \\{F\\}\_{t=t\_{0+\Delta t}}
\label{eq:2.4.13}
\end{equation}
$$

The acquisition of a solution with better accuracy $\\{T\\}\_{t=t\_{0+\Delta t}}^{(i)}$, is considered by improving the temperature vector $\\{T\\}\_{t=t\_{0+\Delta t}}^{(i)+1}$ which satisfies the apporoximation of equation $\eqref{eq:2.4.13}$.

Therefore, first, the temperature vector is expressed as follows.

$$
\begin{equation}
\\{T\\}\_{t=t\_{0+\Delta t}}=
\\{T\\}_{t=t\_{0+\Delta t}}^{(i)} + \Delta \\{T\\}\_{t=t\_{0+\Delta t}}^{(i)}
\label{eq:2.4.14}
\end{equation}
$$

The product of the heat conduction matrix and temperature vector, mass matrix and etc. are expressed in apporoximation as in the following equation.

$$
\begin{align}
[K]\_{t=t\_{0+\Delta t}} \\{T\\}\_{t=t\_{0+\Delta t}} \nonumber
& \cong [K]\_{t=t\_{0+\Delta t}}^{(i)} \\{T\\}\_{t=t\_{0+\Delta t}}^{(i)} \\\
& + \frac{\partial [K]\_{t=t\_{0+\Delta t}}^{(i)}{\\{T\\}\_{t=t\_{0+\Delta t}}^{(i)}}}{\partial \\{T\\}_{t=t\_{0+\Delta t}}^{(i)}}
\\{\Delta T\\}\_{t=t\_{0+\Delta t}}^{(i)}
\label{eq:2.4.15}
\end{align}
$$

$$
\begin{equation}
[M]\_{t=t\_{0+\Delta t}}
\cong [M]\_{t=t\_{0+\Delta t}}^{(i)}
+ \frac{\partial [M]\_{t=t\_{0+\Delta t}}^{(i)}}{\partial \\{T\\}\_{t=t\_{0+\Delta t}}^{(i)}}
\Delta \\{T\\}\_{t=t\_{0+\Delta t}}^{(i)}
\label{eq:2.4.16}
\end{equation}
$$

When equations $\eqref{eq:2.4.14}$ $\eqref{eq:2.4.15}$ and $\eqref{eq:2.4.16}$ are substituted with equation $\eqref{eq:2.4.13}$ and two or more polynominals are omitted, the following equation can be acquired.

$$
\begin{equation}
\left(\frac{[M]\_{t=t\_{0+\Delta t}}^{(i)}}{\Delta t}
+ \frac{\partial [M]\_{t=t_{0+\Delta t}}^{(i)} \\{T\\}\_{t=t\_{0+\Delta t}}^{(i)}}
{\partial \\{T\\}\_{t=t\_{0+\Delta t}}^{(i)}}
\frac{\\{T\\}\_{t=t\_{0+\Delta t}}^{(i)} - \\{T\\}\_{t=t_0}}{\Delta t}
+ \frac{\partial [K]\_{t=t\_{0+\Delta t}}^{(i)} \\{T\\}\_{t=t\_{0+\Delta t}}^{(i)}}
{\partial \\{T\\}\_{t=t\_{0+\Delta t}}^{(i)}} \right)
\\{\Delta T\\}\_{t=t\_{0+\Delta t}}^{(i)} \\\
= \\{F\\}\_{t=t_0+\Delta t} - [M]\_{t=t\_{0+\Delta t}}^{(i)}
\frac{\\{T\\}\_{t=t\_{0+\Delta t}}^{(i)} - \\{T\\}\_{t=t_0}}{\Delta t}
- [K]\_{t=t\_{0+\Delta t}}^{(i)} \\{T\\}_{t=t\_{0+\Delta t}}^{(i)}
\label{eq:2.4.17}
\end{equation}
$$

Furthermore, an approximation evaluation is performed for the left factor matrix using the following equation.

$$
\begin{align}
[K^*]^{(i)}
&= \frac{[M]^{(i)}\_{t=t\_{0+\Delta t}}}{\Delta t}
+ \frac{\partial[K]^{(i)}\_{t=t\_{0+\Delta t}}}{\partial\\{T\\}^{(i)}\_{t=t\_{0+\Delta t}}}
\\{T\\}^{(i)}\_{t=t\_{0+\Delta t}} \nonumber \\\
& =  \frac{[M]^{(i)}\_{t=t\_{0+\Delta t}}}{\Delta t}
+ [K_T]^{(i)}\_{t=t\_{0+\Delta t}}
\label{eq:2.4.18}
\end{align}
$$

In this case, $[K_T]^{(i)}_{t=t_0 + \Delta t}$ is the tangent stiffness matrix.

Finally, the temperature at time $t = t_0 + \Delta t$ can be calculated by performing an iterative calculation using the following equation.

$$
\begin{equation}
[K^*]^{(i)} \\{T\\}^{(i)}\_{t=t_0 + \Delta t}
= \\{F\\}\_{t=t_0 + \Delta t}
- [M]^{(i)}_{t=t_0 + \Delta t} \frac{\\{T\\}^{(i)}\_{t=t_0 \Delta t} - \\{T\\}\_{t=t_0}}{\Delta t}
- [K]^{(i)}\_{t=t_0 + \Delta t} \\{T\\}^{(i)}\_{t=t_0 + \Delta t} \\\
\\{T\\}^{(i+1)}\_{t=t_0 + \Delta t} = \\{T\\}^{(i)}\_{t=t_0 \Delta t} + \\{\Delta T\\}^{(i)}\_{t=t_0+\Delta t}
\label{eq:2.4.19}
\end{equation}
$$

Particularly, in the analysis for a steady state, the following equation is used to perform the iterative calculation.

$$
\begin{equation}
[K_T]^{(i)} \\{\Delta T\\}\_{t=\infty}^{(i)} = \\{F\\}\_{t=\infty} - [K_T]^{(i)} \\{\Delta T\\}\_{t=\infty}^{(i)} \\\
\\{T\\}^{(i+1)}\_{t=\infty} = \\{T\\}^{(i)}\_{t=\infty} + \\{\Delta T\\}^{(i)}\_{t=\infty}
\label{eq:2.4.20}
\end{equation}
$$

Since an implicit method is used for the discretization regarding the time to select time increment $\Delta t$ in the unsteady state analysis, generally, there are no concerns in the restrictions of the size. However, if time increment $\Delta t$ is to large, the convergence frequency will increase in the iterative calculation. Therefore, this program is equipped with an automatic increment function to always monitor the size of the residual vectors during the iterative calculation process, and if the convergence of the iterative calculation is to slow, time increment $\Delta t$ is decreased, and if the iterative calculation frequency decreases, time increment $\Delta t$ is increased.
