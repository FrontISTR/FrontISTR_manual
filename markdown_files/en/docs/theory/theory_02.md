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

# Nonlinear Static Analysis Method

As mentioned before, in the analysis of the infinitesimal deformation problem, the finite element analysis can be performed by discretizing this equation with the finite element, using the principle of virtual work equivalent to a basic equation, such as the equilibrium equation.
Even in the analysis of a finite deformation problem which handles finite deformation of structures, the point of using the principle of virtual work is basically the same. However, in a finite deformation problem, even thought linearity of the material is assumed, the principle equation of virtual work will become a nonlinear equation regarding the displacement. In order to solve the nonlinear equation, repeated calculations by an iterative method is generally used.
In the iterative calculation, an incremental analysis method is used, where a calculation is sectionally performed for certain small load increments, and repeating this calculation results in a final deformed state. When an infinitesimal deformation problem is assumed the layout before and after deformation to define the strain and stress has not been distinguished in particular. Thus, when an infinitesimal deformation is assumed, the layout to describe the basic equation has not been a problem, even though it was before or after the deformation. However, when implementing an incremental analysis in a finite deformation problem, whether to refer to the initial status as a reference layout, or refer to the starting point of the increments can be selected. The former is called the total Lagrange method, and the latter is called the updated Lagrange method. For details, refer to the references and etc. at the end of this Chapter.

Both the total Lagrange method and updated Lagrange method have been adopted for this development code.

## Geometric Nonlinear Analysis Method

### Decomposition of Increments of Virtual Work Equation

The status to time $t$ is already known. The incremental analysis assumed here is where the status of $t'=t+\Delta t$ is unknown. (Refer to Figure 2.2.1) The equilibrium equation, dynamic boundary conditions and geometric boundary condidions (basic boundary condidions) of the static boudary value problems as follows.

$$
\begin{equation}
\nabla_{t'_x} \cdot ^{t'} \sigma +^{t'} \overline{b} =0 \qquad in \ V
\label{eq:2.2.1}
\end{equation}
$$

$$
\begin{equation}
^{t'} \sigma \cdot^{t'} n = ^{t'} \overline{t} \qquad on \ ^{t'}S_t
\label{eq:2.2.2}
\end{equation}
$$

$$
\begin{equation}
^{t'} u = ^{t'} \overline{u} \qquad on \ ^{t'} S_u
\label{eq:2.2.3}
\end{equation}
$$

However, $^{t'} \sigma$，$^{t'} \overline{b}$，$^{t'} n$，$^{t'} \overline{t}$，$^{t'} \overline{u}$ are the Cauchy stress (true stress), body force, outward normal vector of the object's surface, fixed surface force and fixed displacement in each time $t'$. these equations are described for the layout of $^{t'}v$, $^{t'}s\_t$, $^{t'}s\_u$ in time $'t$.

<div style="text-align:center;"><img alt="Figure 2.2.1: Concept of Incremental Analysis" src="media/theory02_01.png" width="80%"/></div>

** Figure 2.2.1: Concept of Incremental Analysis **

### Principle of Virtual Work

The principle of virtual work equivalent to the equilibrium equation of equation $\eqref{eq:2.2.1}$ and the dynamic boundary conditions of equation $\eqref{eq:2.2.2}$ is given by the following equation.

$$
\begin{equation}
\int_{^{t'}v}{^{t'} \sigma} : \delta^{t'} A\_{(L)} \, d^{t'}v =
\int_{^{t'} s\_{t}}^{t'}
\overline{t}
\cdot \delta u \, d^{t'}s +
\int_{V}^{t'}
\overline{b} \cdot \delta u \, d^{t'}v
\label{eq:2.2.4}
\end{equation}
$$

Herein, $^{t'} A\_{(L)}$ is the linear portion of the Almansi strain tensor, and is specifically expressed by the following equation.

$$
\begin{equation}
^{t'} A_{(L)} = \frac{1}{2}
\left\lbrace \frac{\partial ^{t'} u}{\partial ^{t'} x} + \left( \frac{ \partial ^{t'} u}{\partial ^{t'} x} \right) ^\mathrm{T} \right\rbrace
\label{eq:2.2.5}
\end{equation}
$$

Equation $\eqref{eq:2.2.4}$ should be solved with the geometric boundary conditions, strain displacement relational expresssion and the stress strain relational expression; however, equation $\eqref{eq:2.2.4}$ is described in the layout of time $t'$ is unknown at the present stage. Therefore, the formulation is performed referring to layout $V$ of time $0$ or layout $^{t'} v$ at time $t$.

### Formulation of Total Lagrange Method

The formulation based on the total Lagrange method used in the development code is described in this section.

The principle equation of the virtual work at time $t'$ assuming the initial layout of time $0$ is the reference, is given by the following equation.

$$
\begin{equation}
\int_{V}\,^{t'}_{0} S:\delta_0^{t'}
E\, dV=^{t'}\delta R
\label{eq:2.2.6}
\end{equation}
$$

$$
\begin{equation}
^{t'} \delta R=
\int_{S_t}\,
^{t'}\_{0} \overline{t} \cdot \delta u\, dS
+
\int_{V}\,
^{t'}\_{0} \overline{b} \cdot \delta u\, dV
\label{eq:2.2.7}
\end{equation}
$$

However, $^{t'}_0 S$, $^{t'}_0 E$ respectively express the 2nd Piola-Kirchhoff stress tensor and the Green-Lagrange strain tensor at time $t'$, assuming the initial layout of time $0$ is the reference.

Moreover, $^{t'}_0 \overline{t}$, $^{t'}_0 \overline{b}$ is the body force converted per unit volume of the nominal surface force vector and the initial layout, and is given by the following equation in connection with equations $\eqref{eq:2.2.1}$, $\eqref{eq:2.2.2}$ and $\eqref{eq:2.2.3}$.

$$
\begin{equation}
^{t'}_0 \overline{t}=\frac{d^{t'}s\_{t'}}{dS}\overline{t}
\label{eq:2.2.8}
\end{equation}
$$

$$
\begin{equation}
^{t'}_0\overline{b}=\frac{d^{t'}v\_{t'}}{dV}\overline{b}
\label{eq:2.2.9}
\end{equation}
$$

The Green-Langrange strain tensor at time $t$ is defined by the following equation.

$$
\begin{equation}
^{t'}\_{0} E=\frac{1}{2}
\left\lbrace
  \frac{\partial ^{t}u}{\partial X}
 +\left(\frac{\partial ^{t} u}{\partial X} \right)^T
 +\left(\frac{\partial ^{t} u}{\partial X}\right)^T
 \cdot \frac{\partial ^{t} u}{\partial X}
\right\rbrace
\label{eq:2.2.10}
\end{equation}
$$

Thus, the displacement and the 2nd Piola-Kirchhoff stress $^{t'} u$, $_{0}^{t'} S$ at time ${t'}$ are expressed by the decomposed increments at in the following equation.

$$
\begin{equation}
^{t'} u =^{t} u + \Delta u
\label{eq:2.2.11}
\end{equation}
$$

$$
\begin{equation}
\_{0}^{t'} S = _{0}^{t} S + \Delta S
\label{eq:2.2.12}
\end{equation}
$$

In this case, in relation to the displacement increment, the increment of the Green-Lagrange strain is defined by the following equation.

$$
\begin{equation}
\_{0}^{t'} E = _{0}^{t} E + \Delta E
\label{eq:2.2.13}
\end{equation}
$$

$$
\begin{equation}
\Delta E = \Delta E\_{L} + \Delta E_{NL}
\label{eq:2.2.14}
\end{equation}
$$

$$
\begin{equation}
\Delta E\_{L}=\frac{1}{2}
\left\lbrace
\frac{\partial \Delta u}{\partial X}
+\left(\frac{\partial \Delta u}{\partial X}\right)^\mathrm{T}
+\left(\frac{\partial \Delta u}{\partial X} \right)^\mathrm{T}\cdot
\frac{\partial ^{t} u}{\partial X}
+\left(\frac{\partial ^{t} u}{\partial X} \right)^\mathrm{T}
\cdot\frac{\partial \Delta u}{\partial X} \right\rbrace
\label{eq:2.2.15}
\end{equation}
$$

$$
\begin{equation}
\Delta E_{NL} = \frac{1}{2}\left(\frac{\partial \Delta u}{\partial X}\right)^\mathrm{T}\cdot\frac{\partial \Delta u}{\partial X}
\label{eq:2.2.16}
\end{equation}
$$

Equations $\eqref{eq:2.2.11} \eqref{eq:2.2.12} \eqref{eq:2.2.13} \eqref{eq:2.2.14} \eqref{eq:2.2.15}$ and $\eqref{eq:2.2.16}$ are substituted with equations $\eqref{eq:2.2.6}$ and $\eqref{eq:2.2.7}$ to acquire the following equation.

$$
\begin{equation}
\int_{V} \Delta S: (\delta \Delta E\_{L} + \delta \Delta E\_{NL})dV + \int_{V}\,\_{0}^{t} S : \delta \Delta E\_{NL}\, dV = ^{t'} \delta R - \int_V{\_{0}^t S} : \delta \Delta E\_{L}\,dV
\label{eq:2.2.17}
\end{equation}
$$

Herein, $\Delta S$ is assumed to be expressed as in the following equation in connection with $\Delta E\_L$ and the forth order tensor $^{t}\_{0} C$.

$$
\begin{equation}
\Delta S=^t_0 C:\Delta_t E_{L}
\label{eq:2.2.18}
\end{equation}
$$

Equation $\eqref{eq:2.2.17}$ is substituted with equation $\eqref{eq:2.2.18}$ and $\Delta S :\delta \Delta E_{NL}$ having two or more polynominals of $\Delta u$ are omitted to acquire the following equation.

$$
\begin{equation}
\int_V ( ^t\_{0}
C \Delta E\_{L} ) : \delta \Delta E\_{L}\, dV + \int_V\,^t\_{0} S : \delta \Delta E\_{NL}\, dV = \_{0}^{t'}\delta R - \int_V{\_{0}^t S} : \delta \Delta E_{L}\, dV
\label{eq:2.2.19}
\end{equation}
$$

Equation $\eqref{eq:2.2.19}$ is discretized by the finite element to acquire the following equation.

$$
\begin{equation}
\delta U^T ( ^t\_{0} K\_{L} + ^t\_{0} K\_{NL} ) \Delta U = \delta U^{T}\,\_{0}^{t'} F - \partial U^T\,^t\_{0} Q
\label{eq:2.2.20}
\end{equation}
$$

Herein, $^t_0 K$, $^t_0 K_{NL}$, $^{t'}_0 F$, $^t_0 Q$ are the initial displacement matrix, initial stress matrix, external force vector and internal force vector respectively.

Therefore, the recurrence equation to acquire the time $t'$ status from the time $t$ status is given by the following equation.

$i = 0$

Step1 :
$ \,^{t'}_0 K^{(0)}=^{t}_0 K_L+^{t}_0 K\_{NL};\,^{t'}_0 Q^{(0)}=^{t}_0 Q;\ U^{(0)}=^{t} U $
 
Step2 :
$ ^{t'}_0 K^{(i)}\Delta U^{(i)}=^{t'}_0 F-^{t'}_0 Q^{(i-1)} $

Step3 :
$ \,^{t'} U^{(i)}=^{t'} U^{(i-1)} + \Delta U^{(i)} $

$i = i + 1$

### Formulation of Updated Lagrange Method

The principle equation of the virtual work at time $t'$ assuming the current layout of time $t$ is the reference, is given by the following equation.

$$
\begin{equation}
\int_{V}\,^{t'}_{t} S:\delta_t^{t'}
E dV=\,^{t'}\delta R
\label{eq:2.2.21}
\end{equation}
$$

$$
\begin{equation}
^{t'}\delta R = \int_{S_t}\,^{t'}\_{t}\overline{t} \cdot \delta u\, dS + \int_{V}\,^{t'}\_{t}\overline{b} \cdot \delta u\, dV
\label{eq:2.2.22}
\end{equation}
$$

However,

$$
\begin{equation}
^{t'}\_{t} \overline{t} = \frac{d^{t'}s\_{t'}}{d^ts}\overline{t}
\label{eq:2.2.23}
\end{equation}
$$

$$
\begin{equation}
^{t'}\_{t} \overline{b} = \frac{d^{t'}v\_{t'}}{d^tv}\overline{b}
\label{eq:2.2.24}
\end{equation}
$$

although tensor $^{t'}_t S$, $^{t'}_t E$ and vector $^{t'}_t \overline{t}$, $^{t'}_t \overline{b}$ are using the current layout of time $t$ as reference, the Green-Lagrange strain does not include the initial displacement (displacement to time $t$) $^t u$;

$$
\begin{equation}
^{t'}\_{t} E = \Delta\_{t} E\_{L} + \Delta\_{t} E\_{NL}
\label{eq:2.2.25}
\end{equation}
$$

however, the equation becomes as follows.

$$
\begin{equation}
\Delta\_{t} E\_{L}=\frac{1}{2}
\left\lbrace \frac{\partial \Delta u}{\partial^t\, x} + \left(\frac{ \partial \Delta u}{\partial ^t\,x}\right)^\mathrm{T} \right\rbrace
\label{eq:2.2.26}
\end{equation}
$$

$$
\begin{equation}
\Delta_t E_{NL} = \frac{1}{2} \left( \frac{ \partial \Delta u}{\partial ^t\,x}\right)^\mathrm{T} \cdot \frac{ \partial \Delta u}{\partial^t\,x}
\label{eq:2.2.27}
\end{equation}
$$

On the other hand,

$$
\begin{equation}
\_{t'}^{t} S = \_{t}^{t} S + \Delta \_{t} S
\label{eq:2.2.28}
\end{equation}
$$

since the equation becomes as above, when this is arranged by substituting with equations $\eqref{eq:2.2.21}$ and $\eqref{eq:2.2.22}$, and equation $\eqref{eq:2.2.25}$, the eqation which must be solved is given as follows.

$$
\begin{equation}
\int_{t_{v}} \Delta\_{t} S : (\delta \Delta\_{t}{E\_{L}} + \delta \Delta\_t{E\_{NL}})d^t{v} + \int_{t\_{v}}{\_{t}^{t'}S} : \delta \Delta\_{t} {E\_{NL}}\,d^t{v}=^{t'} \delta R - \int_{t\_{v}}{\_{t}^t S} : \delta \Delta\_{t} E\_{L}\,d^t{v}
\label{eq:2.2.29}
\end{equation}
$$

In this case, $\Delta_t S$ is assumed to be expressed as in the following equation in connection with $\Delta_t E_t$ and forth order tensor $^t_t C$.

$$
\begin{equation}
\Delta_t S = ^t_t C : \Delta_t E_{L}
\label{eq:2.2.30}
\end{equation}
$$

This is substituted with equation $\eqref{eq:2.2.29}$ to acquire the following equation.

$$
\begin{equation}
\int_V ( ^t_t C \Delta\_{t} E\_{L} ) : \delta \Delta\_{t} E\_{L}\, dV+\int_V{^t\_{t} S} : \delta \Delta\_{t} E\_{NL}\, dV = ^{t'} \delta R - \int_V{\_{t}^t S} : \delta \Delta_t E\_{L}\, dV
\label{eq:2.2.31}
\end{equation}
$$

Equation $\eqref{eq:2.2.31}$ is discretized by the finite element to acquire the following equations.

$$
\begin{equation}
\delta U^T ( ^t_t K\_{L} + ^t_t K\_{NL} ) \Delta U = \delta U^{T}\, {\_{t}^{t'}} F - \partial U^T\, {^t\_{t} Q}
\label{eq:2.2.32}
\end{equation}
$$

Herein, $^t_t K_L$, $^t_t K_{NL}$, $^{t'}_t F$, $^t_t Q$ are the initial displacement matrix, initial stress matrix, external force vector and internal force vector respectively.

Therefore, the recurrence equation to acquire the time ${t'}$ status from the time $t$ status is given by the following equation.

$i = 0$

Step1 :
$\,\,\,^{t'}\_t K^{(i)}=\,^{t}\_t K\_L+^{t}\_t K\_{NL};\,^{t'}\_t Q^{(i)}=\, ^{t}\_t Q;\, U^{(i)}=\,^{t} U$

Step2 :
$\,\,\,^{t'}\_t K^{(i)} \Delta U^{(i)}=\, ^{t'}\_t F - ^{t'}\_t Q^{(i-1)}$

Step3 :
$\,\,\,^{t'} U^{(i)}=\, ^{t'} U^{(i-1)} + \Delta U^{(i)}$

$i = i + 1$

## Material Nonlinear Analysis Method

In this development code, 2 types of analysis, such as isotropic hyperelasticity and the elastoplasticity can be performed for nonlinear materials. When the material applicable for analysis is elastoplastic material, the updated Lagrange method is applied, and the total Lagrange method is applied for hyperelastic material. Moreover, the Newton-Raphson method is applied to the repetitive analysis method.

The outline of these constitutive equations of materials is shown in the following.

### Hyperelastic Material

The elastic potential energy in isotropic hyperelastic material can acquire the isotropic response from the initial state without the activation of stress. Therefore, the function of the main invariable of the right Cauchy-Green deformation tensor $C(I_1, I_2, I_3)$, or the main invariable of the deformation tensor excluding the change in volume $(\overline{I_1}, \overline{I_2}, \overline{I_3})$, can be expressed as $W = W(I_1, I_2, I_3)$, or $W=W(\overline{I_1}, \overline{I_2}, \overline{I_3})$.

The constitutive equation of hyperelastic material is defined by the relationship between the 2nd Piola-Kirchihoff stress and the Green-Lagrange strain, and the total Lagrange method is applied for the deformation analysis.

The elastic potential energey $W$ of the hyperelasticity model included in this development code is listed in the following. If the elastic potential energey $W$ is known, the 2nd Piola-Kircchoff stress and the stress-strain relationship can be calculated as follows.

$$
\begin{equation}
S = 2\frac{\partial W}{\partial C}
\label{eq:2.2.33}
\end{equation}
$$

$$
\begin{equation}
C = 4 \frac{ \partial^2 W}{\partial C \partial C}
\label{eq:2.2.34}
\end{equation}
$$

#### (1) Neo Hookean Hyperelasticity Model

The Neo-Hookean hyperelasticity model is a material model with an expanded linear rule (Hooke rule) having isotropy so that it can respond to finite deformation problems. The elastic potential is as follows.

$$
\begin{equation}
W = C\_{10} ( {\overline I\_{1}} - 3 ) + \frac{1}{D_1} ( J - 1 )^2
\label{eq:2.2.35}
\end{equation}
$$

Herein, $C_{10}$ and $D_1$ are the material constants.

#### (2) Mooney Rivlin Hyperelasticity Model

$$
\begin{equation}
W = C_{10}(\overline{I_1}-3) + C_{01}(\overline{I_2}-3) + \frac{1}{D_1} (J-1)^2
\label{eq:2.2.36}
\end{equation}
$$

Herein, $C_{10}, C_{01}$ and $D_1$ are the material constants.

#### (3) Arruda Boyce Hyperelasticity Model

$$
\begin{align}
W &= \mu \left[ \frac{1}{2} ( {\overline{I}}_1 - 3 )
   + \frac{1}{20 {\lambda_m}^2} ( \ {{\overline{I}}_1}^2 - 9 )
   + \frac{11}{1050 {\lambda_m}^2} ( {{\overline{I}}_1}^3 - 27 ) \nonumber \\\
  \qquad + \frac{19}{7000 {\lambda_m}^2} ( {{\overline{I}}_1}^4 - 81 )
   + \frac{519}{673750 {\lambda_m}^2} ( {{\overline{I}}_1}^5 - 243 ) \right] \\\
  &+ \frac{1}{D} \left( \frac{J^2 - 1}{2} - \ln J \right)
\label{eq:2.2.37}
\end{align}
$$

$$
\begin{equation}
\mu = \frac{\mu_0}{1 + \cfrac{3}{5 \lambda_m^2} + \cfrac{99}{175 \lambda_m^4} + \cfrac{513}{875 \lambda_m^6} + \cfrac{42039}{67375 \lambda_m^8}}
\label{eq:2.2.38}
\end{equation}
$$

Herein, $\mu$, $\lambda_m$ and $D$ are the material constants.

### Elastoplastic Material

In this development code, the elastoplasticity constitutive equation accoding to the associated flow rule is applied. Moreover, the constitutive expresses the relationshop between the Jaumman rate and the deformation rate tensor of the Kirchhoff stress, and the updated Lagrange method is applied in the deformation analysis.

#### (1) Elastoplastic Constitutive Equation

The yield criteria of an elasto-plastic solid is assumed to be given as follows.

Initla Yield Criteria

$$
\begin{equation}
F( \sigma, \sigma_{y_0})
\label{eq:2.2.39}
\end{equation}
$$

Consecutive Yield Criteria

$$
\begin{equation}
F(\sigma, \sigma_y (\overline{e}^p))
\label{eq:2.2.40}
\end{equation}
$$

Where,

  - $F$ : Yield function
  - $\sigma_{y_0}$ : Initial yield stress
  - $\sigma_y$ : Consecutive yield stress
  - $\sigma$ : Stress tensor
  - $e$ : Infinitesimal strain tensor
  - $e^p$ : Plastic strain tensor
  - $\overline{e}^p$ : Equivalent plastic strain

The yield stress-equivalent plastic strain relationship is assumed to conform to the stress-plastic strain relationship in a single axis state.

Stress-plastic strain relationship in a single axis state:

$$
\begin{equation}
\sigma = H(e^p)
\label{eq:2.2.41}
\end{equation}
$$

$$
\begin{equation}
\frac{d \sigma}{d e^p} = H'
\label{eq:2.2.42}
\end{equation}
$$

Where,

  - $H'$ : Strain hardening factor

Eauivalent stress-equivalent plastic strain relationship:

$$
\begin{equation}
\overline{\sigma} = H(\overline{e}^p)
\label{eq:2.2.43}
\end{equation}
$$

$$
\begin{equation}
\dot{\overline{\sigma}} = H' \dot{\overline{e}}^p
\label{eq:2.2.44}
\end{equation}
$$

The consecutive yield function is generally a function of temperature and plastic strain work.

However, for simplification, the function is only assumed to be the equivalent plastic strain $\overline{e}^p$ in this section. Since $F=0$ continues to be satisfied during the progression of the plastic deformation, the following equation must be established.

$$
\begin{equation}
\dot{F} = \frac{\partial F}{\partial \sigma} : \dot{\sigma} + \frac{\partial F}{\partial e^p} : \dot{e}^p = 0
\label{eq:2.2.45}
\end{equation}
$$

$\dot{F}$ is equation $\eqref{eq:2.2.45}$ expresses the time derivative function of $F$, and the time derivative function of certain amount of $A$ is expressed as $\dot{A}$ hereafter.

In this case, assuming the existence of plastic potential $\Theta$, the plastic strain rate is expressed by the following equation.

$$
\begin{equation}
\dot{e}^p=\dot{\lambda}\frac{\partial \Theta}{\partial \sigma}
\label{eq:2.2.46}
\end{equation}
$$

Herein, $\dot{\lambda}$ is the factor.

Furthermore, assuming that plastic potential $\Theta$ is equivalent to yield function $F$, the associated flow rule is assumed as in the following equation.

$$
\begin{equation}
\dot{e}^p = \dot{\lambda} \frac{\partial F}{\partial \sigma}
\label{eq:2.2.47}
\end{equation}
$$

When this equation is substituted with equation $\eqref{eq:2.2.45}$, the following equation can be acquired.

$$
\begin{equation}
\dot{\lambda} = \frac{a^T : d_D }{A + a^T : D : a}\dot{e}
\label{eq:2.2.48}
\end{equation}
$$

Where, $D$ is the elastic matrix,

$$
\begin{align}
  a^T &= \frac{\partial F}{\partial \sigma}
& d_D &= D a^T
&   A &= -\frac{ a }{\dot{\lambda}} \frac{\partial F}{\partial e^p} : \dot{e}^p
\label{eq:2.2.49}
\end{align}
$$

the stress-strain relational expression of the elastoplasticity can be written as follows.

$$
\begin{equation}
\dot{\sigma} =
\left\lbrace
D -
\frac{d_D \otimes {d_D}^\mathrm{T}}
     {A + {d_D}^\mathrm{T} a}
\right\rbrace
: \dot{e}
\label{eq:2.2.50}
\end{equation}
$$

When the yield function $\eqref{eq:2.2.50}$ of an elastoplastic material is known, the constitutive equation can be acquired from this equation.

#### (1) Yield Function

The elastoplastic yield functions included in this development code are listed in the following.

- Von Mises Yield Function

$$
\begin{equation}
F = \sqrt{3 J\_2} - \sigma\_y = 0
\label{2.2.51}
\end{equation}
$$

- Mohr-Coulomb Yield Function

$$
\begin{equation}
F = \sigma_1 - \sigma_3 + \ ( \ \sigma_1 + \sigma_3\  )\sin \phi - 2 \ c \cos \phi = 0
\label{eq:2.2.52}
\end{equation}
$$

- Drucker-Prager Yield Function

$$
\begin{equation}
F = \sqrt{J\_2} - \ \alpha\ \sigma \ : I - \sigma_y = 0
\label{eq:2.2.53}
\end{equation}
$$

In this case, material constant $\alpha$ and $\sigma_y$ are calculated as follows from viscosity and friction angle of the material.

$$
\begin{align}
  \alpha &= \frac{2 \sin \phi}{3 + \sin \phi}\
& \sigma_y &= \frac{6\ c \cos \phi}{3 + \sin \phi}
\label{eq:2.2.54}
\end{align}
$$

### Viscoelastic Material

A generalized Maxwell model is applied in this development code. As shown in the following, the constitutive equation becomes a function of deviatoric strain $e$ and deviatoric viscosity strain $q$.

$$
\begin{equation}
\sigma \ (t) = Ktr \varepsilon I + 2 G ( \mu_0 e + \mu q )
\label{eq:2.2.55}
\end{equation}
$$

Which becomes,

$$
\begin{align}
\mu q &= \sum_{m = 1}^{M} \mu_{m} q^{(m)}
      & \sum_{m = 0}^{M} \mu_{m} = 1
\label{eq:2.2.56}
\end{align}
$$

Moreover, $q$ can be calculated from the following equation.

$$
\begin{equation}
{\dot{q}}^{(m)} + \frac{1}{\lambda_{m}} q^{(m)} = \dot{e}
\label{eq:2.2.57}
\end{equation}
$$

Herein, $\lambda_m$ is the relaxation. Relaxation factor $G$ is expressed by the following Prony series.

$$
\begin{equation}
G (t) = G \left[ \mu_0 + \sum_{i = 1}^M {\mu_m \exp\left( \frac{-t}{\lambda_m \ } \right)} \right]
\label{eq:2.2.58}
\end{equation}
$$

### Creep Material

Time dependent displacement under constant stress conditions is a phenomenon called "creep". The viscoelasticity behavior mentioned above can also be considered as a type of linear creep phenomenon. Sevral types of nonlinear creeping are described in this section. The method to form the constitutive equation by adding to the strain generated momentarily is generally used for this phenomenon, and the strain while a certain constant load is continued, is assumed to be creep strain $\varepsilon^c$. The creep strain rate $\dot{\varepsilon}^c$ which is defined as function of the stress and overall creep strain, is generally used in the constitutive equation in consideration of the creep.

$$
\begin{equation}
{\dot{\varepsilon}}^c \equiv \frac{\partial \varepsilon^c}{\partial t} = \beta ( \,\sigma,\ \varepsilon^c\  )
\label{eq:2.2.59}
\end{equation}
$$

In this case, assuming the strain generated momentarily is the elastic strain $\varepsilon^e$, the overall strain can be expressed as int the following equation where the creep strain is added.

$$
\begin{equation}
\varepsilon = \varepsilon^e + \varepsilon^c
\label{eq:2.2.60}
\end{equation}
$$

Which becomes,

$$
\begin{equation}
\varepsilon^e = {c^e}^{-1}\ : \sigma
\label{eq:2.2.61}
\end{equation}
$$

A mentioned in the above plastic material, the time integration method for the numerical analysis must be indicated for the constitutive equation which indicates the creep. The constitutive equation when creep is taken into consideration is,

$$
\begin{equation}
\sigma\_{n + 1} = c\ :\ ( \varepsilon\_{n + 1} - \varepsilon\_{n + 1}^c )
\label{eq:2.2.62}
\end{equation}
$$

$$
\begin{equation}
\varepsilon\_{n + 1}^c = \varepsilon\_n^c + \ \Delta t\ \beta\_{n + \theta}
\label{eq:2.2.63}
\end{equation}
$$

Where, $\beta_{n+\theta}$ becomes as follows.

$$
\begin{equation}
\beta_{n + \theta} = ( 1 - \theta  ) \beta\_n + \theta \beta\_{n + 1}
\label{eq:2.2.64}
\end{equation}
$$

Moreover, the creep strain increment $\Delta \varepsilon^c$ is assumed to be a simplified nonlinear equation.

$$
\begin{equation}
R\_{n + 1} = \varepsilon\_{n + 1} - \ c^{- 1}\ : \sigma\_{n + 1} - \ \varepsilon\_n^c - \ \Delta t\ \beta\_{n + \theta} = \mathbf{0}
\label{eq:2.2.65}
\end{equation}
$$

In the iterative calculation of the Newton-Raphson method, the following equation is used for the iterative solution and the increment solution as an incremental strain where the initial value is calculated by $\sigma_{n+1} = \sigma_n$ and the finite element method.

$$
\begin{equation}
R\_{n + 1}^{(k + 1)} = \mathbf{0} = \ R_{n + 1}^{(k)} - ( \ c^{- 1} + \Delta t\ c\_{n + 1}^c\  ) d \sigma\_{n + 1}^{(k)}
\label{eq:2.2.66}
\end{equation}
$$

Which becomes,

$$
\begin{equation}
c^c_{n+1} = 
\left. \frac{\partial\beta}{\partial\sigma} \right|\_{n+\theta}
=
\left. \theta\frac{\partial\beta}{\partial\sigma} \right|\_{n+1}
\label{eq:2.2.67}
\end{equation}
$$

When the solution of equation $\eqref{eq:2.2.65}$ and equation $\eqref{eq:2.2.66}$ are used to perform the iterative solution method until the residual $R$ becomes $0$, stress $\sigma_{n+1}$ and the tangent tensile modulus are used.

$$
\begin{equation}
c\_{n + 1}^* = [ c^{-1} + \Delta t c\_{n + 1}^c ]^{- 1}
\label{eq:2.2.68}
\end{equation}
$$

As a detailed equation $\eqref{eq:2.2.58}$, the following Norton model is appliec in this development code. In the constitutive equation, the equivalent clip strain $\dot{\varepsilon}^{cr}$ as in the following equation expressed the function of the Mises stress $q$ and time $t$.

$$
\begin{equation}
{\dot{\varepsilon}}^{cr} = A q^n t^m
\label{eq:2.2.69}
\end{equation}
$$

Herein, $A$, $m$ and $n$ are the material constants.

## Contact Analysis Method

When two objects are in contact, the contact force $t_c$ is transmitted via the contact surface.

The primciple equation $\eqref{eq:2.2.4}$ of the virtual work can be rewritten as follows.

$$
\begin{equation}
\int^{t'}\_{^{t'}v}\,^{t'} \sigma : \delta^{t'} A\_{(L)} d^{t'}v = \int^{t'}\_{^{t'}S\_{t}}\,^{t'} \overline{t} \cdot \delta u d^{t'}s+ \int^{t'}\_{V} \overline{b} \cdot \delta u d^{t'}v + \int^{t'}\_{^{t'} S \_{c}}t\_{c}[\delta u^{(1)} - u^{(2)}]
\label{eq:2.2.70}
\end{equation}
$$

In this case, $S_c$ expresses the contact area, and $u^{(1)}$ and $u^{(2)}$ express the displacement of contact object 1 and contact object 2 respectively.

In the contact analysis, the surfaces which may contact are specified in a pair. One of these surfaces is called the master surface, and the other surface is the slave surface. In this master slave analysis method, the contact restriction conditions are assumed as follows.

  1. The slave node does not penetrate the master surface.
  2. When there is contact, the slave node becomes the contact position, and the master surface and the slave surface mutually transmit the contact force and the frictional force through this point of contact.

The last term of equation $\eqref{eq:2.2.55}$ is discretized by the finite element to acquire the following equation.

$$
\begin{equation}
\int^{t'}\_{^{t'}S\_{c}} t\_c [\delta u^{(1)} - \delta u^{(2)}] \approx \delta UK\_c \Delta U + \delta UF\_c
\label{eq:2.2.71}
\end{equation}
$$

In this case, $K_c$ and $F_c$ express the contact rigid matrix and contact force respectively. When this equation is substituted with equation $\eqref{eq:2.2.20}$ or $\eqref{eq:2.2.32}$, the finite element method of the total Lagrange method and the updated Lagrange method in consideration of the contact restraint becomes as follows.

$$
\begin{equation}
\delta U^T ( ^t\_0 K\_L + ^t\_0 K\_{NL} + K\_c ) \Delta U = \delta U^T {\_0^{t'} F} - \partial U^T {^t\_0 Q} + \delta UF\_c
\label{eq:2.2.72}
\end{equation}
$$

$$
\begin{equation}
\delta U^T (^t\_t K\_L + ^t\_t K\_{NL} + K\_c ) \Delta U = \delta U^T {\_{t} ^{t'} F} - \partial U^T {^t\_t Q}+ \delta UF\_c
\label{eq:2.2.73}
\end{equation}
$$

This development code allows for contact deformation analysis between deformable bodies, and the following analysis functions can be selected by the user.

  - Infinitesimal sliding contact problem: This analysis assumes that there is no position change of the point of contact.
  - Limited sliding contact problem: This analysis can be used when there is a change of the point of contact accompanying the deformation.
  - Frictionless contact problem
  - Friction contact problem: This analysis supports the Coulomb friction rule.

However, when the infinitesimal deformation linear elastic analysis is selected, it becomes an infinitesimal sliding frictionless problem.

Moreover, it only corresponds to the contact analysis of a linear solid element (element numbers 341, 351, 361) at present.

