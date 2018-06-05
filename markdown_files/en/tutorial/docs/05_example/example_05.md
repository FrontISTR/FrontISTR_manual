## Example of Actual Model for Linear Dynamic Analysis

### Analysis Mode

In the linear dynamic analysis, the machine parts shown in Figure 9.5.1 were used as the actual model. In this actual model, a verification example was set for four cases with different load conditions and damping coefficients. A list is shown in Table 9.5.1.

<div style="text-align: center;">
Table 9.5.1: Verification Example of Actual Model for Linear Dynamic Analysis
</div>

| Case Name | Element Type | Verification Model | Loading Conditions | Damping Conditions | No. of Nodes | No. of Degrees of Freedom |
|:--|:--|:--|:--|:--|:--|:--|
| EX31A    | 342        | Mesh model     | Step load (F0)         | No     | 15,214 | 45,642 |
| EX31B    | 342        |                | Step load (F0)         | Yes    | 15,214 | 45,642 |
| EX31C    | 342        |                | Square wave pulse (F1) | No     | 15,214 | 45,642 |
| EX31D    | 342        |                | Square wave pulse (F1) | Yes    | 15,214 | 45,642 |

<div style="text-align: center;">
<img src="../media/image05_01.png" width="512px"><br>
Figure 9.5.1 : Mesh Model
</div>

### Analysis Results

Examples of the analysis results are shown in Figure 9.5.2 ~ Figure 9.5.3.

<div style="text-align: center;">
<img src="../media/image05_02.png" width="512px"><br>
(a) In the case of Step Load
</div>

<div style="text-align: center;">
<img src="../media/image05_03.png" width="512px"><br>
(b) In the case of Square Wave Pulse Load
</div>

<div style="text-align: center;">
Figure 9.5.2: Time History of Vibration Point Displacement u<sub>z</sub>
</div>

---

<div style="text-align: center;">
<img src="../media/image05_04.png" width="350px"><br>
(a) t=5.0E-04(s)
</div>

<div style="text-align: center;">
<img src="../media/image05_05.png" width="350px"><br>
(b) t=4.0E-03(s)
</div>

<div style="text-align: center;">
Figure 9.5.3: Deformed Figure and Equivalent Stress Distribution (Deformed Magnification 5.0): EX31C
</div>
