## Actual Model Examples for Eigenvalue Analysis

### Analysis model

A list of examples of the actual verification models for eigenvalue analysis is presented in Table 9.3.1. The model shapes of EX07 (turbine rotor) and EX08 (spring) are also shown in Figs. 9.3.1 and 9.3.2. The other model shapes are the same as those of the examples previously discussed in the elastic static analysis, which has the same verification content. The examples of the element types 731 and 741 require a separate direct method solver. 

<div style="text-align: center;">
Table 9.3.1: Examples of actual model verification for eigenvalue analysis
</div>

| Case Name | Element Type | Verification Model  | No. of Nodes | No. of Degrees of Freedom |
|:----------|:-------------|:--------------------|:-------------|:--------------------------|
| EX06      | 342          | Turbine blade       | 10,095       | 30,285                    |
| EX07      | 361          | Turbine rotor       | 127,440      | 382,320                   |
| EX08      | 342          | Spring              | 78,771       | 236,313                   |
| EX09      | 741          | Cylindrical shell   | 10,100       | 60,600                    |
| EX10A     | 731          | Wine glass (coarse) | 7,240        | 43,440                    |
| EX10B     | 731          | Wine glass (midium) | 48,803       | 292,818                   |


![Turbine rotor (EX07)](./media/example03_01.png){.center width="350px"}
<div style="text-align: center;">
Fig. 9.3.1: Turbine rotor (EX07)
</div>

![Spring (EX08)](./media/example03_02.png){.center width="350px"}
<div style="text-align: center;">
Fig. 9.3.2: Spring (EX08)
</div>

### Analysis Results

The vibration mode and natural frequency are shown in the following.

#### (1) EX06 Turbine blade

|                                                    |                                                    |
|----------------------------------------------------|----------------------------------------------------|
| ![(a) Mode 1 (1170 kHz)](./media/example03_03.png){width=200px"} | ![(b) Mode 2(3250kHz)](./media/example03_04.png){width="200px"} |
| (a) Mode 1 (1170 kHz)                              | (b) Mode 2(3250kHz)                                |
|                                                    |                                                    |
| ![(c) Mode 3(4130kHz)](./media/example03_05.png){width="200px"} | ![(d) Mode 4(4140kHz)](./media/example03_06.png){width="200px"} |
| (c) Mode 3(4130kHz)                                | (d) Mode 4(4140kHz)                                |
|                                                    |                                                    |
| ![(e) Mode 5(8210kHz)](./media/example03_07.png){width="200px"} |                                                    |
| (e) Mode 5(8210kHz)                                |                                                    |

<div style="text-align: center;">
Fig. 9.3.3: EX06, turbine blade vibration mode
</div>

#### (2) EX07 Turbine rotor

|                                                    |                                                    |
|----------------------------------------------------|----------------------------------------------------|
| ![(a) Mode 1(1067Hz)](./media/example03_08.png){width="300px"} | ![(b) Mode 2(1072Hz)](./media/example03_09.png){width="300px"} |
| (a) Mode 1(1067Hz)                                 | (b) Mode 2(1072Hz)                                 |
|                                                    |                                                    |
| ![(c) Mode 3(1072Hz)](./media/example03_10.png){width="300px"} | ![(d) Mode 4(1093Hz)](./media/example03_11.png){width="300px"} |
| (c) Mode 3(1072Hz)                                 | (d) Mode 4(1093Hz)                                 |
|                                                    |                                                    |
| ![(e) Mode 5(1093Hz)](./media/example03_12.png){width="300px"} |                                                    |
| (e) Mode 5(1093Hz)                                 |                                                    |
|                                                    |                                                    |

<div style="text-align: center;">
Fig. 9.3.4: EX07, Turbine rotor vibration mode
</div>

#### EX08 Spring

|  |  |  |
|--|--|--|
|Mode 1 (445Hz)                                   |Mode 2 (446Hz)                                   |Mode 3 (908Hz)                                   |
|![Mode 1 (445Hz)](./media/example03_13.png){width="160px"}|![Mode 2 (446Hz)](./media/example03_14.png){width="160px"}|![Mode 3 (908Hz)](./media/example03_15.png){width="160px"}|
|  |  |
|Mode 4 (985Hz)                                   |Mode 5 (1819Hz)                                  |   |
|![Mode 4 (985Hz)](./media/example03_16.png){width="160px"}|![Mode 5 (1819Hz)](./media/example03_17.png){width="160px"}|   |

|   | FrontISTR | NASTRAN |
|---|----------:|--------:|
| 1 | 445 Hz    | 445 Hz  |
| 2 | 446 Hz    | 446 Hz  |
| 3 | 908 Hz    | 908 Hz  |
| 4 | 985 Hz    | 986 Hz  |
| 5 | 1810 Hz   | 1810 Hz |

<div style="text-align: center;">
Fig. 9.3.5: EX08, spring vibration mode
</div>

#### (4) EX09 Cylindrical shell

![(a) Mode 1, 2 (109 Hz)](./media/example03_18.png){.center width="350px"}
<div style="text-align: center;">
(a) Mode 1, 2 (109 Hz)
</div>

![(b) Mode 3,4(570Hz)](./media/example03_19.png){.center width="350px"}
<div style="text-align: center;">
(b) Mode 3,4(570Hz)
</div>

![c) Mode 5(615Hz)](./media/example03_20.png){.center width="350px"}
<div style="text-align: center;">
(c) Mode 5(615Hz)
</div>

<div style="text-align: center;">
Fig. 9.3.6: EX09, cylindrical shell vibration mode
</div>

#### EX10A Wine glass

|   |   |   |
|---|---|---|
| ![(a) Mode 1(101Hz)](./media/example03_21.png){width="120px"} | ![(b) Mode 2(102Hz)](./media/example03_22.png){width="120px"} | ![(c) Mode 3(354Hz)](./media/example03_23.png){width="120px"} |
| (a) Mode 1(101Hz)                                               | (b) Mode 2(102Hz)                                               | (c) Mode 3(354Hz)                                               |
| ![(d) Mode 4(1335Hz)](./media/example03_24.png){width="120px"}| ![(e) Mode 5(1336Hz)](./media/example03_25.png){width="120px"} |                                                                |
| (d) Mode 4(1335Hz)                                              | (e) Mode 5(1336Hz)                                               |                                                                |

<div style="text-align: center;">
Fig. 9.3.7: EX10A Wine Glass Vibration Mode
</div>


