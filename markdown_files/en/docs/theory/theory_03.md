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

## Dynamic Analysis Method

In this section, the dynamic problem analysis method with a direct time integration method applied is described. As presented below, with this development code, it is possible to perform time history response analysis by an implicit or explicit method. 

### Formulation of the implicit method

Focusing on dynamic problems, the direct time integration method was applied to solve the following equation motion indicated: 

$$
\begin{equation}
M( t + \Delta t ) \ddot{U} (t + \Delta t) + C( t + \Delta t ) \dot{U}(t + \Delta t) + Q( t + \Delta t ) = F( t + \Delta t )
\label{eq:2.5.1}
\end{equation}
$$

where $M$ and the mass matrix, $C$ is the damping matrix, and $Q$ is the internal stress vector, and $F$ is the external force vector. This software does not consider the changes in mass; thus, the mass matrix is non-linear and constant regardless of deformation.

The displacement within time increment $\Delta t$, and the change in speed and acceleration are approximated with the Newmark-$\beta$ method, as expressed in Eq.$\eqref{eq:2.5.2}$ and Eq.$\eqref{eq:2.5.3}$:

$$
\begin{equation}
\dot{U}(t + \Delta t) =
\frac{\gamma}{\beta \Delta t} \Delta U( t + \Delta t ) - \frac{\gamma - \beta}{\beta} \dot{U}( t ) - \Delta t \frac{\gamma - 2\beta}{2\beta} \ddot{U}(t)
\label{eq:2.5.2}
\end{equation}
$$

$$
\begin{equation}
\ddot{U}(t + \Delta t) = \frac{1}{\beta \Delta t^2}\Delta U(t + \Delta t) - \frac{1}{\beta \Delta t} \dot{U}(t) - \frac{1 - 2\beta}{2\beta} \ddot {U}(t)
\label{eq:2.5.3}
\end{equation}
$$

where $\gamma$ and $\beta$ are the parameters of the Newmark-$\beta$ method.

if $\gamma$ and $\beta$ have the following values, it coincides with the linear acceleration method or the trapezoidal rule.

As it is already known, when $\gamma$ and $\beta$ are substituted into the following values, it will match the linear acceleration method, or trapezoid rule.

  - $\gamma=\frac{1}{2}$, $\beta=\frac{1}{6}$ (Linear acceleration method)
  - $\gamma=\frac{1}{2}$, $\beta=\frac{1}{4}$ (Trapezoid rule)

If Eq.$\eqref{eq:2.5.2}$ and Eq.$\eqref{eq:2.5.3}$ are substituted into Eq.$\eqref{eq:2.5.1}$, the following equation is obtaind:

$$
\begin{align}
\nonumber \left( \frac{1}{\beta \Delta t^2} \mathbf{M} + \frac{\gamma}{\beta \Delta t} C + K \right) \Delta U ( t + \Delta t ) &= F ( t + \Delta t )
- Q ( t + \Delta t ) \\\
\nonumber &+ \frac{1}{\beta \Delta t} M \dot{U} ( t )
           + \frac{1 - 2\beta}{2\beta} M \ddot{U} ( t ) \\\
&+ \frac{\gamma - \beta}{\beta} C \dot{U} (t)
           + \Delta t \frac{\gamma - 2\beta}{2 \beta} C \ddot{U}(t)
\label{eq:2.5.4}
\end{align}
$$

$K_L$ is linear stiffness matrix for linear problem; thus, $Q ( t + \Delta t ) = K_L U (t + \Delta t)$. If this equation is substituted into the equation above, the following equation is obtained:

$$
\begin{equation}
\left\lbrace
M
\left(
 - \frac{1}{(\Delta t)^2 \beta} U(t) - \frac{1}{(\Delta t)\beta} \dot{U}(t) - \frac{1-2\beta}{2\beta} \ddot{U}(t)
\right) \\\
\qquad\qquad\qquad\qquad +
C
\left(
 - \frac{\gamma}{(\Delta t)\beta} U(t) + \left(1-\frac{\gamma}{\beta}\right) \dot{U}(t) + \Delta t \frac{2\beta - \gamma}{2\beta} \ddot{U}(t)
\right)
\right \rbrace \\\
+
\left \lbrace
 \frac{1}{(\Delta t)^2\beta} M + \frac{\gamma}{(\Delta t)\beta} C + K_L
\right \rbrace
U(t+\Delta t)
= F(t+\Delta t)
\label{eq:2.5.5}
\end{equation}
$$

In the portion, where the acceleration is specified as a geometric boundary condition, the displacement of the following equation is obtained from Eq.$\eqref{eq:2.5.2}$.


$$
\begin{equation}
u_{is} (t+\Delta{t}) = u_{is} (t) + \Delta t\, \dot{u}\_{is}(t) + (\Delta t)^2 \left(\frac{1}{2} -\beta \right) {\ddot{u}}_{is}(t) + (\Delta t)^2 \beta \ddot{u}\_{is}(t + \Delta t)
\label{eq:2.5.6}
\end{equation}
$$

Similarly, if the speed is specified, the displacement of the following equation is obtained from Eq.$\eqref{eq:2.5.6}$:

$$
\begin{equation}
u\_{is}(t+\Delta t) = u\_{is}(t) + \Delta t \frac{\gamma-\beta}{\gamma}\dot{u}\_{is}
+ (\Delta t)^2 \frac{\gamma-2\beta}{2\gamma} \ddot{u}\_{is} + \Delta t \frac{\beta}{\gamma} \dot{u}\_{is}(t+\Delta t)
\label{eq:2.5.7}
\end{equation}
$$

Where 

  - $u_{is}(t+\Delta t)$ is the nodal displacement at $t + \Delta t$,
  - $\dot{u}_{is}(t+\Delta t)$ is the nodal speed at time $t + \Delta t$ 
  - $\ddot{u}_{is}(t+\Delta t)$ is the nodal acceleration at time $t + \Delta t$
  - $i$ is the nodal degree-of-freedom (DOF)
  - $s$ is the Node number.

Furthermore, the mass and damping terms were handled as follows: 

#### (1) Handling of mass term

The mass matrices are handled as concentrated mass matrices. 

#### (2) Handling of damping terms

The damping terms are handled as Rayleigh damping expressed in Eq.$\eqref{eq:2.5.8}$.

$$
\begin{equation}
C = R_m M + R_k K_L
\label{eq:2.5.8}
\end{equation}
$$

where $R_m$ and $R_k$ are parameters of Rayleigh damping.

### Formulation of Explicit Method

The explicit method is based on the motion equation at time $t$ expressed in the following equation: 

$$
\begin{equation}
M \ddot{U}(t) + C (t) \dot{U}(t) + Q(t) = F(t)
\label{eq:2.5.9}
\end{equation}
$$

where the displacement at time $t + \Delta t$ and that at time $t - \Delta t$ are expressed by the Taylor expansion at time $t$. If it is expanded up to the secondary term with $\Delta t$, it becomes


$$
\begin{equation}
U(t+\Delta{t}) = U(t)+\dot{U}(t)(\Delta{t})
+\frac{1}{2!}\ddot{U}(t)(\Delta{t})^2
\label{eq:2.5.10}
\end{equation}
$$

$$
\begin{equation}
U(t-\Delta{t})=U(t)-\dot{U}(t)(\Delta{t})
+\frac{1}{2!}\ddot{U}(t)(\Delta{t})^2
\label{eq:2.5.11}
\end{equation}
$$

From the difference and sum of Eq.$\eqref{eq:2.5.3}$ and Eq.$\eqref{eq:2.5.4}$, the following equation is obtained:

$$
\begin{equation}
\dot{U}(t)=\frac{1}{2\Delta{t}}
(U(t+\Delta{t})-U(t-\Delta{t}))
\label{eq:2.5.12}
\end{equation}
$$

$$
\begin{equation}
\ddot{U}=
\frac{1}{(2\Delta{t})^2}
(U(t+\Delta{t})-2U(t)+U(t-\Delta{t}))
\label{eq:2.5.13}
\end{equation}
$$

If Eq.$\eqref{eq:2.5.12}$ and Eq.$\eqref{eq:2.5.13}$ are substituted into Eq.$\eqref{eq:2.5.9}$, the following equation is obtained:

$$
\begin{align}
\left( \frac{1}{\Delta t^{2}} M + \frac{1}{2\Delta t} C \right) U ( t + \Delta t ) &=
  F(t) - Q(t) \nonumber \\\
  & - \frac{1}{\Delta t^{2}} M [2 U(t) - U( t - \Delta t)] - \frac{1}{2\Delta t} C U(t - \Delta t)
\label{eq:2.5.14}
\end{align}
$$

For linear problems, specifically, $Q(t)=K_L U(t)$, the above equation becomes

$$
\begin{align}
\left( \frac{1}{\Delta t^{2}} M + \frac{1}{2\Delta t} C \right) U( t + \Delta t ) & = F(t) - K_L U(t) \nonumber \\\
  & - \frac{1}{\Delta t^{2}} M[2U(t) - U(t - \Delta t)] - \frac{1}{2\Delta t} C U(t - \Delta t)
\label{eq:2.5.15}
\end{align}
$$

In this case, if mass matrix $M$ is set as a concentrated mass matrix, and the damping matrix as the proportional damping matrix $C=R_m M$, Eq.$\eqref{eq:2.5.15}$ eliminates the requirement of solving operations for simultaneous equations. 

Therefore, from Eq.$\eqref{eq:2.5.15}$, $U(t+\Delta t)$ can be determined by the following equation:

$$
\begin{equation}
U(t + \Delta t)  =
\frac{1}{\left(\cfrac{1}{\Delta t^2}M + \cfrac{1}{2\Delta t}C\right)}
\left \\{
F(t) - Q(t) - \frac{1}{\Delta t^2} M [2U(t) - U(t-\Delta t)] - \frac{1}{2\Delta t} C(t-\Delta t) U
\right \\}
\label{eq:2.5.17}
\end{equation}
$$


