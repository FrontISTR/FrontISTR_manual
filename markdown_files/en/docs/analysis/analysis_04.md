## Single Domain Mesh Data

### Outline of Single Mesh Data

In order to acquire the mesh data of FrontISTR, there are two methods, such as the method to input the single domain mesh data file, and the method to input the distributed mesh data file to perform parallel processing. Single domain mesh data is described in this section.

The features of single domain mesh data are as follows.

  - This is an ASCII format file based on a free format.
  - This file consists of a header which starts with "`!`" and the data following this.
  - The order of description of the header is basically free.
  - A "`,`" is used as a punctuation mark of the data.

### Input Rules

The single domain mesh data file consists of a header line, data line and a comment line.  One header is always included in the header line.

Header
:    The meaning of the data and data block is specified in the single domain mesh data file.
:    When the head of the term starts with a "`!`", it is considered to be a header.

Header Line
:    The contents of the header and the parameter accompanying this are described in this line.
:    The header line must start with a header. When a parameter is required, a "`,`" must be used to continue after that. 
:    When the parameter takes on a value, use an "`=`" after the parameter and describe the value after that. The header line can not be described in more than two lines.

Data Line
:    The data line starts after the header line, and the necessary data is described.
:    The data lines may be in multiple lines; however, this is determined according to the rules of the data description defined by each header.
:    There are cases where data lines are not required.

Punctuation
:    A comma "`,`" is used as a punctuation of the data.

Handling of Blanks
:    Blanks are disregarded.

Name
:    Regarding the characters which can be used for the name, there is the underscore "`_`", hyphen "`-`", and alphanumeric characters "`a - z, A - Z, 0 - 9`"; however, the first letter of the name must start with "`_`", or an alphabetic character "`a - z, A - Z`". There is no distinction between uppercase and lowercase letters, and all letters are internally handled as uppercase letters.
:    The maximum length of the name is 63 characters.

File Name
:    Regarding the characters which can be used for the file name, there are the underscore "`_`", hyphen "`-`", period "`.`", slash "`/`", and the alphanumeric characters "`a - z, A - Z, 0 - 9`".
:    As long as there is no specific description, a path can be included in the file name. Both the relative path and the absolute path can be specified.
:    The maximum length of the file name is 1,023 characters.

Floating Point Data
:    Exponents are optional. An "`E`" or "`e`" character must be added before the exponent.
:    The selection of "`E`" or "`e`" is optional. "`D`" or "`d`" can not be used.

!!, # Comment Line
:    Lines starting with "`!!`" or "`#`" are considered to be comment lines, and are disregarded.
:    A comment line can be inserted in any position in the file, and there are no restrictions on the number of lines.

### Header List of Single Domain Mesh Data

The single domain mesh data consists of the following headers.

| Header Name     | Contents              | Description No. |
|-----------------|-----------------------|-----------------|
| `!AMPLITUDE`    | Unsteady load         | M1-1            |
| `!EGROUP`       | Element group         | M1-2            |
| `!ELEMENT`      | Element information   | M1-3            |
| `!EQUATION`     | Restricted point data | M1-4            |
| `!HEADER`       | Title of mesh data    | M1-5            |
| `!MATERIAL`     | Material information  | M1-6            |
| `!NGROUP`       | Node group            | M1-7            |
| `!NODE`         | Node information      | M1-8            |
| `!SECTION`      | Section information   | M1-9            |
| `!SGROUP`       | Surface group         | M1-10           |
| `!ZERO`         | Absolute zero-point   | M1-11           |
| `!CONTACT PAIR` | Contact surface pair  | M1-12           |
| `!END`          | Read end              | M1-13           |

In each header, there are data items which are compatible to the parameter and each header.

Each of the above headers is briefly described in the following with examples of data creation.  The number indicated on the right end of the data creation is the description number of the above Table.

#### Example of Mesh Data

```
!HEADER                                         M1-5
  TEST MODEL CTLR10

!NODE                                           M1-8
  1, 0.00000E+00, 0.00000E+00, 0.00000E+00
  2, 0.50000E+01, 0.00000E+00, 0.00000E+00
  3, 0.10000E+02, 0.00000E+00, 0.00000E+00
  .. ...          ...          ...

!ELEMENT,TYPE=351                               M1-3
  1, 1, 2, 4, 34, 35, 37
  2, 2, 5, 4, 35, 38, 37
  3, 2, 3, 5, 35, 36, 38

!SECTION, TYPE=SOLID, EGRP=ALL, MATERIAL=M1     M1-9
  1.0

!MATERIAL, NAME=M1, ITEM=2                      M1-6
!ITEM=1, SUBITEM=2
  2.1E5, 0.3
!ITEM=2, SUBITEM=1
7.8e-6

!NGROUP, NGRP=FIX, GENERATE                     M1-7
  2 , 2 , 1
  3 , 3 , 1
  1 , 1 , 1
  69 , 69 , 1
  67 , 67 , 1

!NGROUP, NGRP=CL1                               M1-8
  50

!END                                            M1-13
```

#### (1) `!AMPLITUDE` (M1-1)

Specifies the changes of time of the variables which provide the load conditions in the step.

```
!AMPLITUDE, NAME=<name> [, optional parameter]
VAL1, T1, VAL2, T2, VAL3, T3 ...

(up to four items in one line)
```

|Parameter   |                              |
|------------|------------------------------|
|`NAME`      |Name (mandatory)              |
|`DEFINITION`|Type (omissible)              |
|`TIME`      |Type of time (omissible)      |
|`VALUE`     |Type of value (omissible)     |
|`INPUT`     |External file name (omissible)|

|Parameter Name|Parameter Value  |Contents                                 |
|--------------|-----------------|-----------------------------------------|
|`NAME`        |&lt;name&gt;     |`AMPLITUDE` Name                         |
|`DEFINITION`  |`TABULAR`        |Default (default only in current version)|
|`TIME`        |`STEP TIME`      |Default (default only in current version)|
|`VALUE`       |`RELATIVE`       |Relative value (default)                 |
|              |`ABSOLUTE`       |Absolute value                           |
|`INPUT`       | &lt;filename&gt;|External file name (omissible), can also be use together with the 2nd line or later|


|Parameter Name |Attributions|Contents        |
|---------------|------------|----------------|
|`VAL1`         |R           |Value at time T1|
|`T1`           |R           |Time T1         |
|`VAL2`         |R           |Value at time T2|
|`T2`           |R           |Time T2         |
|`VAL3`         |R           |Value at time T3|
|`T3`           |R           |Time T3         |

#### (2) `!EGROUP` (M1-2)

Definition of element group

```
!EGROUP, EGRP=<egrp> [, optional parameter]
```

|Parameter |                                                                        |
|----------|------------------------------------------------------------------------|
|`EGRP`    |Element group name (mandatory)                                          |
|`GENERATE`|Automatic generation of nodes belonging to the element group (omissible)|
|`INPUT`   |External file name (omissible)                                          |

| Parameter Name | Parameter Value  | Contents                                                                            |
|----------------|------------------|-------------------------------------------------------------------------------------|
| `EGRP`         | &lt;egrp&gt;     | Element group name                                                                  |
| `GENERATE`     | N/A              | Automatic generation of nodes belonging to the element group                        |
| `INPUT`        | &lt;filename&gt; | External file name (omissible), can also be use together with the 2nd line or later |

2nd Line or later (when `GENERATE` is not used)

```
(2nd Line) elem1, elem2, elem3 ...
(Hereinafter the same)
```

| Parameter Name | Attributions | Contents                                      |
|----------------|--------------|-----------------------------------------------|
| `elemX`        | I            | Element number belonging to the element group |

2nd Line or later (when `GENERATE` used)

```
(2nd Line) elem1, elem2, elem3
(Hereinafter the same)
```

| Parameter Name | Attributions | Contents                                                                  |
|----------------|--------------|---------------------------------------------------------------------------|
| `elem1`        | I            | First element number in the element group                                 |
| `elem2`        | I            | Last element number in the element group                                  |
| `elem3`        | I            | Element number increment (omissible, number becomes elem3=1 when omitted) |

> Note:
>
> - Any number of elements can be inserted in one line. Any number of lines can be inserted until the next option starts.
> - It is necessary to define the element to be specified before "`!EGROUP`".
> - The element not defined in the "`!ELEMENT`" option will be excluded, and a warning message will be displayed.
> - When the specified element exists in the same group, it will be ignored and a warning message will be displayed.
> All the elements belong to the element group named "`ALL`" (generated automatically).
> One group can be defined by dividing into multiple groups.

Example of Use

```
!EGROUP, EGRP=EA01
 1, 2, 3, 4, 5, 6
 101, 102
 205
!EGROUP, EGRP=EA02
 101, 102
!EGROUP, EGRP=EA01               "501, 505" are added to group "EA01".
 501, 505
!EGROUP, EGRP=EA04, GENERATE     "301, 303, 305, 307, 309, 311, 312, 313"
 301, 309, 2                     are added to group "NA04".
 311, 313
```

#### `!ELEMENT` (M1-3)

Definition of elements

1st Line

```
!ELEMENT, TYPE=<type> [, optional parameter]
```

|Parameter |                              |
|----------|------------------------------|
|`TYPE`    |Element type (mandatory)      |
|`EGRP`    |Element group name (omissible)|
|`MATITEM` |Number of physical property items when defining the material physical properties for each element (not used when defining physical properties for each section)|
|`INPUT`   |External file name (omissible)|

| Parameter Name | Parameter Value  | Contents                                                                             |
|----------------|------------------|--------------------------------------------------------------------------------------|
| `TYPE`         | 111              | Rod, link element (Linear)                                                           |
|                | 231              | Triangular element (Linear)                                                          |
|                | 232              | Triangular element (Quadratic)                                                       |
|                | 241              | Quadrilateral element (Linear)                                                       |
|                | 242              | Quadrilateral element (Quadratic)                                                    |
|                | 301              | Truss element (Linear)                                                               |
|                | 341              | Tetrahedral element (Linear)                                                         |
|                | 342              | Tetrahedral element (Quadratic)                                                      |
|                | 351              | Triangular prism element (Linear)                                                    |
|                | 352              | Triangular prism element (Quadratic)                                                 |
|                | 361              | Hexahedral element (Linear)                                                          |
|                | 362              | Hexahedral element (Quadratic)                                                       |
|                | 541              | Interface element (Quadrilateral cross section, Linear)                              |
|                | 611              | Beam element(Linear)                                                                 |
|                | 641              | Beam element(Linear, with 3-dof nodes)                                               |
|                | 731              | Triangular shell element (Linear)                                                    |
|                | 741              | Quadrilateral shell element (Linear)                                                 |
|                | 743              | Quadrilateral shell element (Quadratic)                                              |
|                | 761              | Triangular shell element (Linear, with 3-dof nodes)                                  |
|                | 781              | Quadrilateral shell element (Linear, with 3-dof nodes)                               |
| `EGRP`         | &lt;egrp&gt;     | Element group name (omissible)                                                       |
| `INPUT`        | &lt;filename&gt; | External file name (omissible), can also be used together with the 2nd line or later |

2nd Line or later

```
(2nd Line) ELEM_ID, nod1, nod2, nod3, ..., MAT1, MAT2, ...
(Hereinafter the same)
```

|Parameter Name|Attributions|Contents                                |
|--------------|------------|----------------------------------------|
|`ELEM_ID`     |I           |Element number                          |
|`nodX`        |I           |Connectivity                            |
|`MATy`        |R           |Physical Property value for each element|

> Note:
>
> - For details of the element types and connectivity, refer to "Chapter 4 Element Library".
> - The node specified by the connectivity must be defined before "`!ELEMENT`".
> - The element numbers do not have to be continued.
> - The "`!ELEMENT`" option can be defined any number of times.
> - The element number must be a natural number. This can not be omitted.
> - When the same element number is used repeatedly, the value input last will be used. In this case, a warning message will be output.
> - Undefined nodes can not be used for connectivity.
> - The definition of one element can be described in multiple lines.

Example of Use

```
!ELEMENT, TYPE=231
 1, 1, 2, 3
 2, 4, 8, 5
 4, 6, 7, 8
!ELEMENT, TYPE=361, EGRP=A
 101, 101, 102, 122, 121, 201, 202, 222, 221
 102, 102, 103, 123, 122, 202, 203, 223, 222
 103, 103, 104, 124, 123, 203, 204, 224, 223
```

#### (4) `!EQUATION` (1-4)

Definition of restricted node group

1st Line

```
!EQUATION [, optional parameter]
```

|Parameter|                              |
|---------|------------------------------|
|`INPUT`  |External file name (omissible)|


|Parameter Name|Parameter Value |Contents                            |
|--------------|----------------|------------------------------------|
|`INPUT`       |&lt;filename&gt;|External file name (omissible), can also be used together with the 2nd line or later|

2nd Line or later

```
(2nd Line) NEQ, CONST
```

```
(3rd Line or later) nod1, DOF1, A1, nod2, DOF2, A2 ... (up to seven terms for one line)
(Hereinafter repeated)
```

|Parameter Name|Attributions|Contents                                              |
|--------------|------------|------------------------------------------------------|
|`NEQ`         |I           |Number of equation terms                              |
|`CONST`       |R           |Constant term of equation (right value)               |
|`nod1`        |I/C         |1st node or node group                                |
|`DOF1`        |I           |Restricted degree of freedom of 1st node or node group|
|`A1`          |R           |Factor of 1st node or node group                      |
|`nod2`        |I/C         |2nd node or node group                                |
|`DOF2`        |I           |Restricted degree of freedom of 2nd node or node group|
|`A2`          |R           |Factor of 2nd node or node group                      |

> Note:
>
> - When a node or a node group not defined by "`!NODE`" is specified, it will be ignored and a warning message will be displayed.
> - In the case of "nod1=nod2", it will be ignored and a warning message will be displayed.
> - When a node group is specified, if the number of nodes is not consistent an error will occur.
> - The degree of freedom number differs by the type of analysis and elements. An inconsistent degree of freedom will be ignored, and a warning message will be displayed.

Example of Use

```
!EQUATION
 3
 101, 1, 1.0, 102, 1, -1.0, 103, 1, -1.0
 2
 NG1, 2, 1.0, NG5, 2, -1.0
```

#### (3) `!HEADER` (M1-5)

Title of mesh data

1st Line

```
!HEADER
```

|Parameter|
|---------|
|N/A      |

2nd Line or later

```
(2nd Line) TITLE
```

|Parameter Name|Attributions|Contents    |
|--------------|------------|------------|
|`TITLE`       |C           |Header title|

Example of Use

```
!HEADER
Mesh for CFD Analysis
```

> Note:
>
> - Omissible
> - Although the header can use multiple lines, it can be recognized as a header up to the 127th column of the first line.
> - When "`!HEADER`" is defined multiple times, the contents will be updated and a warning message will be displayed.

#### (6) `!MATERIAL` (M1-6)

Definition of material physical properties.

When the physical properties depend on the temperature, table input can be performed for each compatible temperature.

The table input can also be performed for the relationship of the stress strain in a stress analysis.

1st Line

```
!MATERIAL, NAME=<name> [, optional parameter]
```

|Parameter|                                                                       |
|---------|-----------------------------------------------------------------------|
|`NAME`   |Material name (mandatory)                                              |
|`ITEM`   |Number of physical property items (omissible, becomes "1" when omitted)|
|`INPUT`  |External file name (omissible)                                         |

|Parameter Name|Parameter Value |Contents                                            |
|--------------|----------------|----------------------------------------------------|
|`NAME`        |&lt;name&gt;    |Material name                                       |
|`ITEM`        |&lt;ITEMnum&gt; |Number of physical property items by user definition|
|`INPUT`       |&lt;filename&gt;|External file name (omissible), can also be used together with the 2nd line or later|

2nd Line or later

```
(2nd Line) !ITEM=1, SUBITEM=<k>
(3rd Line) VAL1-1-1, VAL1-1-2, ... VAL1-1-k, TEMP1-1
(4th Line) VAL1-2-1,VAL1-2-2, ... VAL1-2-k, TEMP1-2
・・
(L+2nd Line) VAL1-L-1,VAL1-L-2, ... VAL1-L-k, TEMP1-L
Hereinafter, the definition is repeated until "!ITEM=<ITEMnum>".
```

|Subparameter (for "!ITEM") |                                           |
|---------------------------|-------------------------------------------|
|`SUBITEM`                  | Number of sub physical property items defined in each of the physical property items(omissible, becomes "1" when omitted, used to define anisotropy and etc.)|

|Subparameter Name|Parameter Value   |Contents                                                |
|-----------------|------------------|--------------------------------------------------------|
|`SUBITEM`        |&lt;subITEMnum&gt;|Number of sub physical property items by user definition|

**[When the m-th physical property depends on the temperature]**

When the number of items of the temperature dependent table is N, input as follows:

```
!ITEM=m, SUBITEM=k
  VALm1-1, ..., VALm1-k, TEMPm1
  VALm2-1, ..., VALm2-k, TEMPm2
  ...
  VALmN-1, ..., VALmN-k, TEMPm-N
```

|Parameter Name|Attributions|Contents                                       |
|--------------|------------|-----------------------------------------------|
|`VALmn-k`     |R           |Physical property value (Temperature dependent)|
|`TEMPmn`      |R           |Compatible temperature                         |

Must be input as `TEMPm1` < `TEMPm2` < ... < `TEMPmN`.

`VALm1` is used when the temperature is `TEMPm1` or below, and `VALmN` is used when the temperature is `TEMPmN` or more.

**[When the m-th physical property does not depend on the temperature]**

```
!ITEM=m, SUBITEM=k
  VALm1-1, ..., VALm1-k
  VALm2-1, ..., VALm2-k
  ...
  VALmN-1, ..., VALmN-k
```

|Parameter Name|Attributions|Contents                                           |
|--------------|------------|---------------------------------------------------|
|VALmn-k       |R           |Physical property value (not temperature dependent)|

> Note:
>
> - When the material name is duplicated, an error will occur.
> - When the MATERIAL referred to in the "`!SECTION`" option is not defined, an error will occur.
> - The value used to input the physical property for each element using the parameter "`MATITEM`" in the "`!ELEMENT`" option, is used preferentially. In this case, the physical property value input using the "`!MATERIAL`" option will not be used.
> - When the number of "!ITEM=m" suboptions and the number of parameters "`ITEM`" is not consistent, or when there is an undefined suboption, and error will occur.
> - The "`!ITEM=m`" suboption does not have to be in order from the smaller m.
> - When using the "`!SUBITEM=k`" suboption and the temperature dependency, the omitted value will become "0.0".
> - When using the temperature dependency, it must be defined in order from the lower temperature.
> - When using the temperature dependency, if the same temperature is used twice or more, an error will occur.

Example of Use

```
!MATERIAL, NAME= STEEL, ITEM= 2
!ITEM=1                            ----- No temperature dependency
 35.0
!ITEM=2
 40.0, 0.0
 45.0, 100.0
 50.0, 200.0
!MATERIAL, NAME= CUPPER            ----- Number of items = 1 (Default value)
!ITEM=1                            ----- No temperature dependency
 80.0
```
Incorrect Example of Use

- Example 1: [Number of parameter "`ITEM`" and "`!ITEM=m`" suboptions are not consistent -1]

```
!MATERIAL, NAME= STEEL, ITEM= 2
!ITEM=3
 20.0
!ITEM=1
 35.0
!ITEM= 2
 40.0
```

- Example 2: [Number of parameter "`ITEM`" and "`!ITEM=m`" suboptions are not consistent -2]

```
!MATERIAL, NAME= STEEL, ITEM= 3
!ITEM=3
 20.0
!ITEM= 2
 40.0
!MATERIAL, NAME= CUPPER
...
```

Elastic Static Analysis and Eigenvalue Analysis

```
!MATERIAL, NAME=<name>, ITEM=<ITEMnum>
!ITEM=1, SUBITEM=2
 <Yang_modulus>, <Poisson_ratio>
!ITEM=2
 <Density>
!ITEM=3
 <Expansion_coeff>
```

|Parameter Name|Parameter Value|Contents                                               |
|--------------|---------------|-------------------------------------------------------|
|`NAME`        |&lt;name&gt;   |Compatible to material name, and MATERIAL of `!SECTION`|
|`ITEM`        |&lt;ITEMnum&gt;|Number of physical property items by user definition (1 or more)<br/> &lt;Yang_modulus&gt; ... Young's modulus (mandatory)<br/> &lt;Poisson_ratio&gt; ... Poisson's ratio (mandatory)<br/> &lt;Density&gt; ... Mass density (mandatory when ITEMnum=3)<br/> &lt;Expansion_coeff&gt; ... Coefficient of linear expansion (when ITEMnum=3)|

Example

```
!! Intention of defining three types of property values
!! in the material of material name M1
!MATERIAL, NAME=M1, ITEM=3

!! The Young's modulus and Poisson's ratio is defined in !ITEM=1 (mandatory)
!ITEM=1, SUBITEM=2
 4000., 0.3

!! The mass density must be defined in !ITEM=2 (mandatory in the case of ITEM=3)
!ITEM=2
 8.0102E‐10

!! The coefficient of linear expansion must be defined in !ITEM=3
!ITEM=3
 1.0E‐5
```

Heat Conduction Analysis

In the case of link, plane surface, solid and three-dimensional plate elements

```
!MATERIAL, NAME=<name>, ITEM=3
!ITEM=1, SUBITEM=2
 <Density>, <Temperature>
!ITEM=2, SUBITEM=2
 <Specific_heat>, <Temperature>
!ITEM=3, SUBITEM=2
 <Conductivity>, <Temperature>
```

|Parameter Name|Parameter Value|Contents                                               |
|--------------|---------------|-------------------------------------------------------|
|`NAME`        |&lt;name&gt;   |Compatible to material name, and MATERIAL of `!SECTION`|
|`ITEM`        |&lt;ITEMnum&gt;|Number of physical property items by user definition (always 3)<br/>&lt;Density&gt; ... Density<br/>&lt;Specific_heat&gt; ... Specific heat<br/>&lt;Conductivity&gt; ... Thermal conductivity<br/>&lt;Temperature&gt; ... Temperature|

Example

```
!! Intention of defining three types of property
!! values in the material of material name M1
!MATERIAL, NAME=M1, ITEM=3

!! The density and temperature are defined in !ITEM=1 (mandatory)
!ITEM=1, SUBITEM=1
 7850., 300.
 7790., 500.
 7700., 800.

!! The specific heat and temperature are defined in !ITEM=2 (mandatory)
!ITEM=2, SUBITEM=1
 0.465, 300.
 0.528, 500.
 0.622, 800.

!! The thermal conductivity and temperature are defined in !ITEM=3 (mandatory)
!ITEM=3
 43., 300.
 38.6, 500.
 27.7, 800.
```

In the case of interface element

Defined in the `!SECTION` header. (Material data is not required)

Example

```
!! Definition of section
!SECTION, TYPE=INTERFACE, EGRP=GAP
 1.0, 20.15, 8.99835E-9, 8.99835E-9
```

In the above `!SECTION`, the gap parameter of the element belonging to the "`group name = GAP`" in the interface element is defined.

  - 1st parameter : Gap width
  - 2nd parameter : Gap heat transfer coefficient
  - 3rd parameter : Gap radiation factor 1
  - 4th parameter : Gap radiation factor 2

Reference

```
      program TEST
      use hecmw
      implicit REAL*8 (A-H,O-Z)
      type (hecmwT_local_mesh) :: hecMESH

!C
!C    !MATERIAL, NAME=SUS304, ITEM=3
!C    !ITEM=1, SUBITEM= 3
!C      100.0, 200.0, 300.0, 0.00
!C      101.0, 210.0, 301.0, 1.00
!C      102.0, 220.0, 302.0, 2.00
!C      103.0, 230.0, 303.0, 3.00
!C    !ITEM=3, SUBITEM= 2
!C      1000.0, , 0.00
!C      1001.0, 1., 1.00
!C      1002.0, 2., 2.00
!C      1003.0, 3., 3.00
!C    !ITEM=2
!C      5000.0
!C
!C    !MATERIAL, NAME=FEC, ITEM=2
!C    !ITEM=1, SUBITEM= 3
!C      2100.0, 2200.0, 2300.0, 0.00
!C      2101.0, 2210.0, 2301.0, 1.00
!C      2102.0, 2220.0, 2302.0, 2.00
!C      2103.0, 2230.0, 2303.0, 3.00
!C      3103.0, 3230.0, 2304.0, 4.00
!C    !ITEM=2
!C      6000.0, 10.0
!C      6500.0, 30.0
!C

      hecMESH%material%n_mat = 2

      nn= hecMESH%material%n_mat
      allocate (hecMESH%material%mat_name(nn))

      hecMESH%material%mat_name(1)= 'SUS304'
      hecMESH%material%mat_name(2)= 'FEC'

      nn= hecMESH%material%n_mat
      allocate (hecMESH%material%mat_ITEM_index(0:nn))
      hecMESH%material%mat_ITEM_index(0)= 0
      hecMESH%material%mat_ITEM_index(1)= 3
      hecMESH%material%mat_ITEM_index(2)= hecMESH%material%mat_ITEM_index(1) + 2

      hecMESH%material%n_mat_ITEM= hecMESH%material%mat_ITEM_index(hecMESH%material%n_mat)

      nn= hecMESH%material%n_mat_ITEM
      allocate (hecMESH%material%mat_subITEM_index(0:nn))

      hecMESH%material%mat_subITEM_index(0)= 0
      hecMESH%material%mat_subITEM_index(1)= 3
      hecMESH%material%mat_subITEM_index(2)= hecMESH%material%mat_subITEM_index(1) + 1
      hecMESH%material%mat_subITEM_index(3)= hecMESH%material%mat_subITEM_index(2) + 2
      hecMESH%material%mat_subITEM_index(4)= hecMESH%material%mat_subITEM_index(3) + 3
      hecMESH%material%mat_subITEM_index(5)= hecMESH%material%mat_subITEM_index(4) + 1

      hecMESH%material%n_mat_subITEM=
     &        hecMESH%material%mat_subITEM_index(hecMESH%material%n_mat_ITEM)

      nn= hecMESH%material%n_mat_subITEM
      allocate (hecMESH%material%mat_TABLE_index(0:nn))
      hecMESH%material%mat_TABLE_index( 0)= 0
      hecMESH%material%mat_TABLE_index( 1)= 4
      hecMESH%material%mat_TABLE_index( 2)= hecMESH%material%mat_TABLE_index( 1) + 4
      hecMESH%material%mat_TABLE_index( 3)= hecMESH%material%mat_TABLE_index( 2) + 4
      hecMESH%material%mat_TABLE_index( 4)= hecMESH%material%mat_TABLE_index( 3) + 1
      hecMESH%material%mat_TABLE_index( 5)= hecMESH%material%mat_TABLE_index( 4) + 4
      hecMESH%material%mat_TABLE_index( 6)= hecMESH%material%mat_TABLE_index( 5) + 4
      hecMESH%material%mat_TABLE_index( 7)= hecMESH%material%mat_TABLE_index( 6) + 5
      hecMESH%material%mat_TABLE_index( 8)= hecMESH%material%mat_TABLE_index( 7) + 5
      hecMESH%material%mat_TABLE_index( 9)= hecMESH%material%mat_TABLE_index( 8) + 5
      hecMESH%material%mat_TABLE_index(10)= hecMESH%material%mat_TABLE_index( 9) + 2

      hecMESH%material%n_mat_TABLE=
     &        hecMESH%material%mat_TABLE_index(hecMESH%material%n_mat_subITEM)

      nn= hecMESH%material%n_mat_TABLE
      allocate (hecMESH%material%mat_VAL (nn))
      allocate (hecMESH%material%mat_TEMP(nn))

      hecMESH%material%mat_VAL = 0.d0
      hecMESH%material%mat_TEMP= 0.d0

      hecMESH%material%mat_VAL ( 1)= 100.0d0
      hecMESH%material%mat_TEMP( 1)=   0.0d0
      hecMESH%material%mat_VAL ( 2)= 101.0d0
      hecMESH%material%mat_TEMP( 2)=   1.0d0
      hecMESH%material%mat_VAL ( 3)= 102.0d0
      hecMESH%material%mat_TEMP( 3)=   2.0d0
      hecMESH%material%mat_VAL ( 4)= 103.0d0
      hecMESH%material%mat_TEMP( 4)=   3.0d0

      hecMESH%material%mat_VAL ( 5)= 200.0d0
      hecMESH%material%mat_TEMP( 5)=   0.0d0

      hecMESH%material%mat_VAL (13)= 5000.0d0

      hecMESH%material%mat_VAL (14)= 1000.0d0
      hecMESH%material%mat_TEMP (14)=   0.0d0
      hecMESH%material%mat_VAL (15)= 1001.0d0
      hecMESH%material%mat_TEMP (15)=   1.0d0
      hecMESH%material%mat_VAL (16)= 1002.0d0
      hecMESH%material%mat_TEMP (16)=   2.0d0
      hecMESH%material%mat_VAL (17)= 1003.0d0
      hecMESH%material%mat_TEMP (17)=   3.0d0

      hecMESH%material%mat_VAL (18)=  0.0d0
      hecMESH%material%mat_TEMP (18)= 0.0d0
      hecMESH%material%mat_VAL (19)=  1.0d0
      hecMESH%material%mat_TEMP (19)= 1.0d0
      hecMESH%material%mat_VAL (20)=  2.0d0
      hecMESH%material%mat_TEMP (20)= 2.0d0
      hecMESH%material%mat_VAL (21)=  3.0d0
      hecMESH%material%mat_TEMP (21)= 3.0d0

      hecMESH%material%mat_VAL (22)= 2100.0d0
      hecMESH%material%mat_TEMP (22)=   0.0d0
      hecMESH%material%mat_VAL (23)= 2101.0d0
      hecMESH%material%mat_TEMP (23)=   1.0d0
      hecMESH%material%mat_VAL (24)= 2102.0d0
      hecMESH%material%mat_TEMP (24)=   2.0d0
      hecMESH%material%mat_VAL (25)= 2103.0d0
      hecMESH%material%mat_TEMP (25)=   3.0d0
      hecMESH%material%mat_VAL (26)= 3103.0d0
      hecMESH%material%mat_TEMP (26)=   4.0d0

      write (*,'(a,i10)') '%n_mat_ITEM ', hecMESH%material%n_mat_ITEM
      write (*,'(a,i10)') '%n_mat_subITEM', hecMESH%material%n_mat_subITEM
      write (*,'(a,i10)') '%n_mat_TABLE ', hecMESH%material%n_mat_TABLE

end program TEST
```

#### (7) `!NGROUP` (M1-7)

Definition of node group

1st Line

```
!NGROUP, NGRP=<ngrp> [, optional parameter]
```

|Parameter |                                                                     |
|----------|---------------------------------------------------------------------|
|`NGRP`    |Node group name (mandatory)                                          |
|`GENERATE`|Automatic generation of nodes belonging to the node group (omissible)|
|`INPUT`   |External file name (omissible)                                       |

|Parameter Name|Parameter Value |Contents                                        |
|--------------|----------------|------------------------------------------------|
|`NGRP`        |&lt;ngrp&gt;    |Node group name GENERATE N/A Automatic generation of nodes belonging to the node group|
|`INPUT`       |&lt;filename&gt;|External file name (omissible), can also be used together with the 2nd line or later|

2nd Line or later (when `GENERATE` is not used)

```
(2nd Line) nod1, nod2, nod3
(Hereinafter the same)
```

|Parameter Name|Attributions|Contents                               |
|--------------|------------|---------------------------------------|
|`nodX`        |I           |Node number belonging to the node group|

2nd Line or later (when `GENERATE` is used)

```
(2nd Line) nod1, nod2, nod3
(Hereinafter the same)
```

|Parameter Name|Attributions|Contents                                 |
|--------------|------------|-----------------------------------------|
|`nod1`        |I           |First node number in the node group      |
|`nod2`        |I           |Last node number in the node group       |
|`nod3`        |I           |Node number increment (omissible, number becomes `nod3=1` when ommited)|

> Note:
>
> - Any number of nodes can be inserted in one line. Any number of lines can be inserted until the next option starts.
> - It is necessary to define the nodes to be specified before "`!NGROUP`".
> -  The node not defined in the "`!NODE`" option will be excluded, and a warning message will be displayed.
> - When the specified node exists in the same group, it will be ignored and a warning message will be displayed.
> - All the nodes belong to the node group named "`ALL`" (generated automatically).
> - One group can be defined by dividing into multiple groups.

Example of Use

```
!NGROUP, NGRP=NA01
 1, 2, 3, 4, 5, 6
 101, 102
!NGROUP, NGRP=NA02
 101, 102
!NGROUP, NGRP=NA01                   ----- "501 and 505" are added to group "NA01".
 501, 505
!NGROUP, NGRP=NA02                   ----- "501 and 505" are added to group "NA02".
 501, 505
!NGROUP, NGRP=NA04,GENERATE          ----- "301, 303, 305, 307, 309, 311, 312, 313"
 301, 309, 2                               are added to group "NA04".
 311, 313
```

#### (8) `!NODE` (M1-8)

Definition of node coordinates

1st Line

```
!NODE [, optional parameter]
```

|Parameter|                              |
|---------|------------------------------|
|`SYSTEM` |Coordinate system (omissible) |
|`NGRP`   |Node group name (omissible)   |
|`INPUT`  |External file name (omissible)|

|Parameter Name|Parameter Value |Contents                                                                            |
|--------------|----------------|------------------------------------------------------------------------------------|
|`SYSTEM`      |R               |Cartesian coordinate system (Default value)                                         |
|              |C               |Cylindrical coordinate system                                                       |
|`NGRP`        |&lt;ngrp&gt;    |Node group name (omissible)                                                         |
|`INPUT`       |&lt;filename&gt;|External file name (omissible), can also be used together with the 2nd line or later|

2nd Line or later

```
(2nd Line) NODE_ID, Xcoord, Ycoord, Zcoord
(Hereinafter the same)
```

|Parameter Name|Attributions|Contents    |
|--------------|------------|------------|
|`NODE_ID`     |I           |Node number |
|`Xcoord`      |R           |X coordinate|
|`Ycoord`      |R           |Y coordinate|
|`Zcoord`      |R           |Z coordinate|

> Note:
>
> - When node coordinates including the punctuation mark is omitted, the value will become "0.0".
> - When an already defined node is redefined, the contents will be updated and a warning message will be displayed.
> - The node which is not referred to in "`!ELEMENT`" will be excluded. 
> - The node defined in "`!ELEMENT`" must be defined before "`!ELEMENT`".

Example of Use

```
!NODE, NGRP=TEST
 1, 0.0, 0.0, 0.5
 2, 0.0, 0.0, 1.0
 3, 0.0,,1.5                    ----- Y coordinate is "0.0"
 4,                             ----- X, Y and Z coordinates are "0.0"
```

#### (9) `!SECTION` (M1-9)

Definition of section

1st Line

```
!SECTION, TYPE=<type>, EGRP=<egrp> [, optional parameter]
```

|Parameter  |                                                                             |
|-----------|-----------------------------------------------------------------------------|
|`TYPE`     |Section type (mandatory)                                                     |
|`EGRP`     |Element group name (mandatory)                                               |
|`MATERIAL` |User defined material name (mandatory)                                       |
|`SECOPT`   |Auxiliary parameter for the element type (omissible, becomes =0 when omitted)|
|`INPUT`    |External file name (omissible)                                               |

| Parameter Name | Parameter Value  | Contents                                                                             |
|----------------|------------------|--------------------------------------------------------------------------------------|
| `TYPE`         | `SOLID`          | Rod, triangular, quadrilateral, tetrahedral, pentahedral, hexadedral elements        |
|                | `SHELL`          | Shell element                                                                        |
|                | `BEAM`           | Beam element                                                                         |
|                | `INTERFACE`      | Interface element                                                                    |
| `EGRP`         | &lt;egrp&gt;     | Element group name                                                                   |
| `MATERIAL`     | &lt;material&gt; | Material name defined by user                                                        |
| `SECOPT`       | &lt;secopt&gt;   | = 0: Not specified, plane stress                                                     |
|                |                  | = 1: Plane strain                                                                    |
|                |                  | = 2: Axial symmetry                                                                  |
|                |                  | = 10: 0 + reduced integration                                                        |
|                |                  | = 11: 1 + reduced integration                                                        |
|                |                  | = 12: 2 + reduced integration                                                        |
| `INPUT`        | &lt;filename&gt; | External file name (omissible), can also be used together with the 2nd line or later |

2nd Line or later

**In the case of [`TYPE=SOLID`]**

```
(2nd Line) THICKNESS
```

|Parameter Name|Attributions|Contents                               |
|--------------|------------|---------------------------------------|
|`THICKNESS`   |R           |Element thickness, cross-sectional area|

In the case of "`TYPE=SOLID`", the "`THICKNESS`" can be omitted, and default value (1.0) is inserted.

**In the case of [`TYPE=SHELL`]**

```
(2nd Line) THICKNESS, INTEGPOINTS
```

|Parameter Name|Attributions|Contents                                         |
|--------------|------------|-------------------------------------------------|
|`THICKNESS`   |R           |Shell cross section thickness                    |
|`INTEGPOINTS` |I           |Integral point in shell cross sectional direction|

**In the case of [`TYPE=BEAM`]**

```
(2nd Line) vx,vy,vz,area,Iyy,Iz,Jx
```

|Parameter Name|Attributions|Contents                          |
|--------------|------------|----------------------------------|
|vx,vy,vz      |R           |Direction cosine of reference axis|
|area          |R           |Area of cross section             |
|Iyy, Izz      |R           |Second moment of cross section    |
|Jx            |R           |Torsion constant of cross section |

**In the case of [`TYPE=INTERFACE`]**

```
(2nd Line) THICKNESS, GAPCON, GAPRAD1, GAPRAD2
```

|Parameter Name|Attributions|Contents                                           |
|--------------|------------|---------------------------------------------------|
|`THICKNESS`   |R           |Cross-sectional thickness                          |
|`GAPCON`      |R           |Gap heat transfer coefficient (0 when omitted)     |
|`GAPRAD1`     |R           |Gap radiant heat transfer factor-1 (0 when omitted)|
|`GAPRAD2`     |R           |Gap radiant heat transfer factor-2 (0 when omitted)|

> Note:
>
> - When the parameter "`TYPE`" is not consistent with the element type, an error will occur.
> - When there is an element without `SECTION` information, an error will occur.
> - When the section name is duplicated, an error will occur.

Example of Use

```
!SECTION, EGRP=SOLID1, TYPE=SOLID, MATERIAL=STEEL
!SECTION, EGRP=SHELL2, TYPE=SHELL, MATERIAL=STEEL
 1.0, 5
```

#### (10) `!SGROUP` (M1-10)

Definition of surface group

1st Line

```
!SGROUP, SGRP=<sgrp> [, optional parameter]
```

|Parameter|                              |
|---------|------------------------------|
|`SGRP`   |Surface group name (mandatory)|
|`INPUT`  |External file name (omissible)|

|Parameter Name|Parameter Value |Contents                                                                            |
|--------------|----------------|------------------------------------------------------------------------------------|
|`SGRP`        |&lt;sgrp&gt;    |Surface group name                                                                  |
|`INPUT`       |&lt;filename&gt;|External file name (omissible), can also be used together with the 2nd line or later|

2nd Line or later

```
(2nd Line) elem1, lsuf1, elem2, lsuf2, elem3, lsuf3, ...
(Hereinafter the same)
```

|Parameter Name|Attributions|Contents                                                          |
|--------------|------------|------------------------------------------------------------------|
|elemX         |I           |Element number belonging to the surface group                     |
|lsufX         |I           |Local surface number of the element belonging to the surface group|

> Note:
>
> - For the element type and surface number, refer to "Chapter 4 Element Library".
> - The surface consists of a combination of (elements and local surface numbers). Any number of surfaces can be inserted in one line. Any number of lines can be inserted until the next option starts. The combination of (elements and local surface numbers) must be in the same line.
> - It is necessary to define the element to be specified before "`!SGROUP`".
> - The element not defined in "`!ELEMENT`" option will be excluded, and a warning message will be displayed.
> - The surface which includes the element not defined in "`!ELEMENT`" option will be excluded, and a warning message will be displayed.
> - The surface where the element type and the surface number are not consistent will be excluded, and a warning message will be displayed.
> - One group can be defined by dividing into multiple groups.

Example of Use

```
!SGROUP, SGRP= SUF01
 101, 1, 102, 1, 103, 2, 104, 2
 201, 1, 202, 1
 501, 1
!SGROUP, SGRP= SUF02
 101, 2, 102, 2
!SGROUP, SGRP= EA01     "(601,1) and (602 2)" are added to group "SUF01".
 601, 1
 602, 2
```

Incorrect Example of Use

- Example 1: [When (elements, and local surface numbers) group exists in multiple lines]

```
!SGROUP, SGRP= SUF01
 101, 1, 102, 1, 103
 1, 104, 1
```

- Example 2: [Local surface numbers and element type are not consistent]

```
!ELEMENT, TYPE= 211, SECTION= A
101, 1, 2, 3
102, 2, 3, 4
...
!SGROUP, SGRP= SUF01
101, 1
101, 2
101, 4                  Since a 4th surface does not exist in a triangular element,
                        this combination will be disregarded.
```

#### (11) `!ZERO` (M1-11)

Absolute zero-point

1st Line

```
!ZERO
```

| Parameter |
|-----------|
| N/A       |

2nd Line or later

```
(2nd Line) ZERO
```

|Parameter Name|Attributions|Contents           |
|--------------|------------|-------------------|
|`ZERO`        |R           |Absolute zero-point|

> Note:
>
> - Omissible. Becomes "absolute zero-point = 0" when omitted.
> - When "`!ZERO`" is defined multiple times, the contents will be updated and a warning message will be displayed.

Example of Use

```
!ZERO
-273.16
```

#### (12) `!CONTACT PAIR` (M1-12)

Definition of contact surface pair used for contact analysis

1st Line

```
!CONTACT PAIR, NAME=<name> [,optional parameter]
```

|Parameter|                             |
|---------|-----------------------------|
|`NAME`   |Contact pair name (mandatory)|
|`TYPE`   |Type (omissible)             |

| Parameter Name | Parameter Value | Contents                                                                          |
|----------------|-----------------|-----------------------------------------------------------------------------------|
| `TYPE`         | `NODE-SURF`     | Slave surface is the node group<br/>Master surface is the surface group (default) |
|                | `SURF-SURF`     | Both the slave surface and master surface are the surface group                   |

2nd Line or later

```
(2nd Line or later) SLAVE_GRP, MASTER_GRP
(Hereinafter the same)
```

|Parameter Name|Attributions|Contents                                |
|--------------|------------|----------------------------------------|
|`SLAVE_GRP`   |C           |Slave surface node / surface group name |
|`MASTER_GRP`  |C           |Surface group name of the master surface|

> Note:
>
> - When using mesh-refinement functionality, always use "`TYPE=SURF-SURF`".
> - Even when "`TYPE=SURF-SURF`" is used, the internal contact algorithm within FrontISTR is one for point-to-surface type contact.

Reference

  - When "`TYPE=SURF-SURF`" is used, the contact pair is converted to a node-surface type contact pair within FrontISTR by automatically generating a node-group from the slave surface-group.
  - The group-name of the automatically generated node group is concatenation of "`FSTR_S2N_`" and the group-name of the original slave surface-group.

#### (13) `!END` (M1-13)

End of mesh data

When this header is displayed, the reading of the mesh data is completed.

#### 1st Line

```
!END
```

|Parameter|
|---------|
|N/A      |

#### 2nd Line or later

|Parameter|
|---------|
|N/A      |


