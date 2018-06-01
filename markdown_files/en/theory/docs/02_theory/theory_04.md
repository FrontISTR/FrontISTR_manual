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

The heat conduction analysis method for solids by the finite element method used in this development code is shown in the following.

## Basic Equation

The heat conduction equation during the continuum is as follows.

$$
\begin{equation}
  \rho c \frac{\partial T}{\partial t} =
  \frac{\partial}{\partial x}\left(kxx \frac{\partial T}{\partial x}\right)
+ \frac{\partial}{\partial y}\left(kyy \frac{\partial T}{\partial y}\right)
+ \frac{\partial}{\partial z}\left(kzz \frac{\partial T}{\partial z}\right) + Q
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
\begin{align}
T = T_1(x, 5)& \qquad X \in \Gamma_1 \label{eq:2.4.2} \\\
k\frac{\partial T}{\partial n} = q(x, T, t)& \qquad X \in \Gamma_2 \label{eq:2.4.3}
\end{align}
$$

However, the function form $T_1$, $q$ is already known. $q$ is the heat flux outflow from the boundary. Three types of heat flux can be considered in this program.

$$
\begin{align}
&q   = -q_s + q_c + q_r \label{2.4.4} \\\
&q_s = q_s(x, t) \label{2.4.5} \\\
&q_c = hc(T-T_c) \label{2.4.6} \\\
&q_r = hr(T^4-{T_r}^4) \label{2.4.7}
\end{align}
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
[K]\lbrace T \rbrace + [M] \frac{\partial T}{\partial t} = \lbrace F \rbrace
\label{eq:2.4.8}
\end{equation}
$$

However,

$$
\begin{align}
[K] &= \int
\left(
kxx \frac{\partial \lbrace N \rbrace^\mathrm{T}}{\partial x}
    \frac{\partial \lbrace N \rbrace}{\partial x}
+
kyy \frac{\partial \lbrace N \rbrace^\mathrm{T}}{\partial y}
    \frac{\partial \lbrace N \rbrace}{\partial y}
+
kzz \frac{\partial \lbrace N \rbrace^\mathrm{T}}{\partial z}
    \frac{\partial \lbrace N \rbrace}{\partial z}
\right)
dV \nonumber \\\
&+ \int hc \lbrace N \rbrace^\mathrm{T} \lbrace N \rbrace ds
 + \int hr \lbrace N \rbrace^\mathrm{T} \lbrace N \rbrace ds
\label{eq:2.4.9}
\end{align}
$$

$$
\begin{equation}
[M] = \int \rho c \lbrace N \rbrace^\mathrm{T} \lbrace N \rbrace dV
\label{eq:2.4.10}
\end{equation}
$$

$$
\begin{align}
\lbrace F\rbrace &= \int Q \lbrace N \rbrace^\mathrm{T} dV - \int q_s \lbrace N \rbrace^\mathrm{T} dS + \int{hc} T c \lbrace N \rbrace^\mathrm{T} dS \nonumber \\\
&+ \int{hrTr} ({T+Tr}) ({T^2 + T r^2}) \lbrace N \rbrace^\mathrm{T} dS
\label{eq:2.4.11}
\end{align}
$$

Form function:

$$
\begin{equation}
\lbrace N \rbrace = (N^1, N^2, \ldots, Ni)
\label{eq:2.4.12}
\end{equation}
$$

Equation $\eqref{eq:2.4.8}$ is a nonlinear and unsteady equation. Now, when the time is discretized by the backward Euler's rule and the temperature at time $t = t_0$ is already known, the temperature at $t = t_0+\Delta t$ is calculated using the following equation.

$$
\begin{equation}
[K]\_{t=t\_0+\Delta t} \lbrace T \rbrace\_{t=t\_0+\Delta t} + [M]\_{t=t\_0+\Delta t}
\frac{\lbrace T \rbrace\_{t=t\_0+\Delta t} - \lbrace T\rbrace\_{t=t_0}} {\Delta t}
= \lbrace F \rbrace\_{t=t\_0+\Delta t}
\label{eq:2.4.13}
\end{equation}
$$

The acquisition of a solution with better accuracy $\lbrace T \rbrace\_{t=t\_0+\Delta t}^{(i)}$, is considered by improving the temperature vector $\lbrace T \rbrace\_{t=t\_0+\Delta t}^{(i)+1}$ which satisfies the apporoximation of equation $\eqref{eq:2.4.13}$.

Therefore, first, the temperature vector is expressed as follows.

$$
\begin{equation}
\lbrace T \rbrace\_{t=t\_0+\Delta t}=
\lbrace T \rbrace_{t=t\_0+\Delta t}^{(i)} + \Delta \lbrace T \rbrace\_{t=t\_0+\Delta t}^{(i)}
\label{eq:2.4.14}
\end{equation}
$$

The product of the heat conduction matrix and temperature vector, mass matrix and etc. are expressed in apporoximation as in the following equation.

$$
\begin{align}
[K]\_{t=t\_{0+\Delta t}} \lbrace T \rbrace\_{t=t\_0+\Delta t} \nonumber
& \cong [K]\_{t=t\_0+\Delta t}^{(i)} \lbrace T \rbrace\_{t=t\_0+\Delta t}^{(i)} \\\
& + \frac{\partial [K]\_{t=t\_0+\Delta t}^{(i)}{\lbrace T \rbrace\_{t=t\_0+\Delta t}^{(i)}}}{\partial \lbrace T \rbrace_{t=t\_0+\Delta t}^{(i)}}
\lbrace\Delta T \rbrace\_{t=t\_0+\Delta t}^{(i)}
\label{eq:2.4.15}
\end{align}
$$

$$
\begin{equation}
[M]\_{t=t\_0+\Delta t}
\cong [M]\_{t=t\_0+\Delta t}^{(i)}
+ \frac{\partial [M]\_{t=t\_0+\Delta t}^{(i)}}{\partial \lbrace T \rbrace\_{t=t\_0+\Delta t}^{(i)}}
\Delta \lbrace T \rbrace\_{t=t\_0+\Delta t}^{(i)}
\label{eq:2.4.16}
\end{equation}
$$

When equations $\eqref{eq:2.4.14}$ $\eqref{eq:2.4.15}$ and $\eqref{eq:2.4.16}$ are substituted with equation $\eqref{eq:2.4.13}$ and two or more polynominals are omitted, the following equation can be acquired.

$$
\begin{equation}
\left(\frac{[M]\_{t=t\_0+\Delta t}^{(i)}}{\Delta t}
+ \frac{\partial [M]\_{t=t_0+\Delta t}^{(i)} \lbrace T\rbrace\_{t=t\_0+\Delta t}^{(i)}}
{\partial \lbrace T\rbrace\_{t=t\_0+\Delta t}^{(i)}}
\frac{\lbrace T\rbrace\_{t=t\_0+\Delta t}^{(i)} - \lbrace T\rbrace\_{t=t_0}}{\Delta t}
+ \frac{\partial [K]\_{t=t\_0+\Delta t}^{(i)} \lbrace T\rbrace\_{t=t\_0+\Delta t}^{(i)}}
{\partial \lbrace T\rbrace\_{t=t\_0+\Delta t}^{(i)}} \right)
\lbrace\Delta T\rbrace\_{t=t\_0+\Delta t}^{(i)} \\\
= \lbrace F\rbrace\_{t=t_0+\Delta t} - [M]\_{t=t\_0+\Delta t}^{(i)}
\frac{\lbrace T\rbrace\_{t=t\_0+\Delta t}^{(i)} - \lbrace T\rbrace\_{t=t_0}}{\Delta t}
- [K]\_{t=t\_0+\Delta t}^{(i)} \lbrace T\rbrace_{t=t\_0+\Delta t}^{(i)}
\label{eq:2.4.17}
\end{equation}
$$

Furthermore, an approximation evaluation is performed for the left factor matrix using the following equation.

$$
\begin{align}
[K^*]^{(i)}
&= \frac{[M]^{(i)}\_{t=t\_0+\Delta t}}{\Delta t}
+ \frac{\partial[K]^{(i)}\_{t=t\_0+\Delta t}}{\partial\lbrace T\rbrace^{(i)}\_{t=t\_0+\Delta t}}
\lbrace T\rbrace^{(i)}\_{t=t\_0+\Delta t} \nonumber \\\
& =  \frac{[M]^{(i)}\_{t=t\_0+\Delta t}}{\Delta t}
+ [K_T]^{(i)}\_{t=t\_0+\Delta t}
\label{eq:2.4.18}
\end{align}
$$

In this case, $[K_T]^{(i)}_{t=t_0 + \Delta t}$ is the tangent stiffness matrix.

Finally, the temperature at time $t = t_0 + \Delta t$ can be calculated by performing an iterative calculation using the following equation.

$$
\begin{align}
[K^*]^{(i)}\lbrace T\rbrace^{(i)}_{t=t_0+\Delta t} 
  &= \lbrace F\rbrace\_{t=t_0 + \Delta t} \nonumber \\\
  & - [M]^{(i)}\_{t=t_0+\Delta t} \frac{\lbrace T\rbrace^{(i)}\_{t=t_0+\Delta t}-\lbrace T\rbrace\_{t=t_0}}{\Delta t} \nonumber \\\
  &- [K]^{(i)}\_{t=t_0+\Delta t} \lbrace T\rbrace^{(i)}\_{t=t_0 + \Delta t} \nonumber \\\
\lbrace T\rbrace^{(i+1)}\_{t=t_0 + \Delta t}  &= \lbrace T\rbrace^{(i)}\_{t=t_0+\Delta t} + \lbrace \Delta T\rbrace^{(i)}\_{t=t_0 + \Delta t}
\label{eq:2.4.19}
\end{align}
$$

Particularly, in the analysis for a steady state, the following equation is used to perform the iterative calculation.

$$
\begin{align}
[K_T]^{(i)} \lbrace \Delta T\rbrace^{(i)}\_{t=\infty} &= \lbrace F\rbrace\_{t=\infty} - [K_T]^{(i)} \lbrace \Delta T\rbrace^{(i)}\_{t=\infty} \nonumber \\\
\lbrace T\rbrace^{(i+1)}\_{t=\infty} &= \lbrace T\rbrace^{(i)}\_{t=\infty} + \lbrace \Delta T\rbrace^{(i)}\_{t=\infty}
\label{eq:2.4.20}
\end{align}
$$

Since an implicit method is used for the discretization regarding the time to select time increment $\Delta t$ in the unsteady state analysis, generally, there are no concerns in the restrictions of the size. However, if time increment $\Delta t$ is to large, the convergence frequency will increase in the iterative calculation. Therefore, this program is equipped with an automatic increment function to always monitor the size of the residual vectors during the iterative calculation process, and if the convergence of the iterative calculation is to slow, time increment $\Delta t$ is decreased, and if the iterative calculation frequency decreases, time increment $\Delta t$ is increased.

