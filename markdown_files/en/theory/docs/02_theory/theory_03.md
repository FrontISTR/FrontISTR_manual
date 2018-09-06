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

# Dynamic Analysis Method

The dynamic problem analysis method with direct time integration applied is described in this section. As shown in the following, time history response analysis with an implicit method and explicit method can be performed in this development code.

## Formulation of Implicit Method

Direct time integration is applied to the solution of the equation of motion as shown in the following equation, targeting dynamic problems.

$$
\begin{equation}
M( t + \Delta t ) \ddot{U} (t + \Delta t) + C( t + \Delta t ) \dot{U}(t + \Delta t) + Q( t + \Delta t ) = F( t + \Delta t )
\label{eq:2.5.1}
\end{equation}
$$

Herein, $M$ and $C$ is the mass matrix and attenuation matrix, and $Q$ and $F$ are the internal force vector and external force vector. In addition, the change of mass is not considered in this software, and the mass matrix becomes constant regardless of the deformation in non-linearity.

The displacement within time increment $\Delta t$, and the change of rate and acceleration are apporoximated as shown in equation $\eqref{eq:2.5.2}$ and equation $\eqref{eq:2.5.3}$ using the Newmark-&beta; method.

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

Where,

  - $\gamma$, $\beta$ : Parameter

As it is already known, when $\gamma$ and $\beta$ are substituted into the following values, it will match the linear acceleration method, or trapezoid rule.

  - $\gamma=1/2$, $\beta=1/6$ (Linear acceleration method)
  - $\gamma=1/2$, $\beta=1/4$ (Trapezoid rule)

When equation $\eqref{eq:2.5.2}$ and equation $\eqref{eq:2.5.3}$ are substituted with equation $\eqref{eq:2.5.1}$, the following equation can be acquired.

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

Particularly, when $K_L$ is assumed as the linear stiffness matrix for a linear problem, the equation becomes $Q ( t + \Delta t ) = K_L U (t + \Delta t)$. When this equation is substituted with the above equation, the following equation can be acquired.

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

In addition, in locations where the acceleration is specified as geometric boundary condition, the displacement of the following equation can be acquired from equation $\eqref{eq:2.5.2}$.


$$
\begin{equation}
u_{is} (t+\Delta{t}) = u_{is} (t) + \Delta t\, \dot{u}\_{is}(t) + (\Delta t)^2 \left(\frac{1}{2} -\beta \right) {\ddot{u}}_{is}(t) + (\Delta t)^2 \beta \ddot{u}\_{is}(t + \Delta t)
\label{eq:2.5.6}
\end{equation}
$$

Similarly, in locations where the rate is specified, the displacement of the following equation can be acquired from equation $\eqref{eq:2.5.6}$.

$$
\begin{equation}
u\_{is}(t+\Delta t) = u\_{is}(t) + \Delta t \frac{\gamma-\beta}{\gamma}\dot{u}\_{is}
+ (\Delta t)^2 \frac{\gamma-2\beta}{2\gamma} \ddot{u}\_{is} + \Delta t \frac{\beta}{\gamma} \dot{u}\_{is}(t+\Delta t)
\label{eq:2.5.7}
\end{equation}
$$

Where,

  - $u_{is}(t+\Delta t)$ : Node displacement at time $t + \Delta t$
  - $\dot{u}_{is}(t+\Delta t)$ : Node rate at time $t + \Delta t$
  - $\ddot{u}_{is}(t+\Delta t)$ : Node acceleration at time $t + \Delta t$
  - $i$ : Node degree of freedom number (Number of degrees of freedom per 1 - 1 node)
  - $s$ : Node number

The handling of the mass terms and the attenuation terms are as follows.

#### (1) Handling of Mass Term

Regarding mass matrices, it is handled as lumped mass matrices as a general rule.

#### (2) Handling of Attenuation Term

Regarding the attenuation term, it is handled as the Rayleigh attenuation expressed in equation $\eqref{eq:2.5.8}$.

$$
\begin{equation}
C = R_m M + R_k K_L
\label{eq:2.5.8}
\end{equation}
$$

Where,

  - $R_m$, $R_k$ : Parameter

## Formulation of Explicit Method

The equation of motion at time $t$ shown in the following equation is used as a reference in the explicit method.

$$
\begin{equation}
M \ddot{U}(t) + C (t) \dot{U}(t) + Q(t) = F(t)
\label{eq:2.5.9}
\end{equation}
$$

In this case, when the displacement at time $t + \Delta t$ and time $t - \Delta t$ is expressed by the Taylor expansion at time $t$, and is taken to the second polynomial regarding $\Delta t$, the equation becomes as follows.


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

The following equation can be acquired from the difference and sum of equation $\eqref{eq:2.5.3}$ and equation $\eqref{eq:2.5.4}$.

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

When equation $\eqref{eq:2.5.12}$ and equation $\eqref{eq:2.5.13}$ are substituted with equation $\eqref{eq:2.5.9}$, the following equation can be aquired.


$$
\begin{align}
\left( \frac{1}{\Delta t^{2}} M + \frac{1}{2\Delta t} C \right) U ( t + \Delta t ) &=
  F(t) - Q(t) \nonumber \\\
  & - \frac{1}{\Delta t^{2}} M [2 U(t) - U( t - \Delta t)] - \frac{1}{2\Delta t} C U(t - \Delta t)
\label{eq:2.5.14}
\end{align}
$$

Practicularly, the equation becomes $Q(t)=K_L U(t)$ for a linear problem, and the above equation becomes as follows.

$$
\begin{align}
\left( \frac{1}{\Delta t^{2}} M + \frac{1}{2\Delta t} C \right) U( t + \Delta t ) & = F(t) - K_L U(t) \nonumber \\\
  & - \frac{1}{\Delta t^{2}} M[2U(t) - U(t - \Delta t)] - \frac{1}{2\Delta t} C U(t - \Delta t)
\label{eq:2.5.15}
\end{align}
$$

In this case, when the mass matrix and the attenuation matrix are set as follows, problem solving operations of simultaneous equations is not required in equation $\eqref{eq:2.5.15}$.

  - $M$ : Mass matrix (Lumped mass matrix)
  - $C$ : Attenuation matrix (Proportional attenuation $C=R_mM$)
  - $R_m$ : Parameter

Therefore, from equation $\eqref{eq:2.5.15}$, $U(t+\Delta t)$ can be calculated by the following equation.

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


