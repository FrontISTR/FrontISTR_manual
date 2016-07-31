## Heat Conduction Analysis

The heat conduction analysis method for solids by the finite element
method used in this development code is shown in the following.

### Basic Equation

The heat conduction equation during the continuum is as follows.

  ![](media/image135.png)   (2.4.1)
  ------------------------- ---------

However,

![](media/image136.png)　　　　　　　Mass (Density)

![](media/image137.png) 　　　　　　Specific heat

![](media/image138.png) 　　　　　　Temperature

![](media/image139.png)　　　　　　Thermal conductivity

![](media/image140.png)　　　　　Calorific value

Herein, ![](media/image141.png) expresses the position,
![](media/image142.png) is the temperature and ![](media/image143.png)
is the time.

The area being considered is ![](media/image144.png) and the periphery
is ![](media/image145.png). When assuming the boundary conditions of
either the Dirichet type or the Neumann type is given everywhere on
![](media/image146.png), the boundary conditions become as follows.

  ![](media/image147.png)   (2.4.2)
  ------------------------- ---------
  ![](media/image148.png)   (2.4.3)

However, the function form ![](media/image149.png), q is already known.
ｑ is the heat flux outflow from the boundary. Three types of heat flux
can be considered in this program.

  ![](media/image150.png)   (2.4.4)
  ------------------------- ---------
  ![](media/image151.png)   (2.4.5)
  ![](media/image152.png)   (2.4.6)
  ![](media/image153.png)   (2.4.7)

![](media/image154.png) is the distributed heat flux,
![](media/image155.png) is the heat flux by the convective heat
transfer, and ![](media/image156.png) is the heat flux by the radiant
heat transfer.

However,

![](media/image157.png) Convective heat transfer coefficient ambient
temperature

![](media/image158.png) Convective heat transfer factor

![](media/image159.png) Radiant heat transfer coefficient ambient
temperature

![](media/image160.png) Radiant heat transfer factor

ε: Radiant rate, σ: Stefan-Boltzmann constant, ![](media/image161.png):
Shape factor

### Discretization

When equation (2.4.1) is discretized by the Galerkin method, it becomes
as follows.

  ![](media/image162.png)   (2.4.8)
  ------------------------- ---------

However,

  ---------------------------------------------------
  ![](media/image163.png)                  (2.4.9)

  ![](media/image164.png)                  
  ---------------------------------------- ----------
  ![](media/image165.png)                  (2.4.10)

  ![](media/image166.png)                  (2.4.11)

  ![](media/image167.png)                  

  ![](media/image168.png): Form function   (2.4.12)
  ---------------------------------------------------

Equation (2.4.8) is a nonlinear and unsteady equation. Now, when the
time is discretized by the backward Euler's rule and the temperature at
time ![](media/image169.png) is already known, the temperature at
![](media/image170.png) is calculated using the following equation.

  ![](media/image171.png)   (2.4.13)
  ------------------------- ----------

The acquisition of a solution with better
accuracy![](media/image172.png), is considered by improving the
temperature vector ![](media/image173.png) which satisfies the
approximation of equation (2.4.13).

Therefore, first, the temperature vector is expressed as follows.

  ![](media/image174.png)   (2.4.14)
  ------------------------- ----------

The product of the heat conduction matrix and temperature vector, mass
matrix and etc. are expressed in approximation as in the following
equation.

  ------------------------------------
  ![](media/image175.png)   (2.4.15)

  ![](media/image176.png)   
  ------------------------- ----------
  ![](media/image177.png)   (2.4.16)
  ------------------------------------

When equations (2.4.14) (2.4.15) and (2.4.16) are substituted with
equation (2.4.13) and two or more polynomials are omitted, the following
equation can be acquired.

  ------------------------------------
  ![](media/image178.png)   (2.4.17)

  ![](media/image179.png)   
  ------------------------- ----------
  ------------------------------------

Furthermore, an approximation evaluation is performed for the left
factor matrix using the following equation.

  ------------------------------------
  ![](media/image180.png)   (2.4.18)

  ![](media/image181.png)   
  ------------------------- ----------
  ------------------------------------

In this case,![](media/image182.png) is the tangent stiffness matrix.

Finally, the temperature at time ![](media/image183.png) can be
calculated by performing an iterative calculation using the following
equation.

  ------------------------------------
  ![](media/image184.png)   (2.4.19)

  ![](media/image179.png)   

  ![](media/image185.png)   
  ------------------------- ----------
  ------------------------------------

Particularly, in the analysis for a steady state, the following equation
is used to perform the iterative calculation.

  ------------------------------------
  ![](media/image186.png)   (2.4.20)

  ![](media/image187.png)   
  ------------------------- ----------
  ------------------------------------

Since an implicit method is used for the discretization regarding the
time to select time increment ⊿ｔ in the unsteady state analysis,
generally, there are no concerns in the restrictions of the size.
However, if time increment ⊿ｔ is too large, the convergence frequency
will increase in the iterative calculation. Therefore, this program is
equipped with an automatic increment function to always monitor the size
of the residual vectors during the iterative calculation process, and if
the convergence of the iterative calculation is too slow, time increment
⊿ｔ is decreased, and if the iterative calculation frequency decreases,
time increment ⊿ｔ is increased.
