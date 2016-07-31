## Infinitesimal Deformation Linear Elasticity Static Analysis

The formulation for the elastic static analysis based on the
infinitesimal deformation theory is described in this section. The
linear elasticity is assumed as the stress and strain relationship.

### Basic Equation

The equilibrium equation of solid mechanics, dynamic boundary conditions
and the geometric boundary conditions (basic boundary conditions) are
given by the following equation (Refer to Figure 2.1.1).

  ![](media/image1.png)   (2.1.1)
  ----------------------- ---------
  ![](media/image2.png)   (2.1.2)
  ![](media/image3.png)   (2.1.3)

Herein, ![](media/image4.png) is the stress, ![](media/image5.png) is
the surface force, ![](media/image6.png) is the body force, and
![](media/image7.png) expresses the dynamic boundary and
![](media/image8.png) expresses the geometric boundary.

![](media/image9.png){width="1.7902777777777779in"
height="1.7083333333333333in"}

Figure 2.1.1:　Boundary Value Problem in Solid Mechanics (Infinitesimal
Deformation Problem)

The strain and displacement relational expression in the infinitesimal
deformation problem is given by the following equation.

  ![](media/image10.png)   (2.1.4)
  ------------------------ ---------

The stress and strain relational expression (constitutive equation) in
the linear elastic body is given by the following equation.

  ![](media/image11.png)   (2.1.5)
  ------------------------ ---------

![](media/image12.png) Herein, C is the fourth order elastic tensor.

### Principle of Virtual Work

The principle of the virtual work regarding the infinitesimal
deformation linear elasticity problem equivalent to the basic equations
(2.1), (2.1.2) and (2.1.3), is expressed as in the following equation.

  ![](media/image13.png)   (2.1.6)
  ------------------------ ---------
  ![](media/image14.png)   (2.1.7)

Furthermore, in consideration of the constitutive equation (2.1.5),
equation (2.1.6) is expressed as in the following equation.

  ![](media/image15.png)   (2.1.8)
  ------------------------ ---------

In equation (2.1.8), ![](media/image16.png) is the strain tensor and C
is the forth order elastic tensor. In this case, when stress tensor
![](media/image17.png) and strain tensor ![](media/image18.png) are
expressed by each vector forms ![](media/image19.png) and
![](media/image20.png), the constitutive equation (2.1.5) is expressed
as in the following equation.

  ![](media/image21.png)   (2.1.9)
  ------------------------ ---------

Herein, D is the elastic matrix.

In consideration of stress ![](media/image19.png) and
![](media/image20.png) expressed by the vector forms and equation
(2.1.9), equation (2.1.8) is expressed as in the following equation.

  ![](media/image22.png)   (2.1.10)
  ------------------------ ----------

Equation (2.1.10) and equation (2.1.7) are the principles of the virtual
work discretized in this development code.

### Formulation

The principle equation (2.1.10) of the virtual work is discretized for
each finite element to acquire the following equation.

  ![](media/image23.png)   (2.1.11)
  ------------------------ ----------

Using the displacement of the nodes which consist of elements, the
displacement field is interpolated for each element as in the following
equation.

  ![](media/image24.png)   (2.1.12)
  ------------------------ ----------

The strain in this case, is given as in the following equation using
equation (2.1.4).

  ![](media/image25.png)   (2.1.13)
  ------------------------ ----------

Equations (2.1.12) and (2.1.13) are substituted with equation (2.1.11)
to acquire the following equation.

  ![](media/image26.png)   (2.1.14)
  ------------------------ ----------

Equation (2.1.14) can be summarized as in the following equation.

  ![](media/image27.png)   (2.1.15)
  ------------------------ ----------

Where,

  ![](media/image28.png)   (2.1.16)
  ------------------------ ----------
  ![](media/image29.png)   (2.1.17)

The components of the matrix and vectors defined by the following
equations (2.1.16) and (2.1.17) can be calculated and overlapped for
each finite element.

The following equation can be acquired by forming equation (2.1.15) for
the arbitrary virtual displacement![](media/image30.png).

  ![](media/image31.png)   (2.1.18)
  ------------------------ ----------

On the other hand, the displacement boundary condition equation (2.1.3)
is expressed as in the following equation.

  ![](media/image32.png)   (2.1.19)
  ------------------------ ----------

Node displacement **U** can be determined by solving equation (2.1.18)
by the restriction condition equation (2.1.19).
