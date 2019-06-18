
## Heat Conduction Analysis

In this section, the method of heat conduction analysis for solid bodies with the finite element methods used in this development code is described. 

### Basic Equation

The heat conduction equation in a continuous body is as follows: 

\[
\begin{equation}
  \rho c \frac{\partial T}{\partial t} =
  \frac{\partial}{\partial x}\left(kxx \frac{\partial T}{\partial x}\right)
+ \frac{\partial}{\partial y}\left(kyy \frac{\partial T}{\partial y}\right)
+ \frac{\partial}{\partial z}\left(kzz \frac{\partial T}{\partial z}\right) + Q
\label{eq:2.4.1}
\end{equation}
\]

where,

|                    |                      |
|--------------------|----------------------|
| \(\rho = \rho(x)\) | mass (density)       |
| \(c = c(x, T)\)    | specific heat        |
| \(T=T(x, t)\)      | temperature          |
| \(K=k(x, T)\)      | thermal conductivity |
| \(Q=Q(x, T, t)\)   | calorific value      |

\(x\) represents the position, \(T\) represents the temperature and \(t\) represents the time.

The area being considered is defined as \(S\) and its surroundings as \(\Gamma\). Assuming that Dirichet or Neumann-type boundary conditions are given throughout \(\Gamma\), the boundary conditions become as follows:

\[
\begin{align}
T = T_1(x, 5)& \qquad X \in \Gamma_1 \label{eq:2.4.2} \\\
k\frac{\partial T}{\partial n} = q(x, T, t)& \qquad X \in \Gamma_2 \label{eq:2.4.3}
\end{align}
\]

The function form of \(T_1\) and \(q\) is known. \(q\) is the outflow heat flux from the boundaries. 

With this program, it is possible to consider three types of heat flux.

\[
\begin{align}
&q   = -q_s + q_c + q_r \label{2.4.4} \\\
&q_s = q_s(x, t) \label{2.4.5} \\\
&q_c = hc(T-T_c) \label{2.4.6} \\\
&q_r = hr(T^4-{T_r}^4) \label{2.4.7}
\end{align}
\]

where \(q_s\) is the distributed heat flux, \(q_c\) is the heat flux by the convective heat transfer, and \(q_r\) is the heat flux by the radiant heat transfer.

Furthermore,

|                                    |                                                          |
|------------------------------------|----------------------------------------------------------|
| \(Tc=Tc(x,t)\)                     | Convective heat transfer coefficient atomospheric temperature |
| \(hc=hc(x,t)\)                     | Convective heat transfer coeffcient                           |
| \(Tr=Tr(x,t)\)                     | Radiation heat transfer coefficient atmospheric temperature    |
| \(hr=\varepsilon\sigma F=hr(x,t)\) | Radiation heat transfer coefficient

\(\varepsilon\): radiation rate, \(\sigma\): Stefan-Boltzmann constant, \(F\): shape factor

### Discretization

If Eq.\(\eqref{eq:2.4.1}\) is discretized with the Galerkin method,

\[
\begin{equation}
[K]\lbrace T \rbrace + [M] \frac{\partial T}{\partial t} = \lbrace F \rbrace
\label{eq:2.4.8}
\end{equation}
\]

However,

\[
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
\]

\[
\begin{equation}
[M] = \int \rho c \lbrace N \rbrace^\mathrm{T} \lbrace N \rbrace dV
\label{eq:2.4.10}
\end{equation}
\]

\[
\begin{align}
\lbrace F\rbrace &= \int Q \lbrace N \rbrace^\mathrm{T} dV - \int q_s \lbrace N \rbrace^\mathrm{T} dS + \int{hc} T c \lbrace N \rbrace^\mathrm{T} dS \nonumber \\\
&+ \int{hrTr} ({T+Tr}) ({T^2 + T r^2}) \lbrace N \rbrace^\mathrm{T} dS
\label{eq:2.4.11}
\end{align}
\]

\[
\begin{equation}
\lbrace N \rbrace = (N^1, N^2, \ldots, Ni)
\label{eq:2.4.12}
\end{equation}
\]

Eq.\(\eqref{eq:2.4.8}\) is a formula of non-linear and non-steady-state. The objective now is to discretize it in time by the backward Euler method and calculate the temperature at time \(t = t_0\) (when the temperature at \(t = t_0+\Delta t\) is known) with the following equation:

\[
\begin{equation}
[K]_{t=t_0+\Delta t} \lbrace T \rbrace_{t=t_0+\Delta t} + [M]_{t=t_0+\Delta t}
\frac{\lbrace T \rbrace_{t=t_0+\Delta t} - \lbrace T\rbrace_{t=t_0}} {\Delta t}
= \lbrace F \rbrace_{t=t_0+\Delta t}
\label{eq:2.4.13}
\end{equation}
\]

The next step is to improve the temperature vector \(\lbrace T \rbrace_{t=t_0+\Delta t}^{(i)}\) which approximately satisfies Eq.\(\eqref{eq:2.4.13}\) to determine the solution \(\lbrace T \rbrace_{t=t_0+\Delta t}^{(i)+1}\) with a good precision.

Therefore, the temperature vector must be expressed as follows: 

\[
\begin{equation}
\lbrace T \rbrace_{t=t_0+\Delta t}=
\lbrace T \rbrace_{t=t_0+\Delta t}^{(i)} + \Delta \lbrace T \rbrace_{t=t_0+\Delta t}^{(i)}
\label{eq:2.4.14}
\end{equation}
\]

The product of the heat transfer matrix and temperature vector, as well as the mass matrix, are expressed approximately by the following equations:

\[
\begin{align}
[K]_{t=t_{0+\Delta t}} \lbrace T \rbrace_{t=t_0+\Delta t} \nonumber
& \cong [K]_{t=t_0+\Delta t}^{(i)} \lbrace T \rbrace_{t=t_0+\Delta t}^{(i)} \\\
& + \frac{\partial [K]_{t=t_0+\Delta t}^{(i)}{\lbrace T \rbrace_{t=t_0+\Delta t}^{(i)}}}{\partial \lbrace T \rbrace_{t=t_0+\Delta t}^{(i)}}
\lbrace\Delta T \rbrace_{t=t_0+\Delta t}^{(i)}
\label{eq:2.4.15}
\end{align}
\]

\[
\begin{equation}
[M]_{t=t_0+\Delta t}
\cong [M]_{t=t_0+\Delta t}^{(i)}
+ \frac{\partial [M]_{t=t_0+\Delta t}^{(i)}}{\partial \lbrace T \rbrace_{t=t_0+\Delta t}^{(i)}}
\Delta \lbrace T \rbrace_{t=t_0+\Delta t}^{(i)}
\label{eq:2.4.16}
\end{equation}
\]

By substituting Eq.\(\eqref{eq:2.4.14}\),  Eq.\(\eqref{eq:2.4.15}\) and Eq.\(\eqref{eq:2.4.16}\) into Eq.\(\eqref{eq:2.4.13}\), and omitting the terms of second or higher order, the following equation is obtained:

\[
\begin{equation}
\left(\frac{[M]_{t=t_0+\Delta t}^{(i)}}{\Delta t}
+ \frac{\partial [M]_{t=t_0+\Delta t}^{(i)} \lbrace T\rbrace_{t=t_0+\Delta t}^{(i)}}
{\partial \lbrace T\rbrace_{t=t_0+\Delta t}^{(i)}}
\frac{\lbrace T\rbrace_{t=t_0+\Delta t}^{(i)} - \lbrace T\rbrace_{t=t_0}}{\Delta t} \\
+ \frac{\partial [K]_{t=t_0+\Delta t}^{(i)} \lbrace T\rbrace_{t=t_0+\Delta t}^{(i)}}
{\partial \lbrace T\rbrace_{t=t_0+\Delta t}^{(i)}} \right)
\lbrace\Delta T\rbrace_{t=t_0+\Delta t}^{(i)} \\\
= \lbrace F\rbrace_{t=t_0+\Delta t} - [M]_{t=t_0+\Delta t}^{(i)}
\frac{\lbrace T\rbrace_{t=t_0+\Delta t}^{(i)} - \lbrace T\rbrace_{t=t_0}}{\Delta t}
- [K]_{t=t_0+\Delta t}^{(i)} \lbrace T\rbrace_{t=t_0+\Delta t}^{(i)}
\label{eq:2.4.17}
\end{equation}
\]

Moreover, the coefficient matrix of the left side is approximately evaluated with the following equation: 

\[
\begin{align}
[K^*]^{(i)}
&= \frac{[M]^{(i)}_{t=t_0+\Delta t}}{\Delta t}
+ \frac{\partial[K]^{(i)}_{t=t_0+\Delta t}}{\partial\lbrace T\rbrace^{(i)}_{t=t_0+\Delta t}}
\lbrace T\rbrace^{(i)}_{t=t_0+\Delta t} \nonumber \\\
& =  \frac{[M]^{(i)}_{t=t_0+\Delta t}}{\Delta t}
+ [K_T]^{(i)}_{t=t_0+\Delta t}
\label{eq:2.4.18}
\end{align}
\]

where \([K_T]^{(i)}_{t=t_0 + \Delta t}\) is a tangent stiffness matrix.

Finally, it is possible to calculate the temperature at time \(t = t_0 + \Delta t\) through iterative calculation using the following equation: 

\[
\begin{align}
[K^*]^{(i)}\lbrace T\rbrace^{(i)}_{t=t_0+\Delta t} 
  &= \lbrace F\rbrace_{t=t_0 + \Delta t} \nonumber \\\
  & - [M]^{(i)}_{t=t_0+\Delta t} \frac{\lbrace T\rbrace^{(i)}_{t=t_0+\Delta t}-\lbrace T\rbrace_{t=t_0}}{\Delta t} \nonumber \\\
  &- [K]^{(i)}_{t=t_0+\Delta t} \lbrace T\rbrace^{(i)}_{t=t_0 + \Delta t} \nonumber \\\
\lbrace T\rbrace^{(i+1)}_{t=t_0 + \Delta t}  &= \lbrace T\rbrace^{(i)}_{t=t_0+\Delta t} + \lbrace \Delta T\rbrace^{(i)}_{t=t_0 + \Delta t}
\label{eq:2.4.19}
\end{align}
\]

In steady-state analysis, the iterative calculation is performed with the following equation: 

\[
\begin{align}
[K_T]^{(i)} \lbrace \Delta T\rbrace^{(i)}_{t=\infty} &= \lbrace F\rbrace_{t=\infty} - [K_T]^{(i)} \lbrace \Delta T\rbrace^{(i)}_{t=\infty} \nonumber \\\
\lbrace T\rbrace^{(i+1)}_{t=\infty} &= \lbrace T\rbrace^{(i)}_{t=\infty} + \lbrace \Delta T\rbrace^{(i)}_{t=\infty}
\label{eq:2.4.20}
\end{align}
\]

In non-steady-state analysis, the discretization in time is done through the implicit method; thus, the analysis is normally not affected by the restriction of the size of the time increment \(\Delta t\). However, if the time increment \(\Delta t\) is to large, the number of convergences in the iterative calculation increases. Therefore, this program is equipped with an automatic increment function, which constantly monitors the dimension of the residual vector in the iterative calculation process. If the convergence of the iterative calculation is too slow, it decreases the time increment \(\Delta t\). Moreover, when the number of iterative calculations is too small, it increases the time increment \(\Delta t\).


