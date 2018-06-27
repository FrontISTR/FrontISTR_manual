<script type="text/x-mathjax-config">
MathJax.Hub.Config({
  tex2jax: {
    inlineMath: [['$','$'], ['\\(','\\)']],
    processEscapes: true
  },
  CommonHTML: { matchFontHeight: true },
  displayAlign: "center"
});
</script>
<script async src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS_CHTML"></script>

## Verification by Simple Geometric Model

### Elastic static analysis

The subject in this verification was a cantilever beam with mesh partitioning as shown in Figure 9.1.1. Regarding the verification conditions, the analysis was performed with 7 conditions from exA - exG where the load conditions were changed as shown in Figure 9.1.2. In addition, this is a verification case where a direct method solver was used, with the same load conditions as exA being applied to exG.

The verification results for each case are shown in Table 9.1.1 ~ Table 9.1.7.

<div style="text-align: center;">
<img src="../media/image01_01.png" width="350px"><br>
Figure 9.1.1: Example of Mesh Partitioned Cantilever Beam (Hexahedral Element)
</div>

|   |   |
|---|---|
|<img src="../media/image01_02.png" width="350px">|(a) exA,G : Concentrated load|
|<img src="../media/image01_03.png" width="350px">|(b) exD : Gravity|
|<img src="../media/image01_04.png" width="350px">|(c) exB : Surface distributed load|
|<img src="../media/image01_05.png" width="350px">|(d) exE : Centrifugal force|
|<img src="../media/image01_06.png" width="350px">|(e) exC : Volumetric load|
|<img src="../media/image01_07.png" width="350px">|(f) exF : Heat load|

|  |  |
|:--|:--|
|Young's Modulus                      | $E = 4000.0\ kgf/mm^2$ |
|Length                               | $L = 10.0\ mm$ |
|Poisson's Ratio                      | $\nu = 0.3$ |
|Cross-sectional area                 | $A = 1.0\ mm^2$ |
|Mass density                         | $\rho = 8.0102 \times 10^{-10}\ kg\,s^2/mm^4$ |
|Geometrical moment of inertia        | $I = 1.0/12.0\ mm^4$ |
|Gravitational acceleration           | $g = 9800.0\ mm/s^2$ |
|Linear thermal expansion coefficient | $\alpha = 1.0 \times 10^{-5}$ |

<div style="text-align: center; margin-bottom: 3em;">
Figure 9.1.2: Verification Conditions of Cantilever Beam Model
</div>

<div style="text-align: center; margin-top: 3em;">
Table 9.1.1: exA: Verification Results of Concentrated Load Problem
</div>

| Case Name | No. of Elements | | Predicated Value : $\delta\_{max}= -1.000$ | | Remarks |
|:-:|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | ABAQUS | FrontISTR | |
| A231 | 40  | -0.338 | -0.371 | -0.371 | 33 nodes / plane stress problem |
| A232 | 40  | -0.942 | -1.002 | -1.002 | 105 nodes / plane stress problem |
| A241 | 20  | -0.720 | -0.711 | -0.711 | 33 nodes / plane stress problem |
| A242 | 20  | -0.910 | -1.002 | -1.002 | 85 nodes / plane stress problem |
| A341 | 240 | -0.384 | -0.384 | -0.386 | 99 nodes |
| A342 | 240 | -0.990 | -0.990 | -0.999 | 525 nodes |
| A351 | 80  | -0.353 | -0.355 | -0.351 | 99 nodes |
| A352 | 80  | -0.993 | -0.993 | -0.992 | 381 nodes |
| A361 | 40  | -0.954 | -0.985 | -0.984 | 99 nodes |
| A362 | 40  | -0.994 | -0.993 | -0.993 | 220 nodes |
| A731 | 40  | -      | -      | -0.991 | 33 nodes / direct method |
| A741 | 20  | -      | -      | -0.996 | 33 nodes / direct method |

<div style="text-align: center;margin-top: 3em;">
Table 9.1.2: exB: Verification Results of Surface Distributed Load Problem
</div>

| Case Name | No. of Elements | | Predicated Value : $\delta\_{max}= -3.750$ | | Remarks |
|:-:|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | ABAQUS | FrontISTR | |
| B231 | 40  | -1.281 | -1.403 | -1.403 | 33 nodes / plane stress problem |
| B232 | 40  | -3.579 | -3.763 | -3.763 | 105 nodes / plane stress problem |
| B241 | 20  | -3.198 | -2.680 | -2.680 | 33 nodes / plane stress problem |
| B242 | 20  | -3.426 | -3.765 | -3.765 | 85 nodes / plane stress problem |
| B341 | 240 | -1.088 | -1.449 | -1.454 | 99 nodes |
| B342 | 240 | -3.704 | -3.704 | -3.748 | 525 nodes |
| B351 | 80  | -3.547 | -1.338 | -1.325 | 99 nodes |
| B352 | 80  | -0.3717| -3.716 | -3.713 | 381 nodes |
| B361 | 40  | -3.557 | -3.691 | -3.688 | 99 nodes |
| B362 | 40  | -3.726 | -3.717 | -3.717 | 220 nodes |
| B731 | 40  | -      | -      | -3.722 | 33 nodes / direct method |
| B741 | 20  | -      | -      | -3.743 | 33 nodes / direct method |

<div style="text-align: center;margin-top:3em;">
Table 9.1.3: exC: Verification Results of Volumetric Load Problem
</div>

| Case Name | No. of Elements | | Predicated Value : $\delta_{max}=$ -2.944e-5 | | Remarks |
|:-:|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | ABAQUS | FrontISTR | |
| C231 | 40  | - | -1.101e-5 | -1.101e-5 | 33 nodes / plane stress problem |
| C232 | 40  | - | -2.951e-5 | -2.951e-5 | 105 nodes / plane stress problem |
| C241 | 20  | - | -2.102e-5 | -2.102e-5 | 33 nodes / plane stress problem |
| C242 | 20  | - | -2.953e-5 | -2.953e-5 | 85 nodes / plane stress problem |
| C341 | 240 | - | -1.136e-5 | -1.140e-5 | 99 nodes |
| C342 | 240 | - | -2.905e-5 | -2.937e-5 | 525 nodes |
| C351 | 80  | - | -1.050e-5 | -1.039e-5 | 99 nodes |
| C352 | 80  | - | -2.914e-5 | -2.911e-5 | 381 nodes |
| C361 | 40  | - | -2.895e-5 | -2.893e-5 | 99 nodes |
| C362 | 40  | - | -2.915e-5 | -2.915e-5 | 220 nodes |
| C731 | 40  | - | -         | -2.922e-5 | 33 nodes / direct method |
| C741 | 20  | - | -         | -2.938e-5 | 33 nodes / direct method |

<div style="text-align: center;margin-top: 3em;">
Table 9.1.4: exD: Verification Results of Gravity Problem
</div>

| Case Name | No. of Elements | | Predicated Value : $\delta_{max}=$ -2.944e-5 | | Remarks |
|:-:|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | ABAQUS | FrontISTR | |
| D231 | 40  | -1.101e-5 | -1.101e-5 | -1.101e-5 | 33 nodes / plane stress problem |
| D232 | 40  | -2.805e-5 | -2.951e-5 | -2.951e-5 | 105 nodes / plane stress problem |
| D241 | 20  | -2.508e-5 | -2.102e-5 | -2.102e-5 | 33 nodes / plane stress problem |
| D242 | 20  | -2.684e-5 | -2.953e-5 | -2.953e-5 | 85 nodes / plane stress problem |
| D341 | 240 | -1.172e-5 | -1.136e-5 | -1.140e-5 | 99 nodes |
| D342 | 240 | -2.906e-5 | -2.905e-5 | -2.937e-5 | 525 nodes |
| D351 | 80  | -1.046e-5 | -1.050e-5 | -1.039e-5 | 99 nodes |
| D352 | 80  | -2.917e-5 | -2.914e-5 | -2.911e-5 | 381 nodes |
| D361 | 40  | -2.800e-5 | -2.895e-5 | -2.893e-5 | 99 nodes |
| D362 | 40  | -2.919e-5 | -2.915e-5 | -2.915e-5 | 220 nodes |
| D731 | 40  | -         | -         | -2.922e-5 | 33 nodes / direct method |
| D741 | 20  | -         | -         | -2.938e-5 | 33 nodes / direct method |

<div style="text-align: center; margin-top:3em;">
Table 9.1.5: exE: Verification Results of Centrifugal Force Problem
</div>

| Case Name | No. of Elements | | Predicated Value : $\delta_{max}=$ 2.635e-5 | | Remarks |
|:-:|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | ABAQUS | FrontISTR | |
| E231 | 40  | 2.410e-3 | 2.616e-3 | 2.650e-3 | 33 nodes / plane stress problem |
| E232 | 40  | 2.447e-3 | 2.627e-3 | 2.628e-3 | 105 nodes / plane stress problem |
| E241 | 20  | 2.386e-3 | 2.622e-3 | 2.624e-3 | 33 nodes / plane stress problem |
| E242 | 20  | 2.387e-3 | 2.627e-3 | 2.629e-3 | 85 nodes / plane stress problem |
| E341 | 240 | 2.708e-3 | 2.579e-3 | 2.625e-3 | 99 nodes |
| E342 | 240 | 2.639e-3 | 2.614e-3 | 2.638e-3 | 525 nodes |
| E351 | 80  | 2.642e-3 | 2.598e-3 | 2.625e-3 | 99 nodes |
| E352 | 80  | 2.664e-3 | 2.617e-3 | 2.616e-3 | 381 nodes |
| E361 | 40  | 2.611e-3 | 2.603e-3 | 2.603e-3 | 99 nodes |
| E362 | 40  | 2.623e-3 | 2.616e-3 | 2.616e-3 | 220 nodes |
| E731 | 40  | -        | -        | 2.619e-3 | 33 nodes / direct method |
| E741 | 20  | -        | -        | 2.622e-3 | 33 nodes / direct method |

<div style="text-align: center; margin-top:3em;">
Table 9.1.6: exF: Verification Results of Thermal Stress Load Problem
</div>

| Case Name | No. of Elements | | Predicated Value : $\delta_{max}=$ 1.000e-2 | | Remarks |
|:-:|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | ABAQUS | FrontISTR | |
| F231 | 40  | - | 1.016e-2 | 1.007e-2 | 33 nodes / plane stress problem |
| F232 | 40  | - | 1.007e-2 | 1.007e-2 | 105 nodes / plane stress problem |
| F241 | 20  | - | 1.010e-2 | 1.010e-2 | 33 nodes / plane stress problem |
| F242 | 20  | - | 1.006e-2 | 1.006e-2 | 85 nodes / plane stress problem |
| F341 | 240 | - | 1.047e-2 | 1.083e-2 | 99 nodes |
| F342 | 240 | - | 1.018e-2 | 1.022e-2 | 525 nodes |
| F351 | 80  | - | 1.031e-2 | 1.062e-2 | 99 nodes |
| F352 | 80  | - | 1.015e-2 | 1.017e-2 | 381 nodes |
| F361 | 40  | - | 1.026e-2 | 1.026e-2 | 99 nodes |
| F362 | 40  | - | 1.016e-2 | 1.016e-2 | 220 nodes |

<div style="text-align: center;margin-top: 3em;">
Table 9.1.7: exG: Verification Results of Direct Method (Concentrated Load Problem)
</div>

| Case Name | No. of Elements | | Predicated Value : $\delta_{max}=$ -1.000 | | Remarks |
|:-:|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | ABAQUS | FrontISTR | |
| G231 | 40  | -0.338 | -0.371 | -0.371 | 33 nodes / plane stress problem |
| G232 | 40  | -0.942 | -1.002 | -1.002 | 105 nodes / plane stress problem |
| G241 | 20  | -0.720 | -0.711 | -0.711 | 33 nodes / plane stress problem |
| G242 | 20  | -0.910 | -1.002 | -1.002 | 85 nodes / plane stress problem |
| G341 | 240 | -0.384 | -0.384 | -0.386 | 99 nodes |
| G342 | 240 | -0.990 | -0.990 | -0.999 | 52 nodes |
| G351 | 80  | -0.353 | -0.355 | -0.351 | 99 nodes |
| G352 | 80  | -0.993 | -0.993 | -0.992 | 381 nodes |
| G361 | 40  | -0.954 | -0.985 | -0.984 | 99 nodes |
| G362 | 40  | -0.994 | -0.993 | -0.993 | 220 nodes |
| G731 | 40  | -      | -      | -0.991 | 33 nodes / direct method |
| G741 | 20  | -      | -      | -0.996 | 33 nodes / dierct method |

### Nonlinear static analysis

#### (2-1) exnl1: Geometrical nonlinear analysis

The same model of verification case exA - G was used for the verification model of verification case exI. The conceptual diagram of the verification model is shown in Figure 9.1.3. A geometric nonlinear analysis is implemented in this model. The verification results are shown in Table 9.1.8. A nonlinear calculation of the load increment value of 0.1P for 10 steps is implemented for the final load of 1.0P.

<div style="text-align: center;">
<img src="../media/image01_08.png" width="350px"><br>
Figure 9.1.3: Verification Model
</div>

<div style="text-align: center; margin-top: 3em;">
Table 9.1.8: exI: Verification Results (Maximum Deflection Amount History)
</div>

| Case Name | 0.1   | 0.2   | 0.3   | 0.4   | 0.5   | 0.6   | 0.7   | 0.8   | 0.9   | 1.0   | Linear Solution |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| I231     | -     | -     | -     | -     | -     | -     | -     | -     | -     | -     | -      |
| I232     | -     | -     | -     | -     | -     | -     | -     | -     | -     | -     | -      |
| I241     | -     | -     | -     | -     | -     | -     | -     | -     | -     | -     | -      |
| I242     | -     | -     | -     | -     | -     | -     | -     | -     | -     | -     | -      |
| I341     | 0.039 | 0.077 | 0.116 | 0.154 | 0.193 | 0.232 | 0.270 | 0.309 | 0.348 | 0.386 | 0.386  |
| I342     | 0.099 | 0.200 | 0.300 | 0.400 | 0.499 | 0.599 | 0.698 | 0.797 | 0.896 | 0.995 | 0.999  |
| I351     | 0.035 | 0.070 | 0.105 | 0.141 | 0.176 | 0.211 | 0.246 | 0.281 | 0.316 | 0.351 | 0.351  |
| I352     | 0.099 | 0.198 | 0.298 | 0.397 | 0.496 | 0.595 | 0.693 | 0.792 | 0.890 | 0.987 | 0.992  |
| I361     | 0.070 | 0.139 | 0.209 | 0.278 | 0.348 | 0.417 | 0.487 | 0.556 | 0.625 | 0.694 | 0.984  |
| I362     | 0.099 | 0.197 | 0.298 | 0.397 | 0.496 | 0.595 | 0.694 | 0.793 | 0.891 | 0.988 | 0.993  |

#### (2-2) 　exnl2: Elastoplasticity deformation analysis

The National Agency for Finite Element Methods and Standards (U.K.): Test NL1 from NAFEMS was referred to in this verification problem, and incorporated the geometrical non-linearity and multiple hardening rules in order to implement the elastoplasticity deformation analysis. The analysis model is shown in Figure 9.1.4.

<div style="text-align: center;">
<img src="../media/image01_09.png" width="350px"><br>
Figure 9.1.4: Elastoplasticity Deformation Analysis Model
</div>

(1) Verification conditions:

|    |  |
|:--|:--|
|Material   | Mises elastoplastic material |
|Young's Modulus   | $E = 250 GPa$ |
|Poisson's Ratio | $\nu = 0.25$ |
|Initial yield stress  | $5 MPa$ |
|Initial yield strain | $0.25\times 10^{-4}$ |
|Isotropic hardening factor | $H_i = 0$ or $62.5 GPa$ |

(2) Boundary conditions

|   |   |   |
|:--|:--|:--|
|step 1 | Forced displacement in nodes 2 and 3 | $u_{x} =  0.2500031251 *10^{-4} $ |
|step 2 | Forced displacement in nodes 2 and 3 | $u_{x} =  0.25000937518*10^{-4} $ |
|step 3 | Forced displacement in nodes 3 and 4 | $u_{y} =  0.2500031251 *10^{-4} $ |
|step 4 | Forced displacement in nodes 3 and 4 | $u_{y} =  0.25000937518*10^{-4} $ |
|step 5 | Forced displacement in nodes 2 and 3 | $u_{x} = -0.25000937518*10^{-4} $ |
|step 6 | Forced displacement in nodes 2 and 3 | $u_{x} = -0.2500031251 *10^{-4} $ |
|step 7 | Forced displacement in nodes 3 and 4 | $u_{y} = -0.25000937518*10^{-4} $ |
|step 8 | Forced displacement in nodes 3 and 4 | $u_{y} = -0.2500031251 *10^{-4} $ |

All the nodes not shown here will be completely restrained.

The theoretical solution of this problem is as follows.

| Strain ($\times10^{-4}$)<br/>[$\varepsilon_x$, $\varepsilon_y$, $\varepsilon_z$] | Equivalent Stress ($MPa$)<br/>[$H_i=0\ H_k=0$; $H_i=62.5\ H_k=0$] |
|:--|:--|
| 0.25, 0, 0    | 5.0; 5.0 | 
| 0.50, 0, 0    | 5.0; 5.862 |
| 0.50, 0.25, 0 | 5.0; 5.482 |
| 0.50, 0.50, 0 | 5.0; 6.362 |
| 0.25, 0.50, 0 | 5.0; 6.640 |
| 0, 0.50, 0    | 5.0; 7.322 |
| 0, 0.25, 0    | 3.917; 4.230 |
| 0, 0, 0       | 5.0; 5.673 |

The calculation results for the above are as follows.

| Strain ($\times10^{-4}$)<br/>[$\varepsilon_x$, $\varepsilon_y$, $\varepsilon_z$] | Equivalent Stress ($MPa$)<br/>[$H_i=0\ H_k=0$; $H_i=62.5\ H_k=0$] |
|:--|:--|
| 0.25, 0, 0    | 5.0 (0.0%); 5.0 (0.0%) | 
| 0.50, 0, 0    | 5.0 (0.0%); 5.862 (0.0%) |
| 0.50, 0.25, 0 | 5.0 (0.0%); 5.482 (0.0%) |
| 0.50, 0.50, 0 | 5.0 (0.0%); 6.362 (-0.05%)|
| 0.25, 0.50, 0 | 5.0 (0.0%); 6.640 (-0.21%)|
| 0, 0.50, 0    | 5.0 (0.0%); 7.322 (-0.34%)|
| 0, 0.25, 0    | 3.824 (-2.4%); 4.230 (-2.70%)|
| 0, 0, 0       | 5.0 (0.0%); 5.673 (5.673 (-2.50%)|

### Contact analysis (1)

The National Agency a for Finite Element Methods and Standards (U.K.): Contact Patch Test Problem CGS-4 was referred to in this verification problem, to test the limited sliding contact problem function with friction. The analysis model is shown in Figure 9.1.5.

<div style="text-align: center;">
<img src="../media/image01_10.png" width="350px"><br>
Figure 9.1.5: Contact Analysis Model
</div>

The equilibrium conditions of this problem are as follows.

$$Fcos\,\alpha - Gsin\,\alpha = \pm f_{c}$$

The frictional force in the viscous friction stage was $f_{c} = E_t\Delta u$ and becomes $f_c = \mu(G \cos\,\alpha + F \sin\,\alpha)$ in te sliding friction stage.

The comparison between the calculation results and the analysis solution is as follows.

| $\mu$ | $F/G$ Analysis Solution | $F/G$ Calculation Results |
|:--|:--|:--|
| 0.0 | 0.1   | 0.1   |
| 0.1 | 0.202 | 0.202 |
| 0.2 | 0.306 | 0.306 |
| 0.3 | 0.412 | 0.412 |

### Contact analysis (2): Hertz contact problem

The Hertz contact problem of a cylinder of infinite length and an infinite plane surface was analyzed in this verification.

The radius of the cylinder was set to $R = 8 mm$, and Young's modulus $E$ and Poisson's ratio $\mu$ of a deformable body was 1,100 Mpa and 0.0 respectively. Assuming that the contact area was sufficiently smaller than the radius of the cyclinder, a 1/4 cylindrical model was used to perform the analysis in consideration of the symmetry of the problem.


<div style="text-align: center;">
<img src="../media/image01_11.png" width="350px"><br>
Figure 9.1.6: Hertz Contact Problem Analysis Model
</div>

#### (1) Verification results of contact radius

The theoretical formula to calculate the contact radius is as follows.

$$a = \sqrt{\frac{4FR}{\pi E^{*}}}$$

Herein, 

$$E^{*} = \frac{E}{2(1 - \mu^{2})}$$

In this calculation, the contact radius becomes $a=1.36$ when pressure $F=100$.


The equivalent nodal force of the point of contact is shown in Figure 9.1.7. This nodal force distribution is extrapolated to acquire the contact radius.

<div style="text-align: center;">
<img src="../media/image01_12.png" width="512px"><br>
Figure 9.1.7: Equivalent Nodal Force Distribution of Contact Point
</div>

#### (2) Verification results of maximum shear stress

In this theoretical solution, the maximum shear stress is $\tau\_{max} = 0.30\sqrt{\frac{FE^*}{\pi R}}$  in contact position $z = 0.78a$. 

In this calculation condition it becomes $\tau_{max}=14.2$. In contrast to this, the calculation result $\tau\_{max}=15.6$ was aquired.

<div style="text-align: center;">
<img src="../media/image01_13.png" width="350px"><br>
Figure 9.1.8: Shear Stress Distribution (Maximum Value = 15.6)
</div>

### (3) Eigenvalue analysis

The verification model of verification case exJ ~ K is the same model as in verification case exA ~ G. The conceptual diagram of the verification model is shown in Figure 9.1.9. An eigenvalue analysis for this model was implemented. The eigenvalues to be acquired are the linear - cubic eigenvalues. In addition, the iterative method solver is used in exJ, and the direct method solver is used in exK. The verifications results are shown in Table 9.1.9 ~ Table 9.1.12.

<div style="text-align: center;">
<img src="../media/image01_14.png" width="350px"><br>
Figure 9.1.9: Verification Model
</div>

The vibration eigenvalue of the cantilever beam can be acquired by the following equations.

Linear :
$$ n_1 = \frac{1.875^2}{2 \pi l^2} \sqrt{ \frac{gEI}{\omega} } $$

Quadratic :
$$ n_2 = \frac{4.694^2}{2 \pi l^2} \sqrt{ \frac{gEI}{\omega} } $$

Cubic :
$$ n_3 = \frac{7.855^2}{2 \pi l^2} \sqrt{ \frac{gEI}{\omega} } $$

The characteristics of the verification model are as follows.

|   |   |
|:--|:--|
| $I$ | $10.0 mm$ |
| $E$ | $4000.0 kgf /mm^2$ |
| $l$ | $1.0/12.0 mm^4$ |
| $ \omega $ | $7.85 * 10^{-6} kgf/mm^3$ |
| $g$ | $9800.0 mm/sec^2$ |

Therefore, up to a cubic eigenvalue becomes as follows.

| No of Mode | Value |
|:--|:--|
| $n_1$ | 3.609e3 |
| $n_2$ | 2.262e4 |
| $n_3$ | 6.335e4 |

<div style="text-align: center;margin-top: 3em;">
Table 9.1.9: exJ: Verification Results with Iterative Method (Linear Eigenvalue)
</div>

| Case Name | No. of Elements | Predicated Value : n1=3.609e3 | | Remarks |
|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | FrontISTR | |
| J231 | 40  | 5.861e3 | 5.861e3 | 33 nodes / plane stress problem |
| J232 | 40  | 3.596e3 | 3.593e3 | 105 nodes / plane stress problem |
| J241 | 20  | 3.586e3 | 4.245e3 | 33 nodes / plane stress problem |
| J242 | 20  | 3.590e3 | 3.587e3 | 85 nodes / plane stress problem |
| J341 | 240 | 5.442e3 | 5.429e3 | 99 nodes |
| J342 | 240 | 3.621e3 | 3.595e3 | 525 nodes |
| J351 | 80  | 3.695e3 | 4.298e3 | 99 nodes |
| J352 | 80  | 3.610e3 | 3.609e3 | 381 nodes |
| J361 | 40  | 3.679e3 | 3.619e3 | 99 nodes |
| J362 | 40  | 3.611e3 | 3.606e3 | 220 nodes |

<div style="text-align: center;margin-top:3em;">
Table 9.1.10: exJ: Verification Results with Iterative Method (Quadratic Eigenvalue)
</div>

| Case Name | No. of Elements | Predicated Value : n2=2.262e4 | | Remarks |
|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | FrontISTR | |
| J231 | 40  | 3.350e4 | 3.351e4 | 33 nodes / plane stress problem |
| J232 | 40  | 2.163e4 | 2.156e4 | 105 nodes / plane stress problem |
| J241 | 20  | 2.149e4 | 2.516e4 | 33 nodes / plane stress problem |
| J242 | 20  | 2.149e4 | 2.143e4 | 85 nodes / plane stress problem |
| J341 | 240 | 3.145e4 | 3.138e4 | 99 nodes |
| J342 | 240 | 2.171e4 | 2.155e4 | 525 nodes |
| J351 | 80  | 2.208e4 | 2.546e4 | 99 nodes |
| J352 | 80  | 2.156e4 | 2.149e4 | 381 nodes |
| J361 | 40  | 2.202e4 | 2.168e4 | 99 nodes |
| J362 | 40  | 2.154e4 | 2.144e4 | 220 nodes |

> Note: Since the linear and quadratic eigenvalues of the 3D model have multiple roots, the value based on the cubic equation is used to describe the quadratic value in the table.

<div style="text-align: center;margin-top: 3em;">
Table 9.1.11: exK: Verification Results with Direct Method (Linear Eigenvalue)
</div>

| Case Name | No. of Elements | Predicated Value : n1=3.609e3 | | Remarks |
|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | FrontISTR | |
| J231 | 40  | 5.861e3 | 5.861e3 | 33 nodes / plane stress problem |
| J232 | 40  | 3.596e3 | 3.593e3 | 105 nodes / plane stress problem |
| J241 | 20  | 3.586e3 | 4.245e3 | 33 nodes / plane stress problem |
| J242 | 20  | 3.590e3 | 3.587e3 | 85 nodes / plane stress problem |
| J341 | 240 | 5.442e3 | 5.429e3 | 99 nodes |
| J342 | 240 | 3.621e3 | 3.595e3 | 525 nodes |
| J351 | 80  | 3.695e3 | 4.298e3 | 99 nodes |
| J352 | 80  | 3.610e3 | 3.609e3 | 381 nodes |
| J361 | 40  | 3.679e3 | 3.619e3 | 99 nodes |
| J362 | 40  | 3.611e3 | 3.606e3 | 220 nodes |
| J731 | 40  | -       | 3.606e3 | 220 nodes |
| J741 | 20  | -       | 3.594e3 | 220 nodes |

<div style="text-align: center;margin-top:3em;">
Table 9.1.12: exK: Verification Results with Direct Method (Quadratic Eigenvalue)
</div>

| Case Name | No. of Elements | Predicated Value : n2=2.262e4 | | Remarks |
|:-:|:-:|:-:|:-:|:-:|
|   |   | NASTRAN | FrontISTR | |
| J231 | 40  | 3.350e4 | 3.351e4 | 33 nodes / plane stress problem |
| J232 | 40  | 2.163e4 | 2.156e4 | 105 nodes / plane stress problem |
| J241 | 20  | 2.149e4 | 2.516e4 | 33 nodes / plane stress problem |
| J242 | 20  | 2.149e4 | 2.143e4 | 85 nodes / plane stress problem |
| J341 | 240 | 3.145e4 | 3.138e4 | 99 nodes |
| J342 | 240 | 2.171e4 | 2.155e4 | 525 nodes |
| J351 | 80  | 2.208e4 | 2.546e4 | 99 nodes |
| J352 | 80  | 2.156e4 | 2.149e4 | 381 nodes |
| J361 | 40  | 2.202e4 | 2.168e4 | 99 nodes |
| J362 | 40  | 2.154e4 | 2.144e4 | 220 nodes |
| J731 | 40  | -       | 2.156e4 | 220 nodes |
| J741 | 20  | -       | 2.153e4 | 220 nodes |

> Note: Since the linear and quadratic eigenvalues of the 3D model have multiple roots, the value based on the cubic equation is used to describe the quadratic value in the table.

### (4) Heat conduction analysis

Conditions common to a steady heat conduction analysis are shown in Figure 9.1.10. The individual conditions of verification case exM - exT are shown in Figure 9.1.11. Mesh partitioning equivalent to that of exA was used.

Temperature distribution tables for each case of the verification results are shown in Table 9.1.13 ~ Table 9.1.20.

<div style="text-align: center; margin-top:3em;">
<img src="../media/image01_15.png" width="350px">
</div>
|   |   |
|---|---|
|Length between AB|$L = 10.0m$|
|Cross-sectional area|$A = 1.0 mm^2$|

Temperature dependency of thermal conductivity

|Thermal conductivity $\lambda(W/mK)$|Temperature $(^\circ C)$|
|----------------------------|----------------|
|50.0                        |0.0             |
|35.0                        |500.0           |
|20.0                        |1000.0          |

<div style="text-align: center;">
Figure 9.1.10: Verification Conditions of Steady Heat Conduction Analysis
</div>

|   |   |
|---|---|
|exM: Linear material|  |
|exN: Specified tempreature problem|<img src="../media/image01_16.png" width="350px">|
|exO: Concentrated heat flux problem|<img src="../media/image01_17.png" width="350px">|
|exP: Distributed heat flux problem|<img src="../media/image01_18.png" width="350px">|
|exQ: Convective heat transfer problem|<img src="../media/image01_19.png" width="350px">|
|exR: Radiant heat transfer problem|<img src="../media/image01_20.png" width="350px">|
|exS: Volumetric heat generation problem|<img src="../media/image01_21.png" width="350px">|
|exT: Internal gap problem|<img src="../media/image01_22.png" width="350px">|

<div style="text-align: center;margin-top:1em;">
Figure 9.1.11: Analysis Conditions for each Verification Case
</div>

<div style="text-align: center;margin-top:3em;">
Table 9.1.13: exM: Verification Results of Steady Calculation by Linear Material
</div>

| Case Name | Element Type | No. of Elements/Nodes | Distance from End A (m) |  |  |  |  |  |  |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
|   |   |   | End A | 2.0 | 4.0 | 6.0 | 8,0 | End B |
| M361A | 361 | 40／33  | 0.0 | 100.0 | 200.0 | 300.0 | 400.0 | 500.0 |
| M361B | 361 | 40／105 | 0.0 | 100.0 | 200.0 | 300.0 | 400.0 | 500.0 |
| M361C | 361 | 20／33  | 0.0 | 100.0 | 200.0 | 300.0 | 400.0 | 500.0 |
| M361D | 361 | 20／85  | 0.0 | 100.0 | 200.0 | 300.0 | 400.0 | 500.0 |
| M361E | 361 | 240／99 | 0.0 | 100.0 | 200.0 | 300.0 | 400.0 | 500.0 |
| M361F | 361 | 24／525 | 0.0 | 100.0 | 200.0 | 300.0 | 400.0 | 500.0 |
| M361G | 361 | 80／99  | 0.0 | 100.0 | 200.0 | 300.0 | 400.0 | 500.0 |

<div style="text-align: center;margin-top:3em;">
Table 9.1.14: exN: Verification Results of Specified Temperature Problem
</div>

| Case Name | Element Type | No. of Elements/Nodes | Distance from End A (m) |  |  |  |  |  |  |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
|   |   |   | End A | 2.0 | 4.0 | 6.0 | 8,0 | End B |
| ABAQUS | 361 | 40／99  | 0.0 | 87.3 | 179.7 | 278.2 | 384.3 | 500.0 |
| N231   | 231 | 40／33  | 0.0 | 87.2 | 179.5 | 278.0 | 384.1 | 500.0 |
| N232   | 232 | 40／105 | 0.0 | 86.0 | 178.3 | 276.8 | 382.9 | 500.0 |
| N241   | 241 | 20／33  | 0.0 | 87.3 | 179.7 | 278.2 | 384.3 | 500.0 |
| N242   | 242 | 20／85  | 0.0 | 87.3 | 179.7 | 278.2 | 384.3 | 500.0 |
| N341   | 341 | 240／99 | 0.0 | 87.3 | 179.7 | 278.2 | 384.3 | 500.0 |
| N342   | 342 | 24／525 | 0.0 | 87.9 | 179.9 | 278.0 | 383.6 | 500.0 |
| N351   | 351 | 80／99  | 0.0 | 87.3 | 179.7 | 278.2 | 384.3 | 500.0 |
| N352   | 352 | 80／381 | 0.0 | 87.3 | 179.7 | 278.2 | 384.3 | 500.0 |
| N361   | 361 | 40／99  | 0.0 | 87.3 | 179.7 | 278.2 | 384.3 | 500.0 |
| N362   | 362 | 40／330 | 0.0 | 87.3 | 179.7 | 278.2 | 384.3 | 500.0 |
| N731   | 731 | 40／33  | 0.0 | 87.3 | 179.7 | 278.2 | 384.3 | 500.0 |
| N741   | 741 | 20／33  | 0.0 | 87.3 | 179.7 | 278.2 | 384.3 | 500.0 |

<div style="text-align: center;margin-top:3em;">
Table 9.1.15: exO: Verification Results of Concentrated Heat Flux Problem
</div>

| Case Name | Element Type | No. of Elements/Nodes | Distance from End A (m) |  |  |  |  |  |  |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
|   |   |   | End A | 2.0 | 4.0 | 6.0 | 8,0 | End B |
| ABAQUS | 361 | 40／99  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| O231   | 231 | 40／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| O232   | 232 | 40／105 | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| O241   | 241 | 20／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| O242   | 242 | 20／85  | 0.0 | 103.2 | 213.7 | 333.4 | 465.2 | 618.0 |
| O341   | 341 | 240／99 | -   | -     | -     | -     | -     | -     |
| O342   | 342 | 24／525 | 0.0 | 104.4 | 214.9 | 334.7 | 466.3 | 614.6 |
| O351   | 351 | 80／99  | -   | -     | -     | -     | -     | -     |
| O352   | 352 | 80／381 | 0.0 | 103.2 | 213.7 | 333.3 | 465.0 | 624.2 |
| O361   | 361 | 40／99  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| O362   | 362 | 40／330 | 0.0 | 103.2 | 213.7 | 333.4 | 465.5 | 623.5 |
| O731   | 731 | 40／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.5 |
| O741   | 741 | 20／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |

<div style="text-align: center;margin-top:3em;">
Table 9.1.16: exP: Verification Results of Distributed Heat Flux Problem
</div>

| Case Name | Element Type | No. of Elements/Nodes | Distance from End A (m) |  |  |  |  |  |  |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
|   |   |   | End A | 2.0 | 4.0 | 6.0 | 8,0 | End B |
| ABAQUS | 361 | 40／99  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| P231   | 231 | 40／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| P232   | 232 | 40／105 | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| P241   | 241 | 20／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| P242   | 242 | 20／85  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| P341   | 341 | 240／99 | -   | -     | -     | -     | -     | -     |
| P342   | 342 | 24／525 | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| P351   | 351 | 80／99  | -   | -     | -     | -     | -     | -     |
| P352   | 352 | 80／381 | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| P361   | 361 | 40／99  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| P362   | 362 | 40／330 | 0.0 | 103.2 | 213.7 | 333.4 | 465.5 | 612.6 |
| P731   | 731 | 40／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.5 |
| P741   | 741 | 20／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |

<div style="text-align: center;margin-top:3em;">
Table 9.1.17: exQ: Verification Results of Convective Heat Transfer Problem
</div>

| Case Name | Element Type | No. of Elements/Nodes | Distance from End A (m) |  |  |  |  |  |  |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
|   |   |   | End A | 2.0 | 4.0 | 6.0 | 8,0 | End B |
| ABAQUS | 361 | 40／99  | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |
| Q231   | 231 | 40／33  | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |
| Q232   | 232 | 40／105 | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |
| Q241   | 241 | 20／33  | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |
| Q242   | 242 | 20／85  | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |
| Q341   | 341 | 240／99 | -   | -    | -     | -     | -     | -     |
| Q342   | 342 | 24／525 | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |
| Q351   | 351 | 80／99  | -   | -    | -     | -     | -     | -     |
| Q352   | 352 | 80／381 | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |
| Q361   | 361 | 40／99  | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |
| Q362   | 362 | 40／330 | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |
| Q731   | 731 | 40／33  | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |
| Q741   | 741 | 20／33  | 0.0 | 89.2 | 183.8 | 284.8 | 393.9 | 513.2 |

<div style="text-align: center;margin-top:3em;">
Table 9.1.18: exR: Verification Results of Radiant Heat Transfer Problem
</div>

| Case Name | Element Type | No. of Elements/Nodes | Distance from End A (m) |  |  |  |  |  |  |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
|   |   |   | End A | 2.0 | 4.0 | 6.0 | 8,0 | End B |
| ABAQUS | 361 | 40／99  | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |
| R231   | 231 | 40／33  | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |
| R232   | 232 | 40／105 | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |
| R241   | 241 | 20／33  | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |
| R242   | 242 | 20／85  | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |
| R341   | 341 | 240／99 | -   | -    | -     | -     | -     | -     |
| R342   | 342 | 24／525 | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |
| R351   | 351 | 80／99  | -   | -    | -     | -     | -     | -     |
| R352   | 352 | 80／381 | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |
| R361   | 361 | 40／99  | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |
| R362   | 362 | 40／330 | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |
| R731   | 731 | 40／33  | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |
| R741   | 741 | 20／33  | 0.0 | 89.5 | 184.4 | 285.8 | 395.3 | 515.2 |

<div style="text-align: center;margin-top:3em;">
Table 9.1.19: exS: Verification Results of Volumetric Heat Generation Problem
</div>

| Case Name | Element Type | No. of Elements/Nodes | Distance from End A (m) |  |  |  |  |  |  |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
|   |   |   | End A | 2.0 | 4.0 | 6.0 | 8,0 | End B |
| ABAQUS | 361 | 40／99  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| S231   | 231 | 40／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| S232   | 232 | 40／105 | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| S241   | 241 | 20／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| S242   | 242 | 20／85  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| S341   | 341 | 240／99 | -   | -     | -     | -     | -     | -     |
| S342   | 342 | 24／525 | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| S351   | 351 | 80／99  | -   | -     | -     | -     | -     | -     |
| S352   | 352 | 80／381 | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| S361   | 361 | 40／99  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| S362   | 362 | 40／330 | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| S731   | 731 | 40／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |
| S741   | 741 | 20／33  | 0.0 | 103.2 | 213.7 | 333.3 | 464.8 | 612.6 |

<div style="text-align: center;margin-top:3em;">
Table 9.1.20: exT: Verification Results of Internal Gap Problem
</div>

| Case Name | Element Type | No. of Elements/Nodes | Distance from End A (m) |  |  |  |  |  |  |
|:--|:--|:--|:--|:--|:--|:--|:--|:--|:--|
|   |   |   | End A | 2.0 | 4.0 | 6.0 | 8,0 | End B |
| ABAQUS | 361 | 40／99  | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |
| S231   | 231 | 40／33  | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |
| S232   | 232 | 40／105 | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |
| S241   | 241 | 20／33  | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |
| S242   | 242 | 20／85  | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |
| S341   | 341 | 240／99 | -   | -    | -     | -     | -     | -     |
| S342   | 342 | 24／525 | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |
| S351   | 351 | 80／99  | -   | -    | -     | -     | -     | -     |
| S352   | 352 | 80／381 | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |
| S361   | 361 | 40／99  | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |
| S362   | 362 | 40／330 | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |
| S731   | 731 | 40／33  | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |
| S741   | 741 | 20／33  | 0.0 | 88.6 | 182.4 | 282.6 | 387.7 | 500.0 |

### (5) Linear dynamic analysis

In exW, the same cantilever beam as in item (1) was used as the subject to perform the linear dynamic analysis. The verification conditions are shown in Figure 9.1.12. In this verification, the affects in which the time increments may have on the results for the same mesh partition was verified. As a dynamic analysis method, both the implicit method and the explicit method were used, and element types 361 and 342 were used. The verification results are shown in Table 9.1.22 and Figure 9.1.13 ~ Figure 9.1.15.

<div style="text-align: center;">
<img src="../media/image01_23.png" width="350px"><br>
Analysis Model
</div>
<div style="text-align: center;">
<img src="../media/image01_24.png" width="512px"><br>
Time History of External Force F
</div>

Theoretical solution of vibration point displacement:

$$
F(t)=F_0 I(t)
$$

Where,

$$
F_0:Constant\ vector
$$

$$
I(t)=
\begin{cases}
0, t < 0 \\\
1, 0 \leq t
\end{cases}
$$

$$
u(t) = \frac{F_0 l^3}{EI} \sum^{\infty}\_{i=1} \frac{1-\cos{\omega_i t}}{{\lambda_i}^4}
\left\lbrace
\cosh{\lambda_i}-\cos{\lambda_i}-\frac{\cosh{\lambda_i} + \cos{\lambda_i}}{\sin{\lambda_i}+\sin{\lambda_i}}
(\sinh{\lambda_i} - \sin{\lambda_i})
\right\rbrace^2
$$

<div style="text-align: center;">
Figure 9.1.12: Verification Conditions of Linear Dynamic Analysis
</div>

Verification conditions:

|   |   |   |
|---|---|---|
|Length                     | $L$    | $10.0\ mm$|
|Cross-sectional width      | $a$    | $1.0\ mm$ |
|Cross-sectional height     | $b$    | $1.0\ mm$ |
|Young's Modulus            | $E$    | $4000.0\ kgf/mm^2$ |
|Poisson's Ratio            | $\nu$  | 0.3 |
|Density                    | $\rho$ | $1.0E-09\ kgf\,s^2/mm^3$ | 
|Gravitational acceleration | $g$    | $9800.0\ mm/s^2$ |
|External force             | $F_0$  | $1.0\ kgf$ |

|   |   |
|---|---|
|Element  |Hexahedral linear element|
|Tetrahedral quadratic element| |
|Solution | Implicit method |
|Parameter $\gamma$ of Newmark-$\beta$ method | 1/2 |
|Parameter $\beta$ of Newmark-$\beta$ method | 1/4 |
|Explicit method| |
|Damping | N/A |

<div style="text-align: center;margin-top:3em;">
Table 9.1.21: Verification Conditions of Linear Dynamic Analysis (Continued)
</div>

| Case Name | Element Type | No. of Nodes | No. of Elements | Solution | Time Increment $\Delta t$ [sec] |
|:--|:--|:--|:--|:--|:--|
| W361_c0_im_m2_t1 | 361 |  99 |  40 | Implicit method | 1.0E-06 |
| W361_c0_im_m2_t2 | 361 |  99 |  40 | Implicit method | 1.0E-05 |
| W361_c0_im_m2_t3 | 361 |  99 |  40 | Implicit method | 1.0E-04 |
| W361_c0_ex_m2_t1 | 361 |  99 |  40 | Explicit method | 1.0E-08 |
| W361_c0_ex_m2_t2 | 361 |  99 |  40 | Explicit method | 1.0E-07 |
| W361_c0_ex_m2_t3 | 361 |  99 |  40 | Explicit method | 1.0E-06 |
| W342_c0_im_m2_t1 | 342 | 525 | 240 | Implicit method | 1.0E-06 |
| W342_c0_im_m2_t2 | 342 | 525 | 240 | Implicit method | 1.0E-05 |
| W342_c0_im_m2_t3 | 342 | 525 | 240 | Implicit method | 1.0E-04 |
| W342_c0_ex_m2_t1 | 342 | 525 | 240 | Explicit method | 1.0E-08 |
| W342_c0_ex_m2_t2 | 342 | 525 | 240 | Explicit method | 5.0E-08 |
| W342_c0_ex_m2_t3 | 342 | 525 | 240 | Explicit method | 1.0E-07 |

<div style="text-align: center;margin-top:3em;">
Table 9.1.22: exW: Verification Results of Linear Dynamic Analysis for Cantilever Beam
</div>

| Case Name | Element Type | No. of Nodes | No. of Elements | Solution | z Direction Displacement: $u_z(mm)$ when Time $t = 0.002(s)$ |  |
|:--|:--|:--|:--|:--|:--|:--|
|                  |     |     |     |        |Theorical Solution Repeated to Sextic Equation|FrontISTR|
| W361_c0_im_m2_t1 | 361 |  99 |  40 | Implicit method | 1.9753 | 1.9302 |
| W361_c0_im_m2_t2 | 361 |  99 |  40 | Implicit method | 1.9753 | 1.8686 |
| W361_c0_im_m2_t3 | 361 |  99 |  40 | Implicit method | 1.9753 | 0.3794 |
| W361_c0_ex_m2_t1 | 361 |  99 |  40 | Explicit method | 1.9753 | 1.9302 |
| W361_c0_ex_m2_t2 | 361 |  99 |  40 | Explicit method | 1.9753 | 1.9247 |
| W361_c0_ex_m2_t3 | 361 |  99 |  40 | Explicit method | 1.9753 | Divergence |
| W342_c0_im_m2_t1 | 342 | 525 | 240 | Implicit method | 1.9753 | 1.9431 |
| W342_c0_im_m2_t2 | 342 | 525 | 240 | Implicit method | 1.9753 | 1.8719 |
| W342_c0_im_m2_t3 | 342 | 525 | 240 | Implicit method | 1.9753 | 0.3873 |
| W342_c0_ex_m2_t1 | 342 | 525 | 240 | Explicit method | 1.9753 | 1.9359 |
| W342_c0_ex_m2_t2 | 342 | 525 | 240 | Explicit method | 1.9753 | 1.9358 |
| W342_c0_ex_m2_t3 | 342 | 525 | 240 | Explicit method | 1.9753 | Divergence |

<div style="text-align: center;">
<img src="../media/image01_25.png" width="512px"><br>
Figure 9.1.13: Deformed Figure and Equivalent Stress Distribution of Cantilever Beam (W361_c0_im_m2_t2)
</div>

<div style="text-align: center;">
<img src="../media/image01_26.png" width="512px"><br>
(a) Element Type 361 : Implicit method
</div>

<div style="text-align: center;">
<img src="../media/image01_27.png" width="512px"><br>
(b) Element Type 361 : Explicit method
</div>

<div style="text-align: center;">
Figure 9.1.14: Time History of Vibration Point Displacement $u_z$
</div>

<div style="text-align: center;">
<img src="../media/image01_28.png" width="512px"><br>
(a) Element Type 342 : Implicit method
</div>

<div style="text-align: center;">
<img src="../media/image01_29.png" width="512px"><br>
(b) Element Type 342 : Explicit method
</div>

<div style="text-align: center;">
Figure 9.1.15: Time History of Vibration Point Displacement $u_z$
</div>

### (6) Frequency Response Analysis

A cantilever beam was used for the verification and validation of frequency response analayis.The results were compared with those of ABAQUS. The analysis model and boundary conditions are shown below.

<div style="text-align: center;">
<img src="../media/image01_30.png" width="350px">
<img src="../media/image01_31.png" width="350px">
</div>

Analysis conditions:

|    |    |    |
|----|----|----|
|Young’s modulus| $E$ | $210000\ N/mm^2$  |
|Poisson’s ratio| $\nu$ | $0.3$ |
|Density| $\rho$ | $7.89E-09\ t/mm^3$ |
|Gravity| $g$ | $9800.0\ mm/s^2$ |
|Applied force| $F_0$   | $1.0\ N$|
|Rayleigh damping parameter |$R_m$ |$0.0$ |
|Rayleigh damping parameter |$R_k$ |$7.2E-07$ |

<div style="text-align: center;">
Figure 9.1.15 : Analysis model (Element type= 341, Number of Elements:126, Number of Nodes: 55)
</div>

Eigenvalue upto 5th mode obtained by eigenvalue analysis are listed below.

| mode | FrontISTR | ABAQUS |
|:--|:--|:--|
| 1 | 14952  | 14952  |
| 2 | 15002  | 15003  |
| 3 | 84604  | 84539  |
| 4 | 84771  | 84697  |
| 5 | 127054 | 126852 |

<div style="text-align: center;">
<img src="../media/image01_32.png" width="512px"><br>
Fig. 9.1.16 : Frequency dependency of the displacement amplitude at loaded point
</div>
