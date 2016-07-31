# Single Domain Mesh Data

## Outline of Single Mesh Data

In order to acquire the mesh data of FrontISTR, there are two methods,
such as the method to input the single domain mesh data file, and the
method to input the distributed mesh data file to perform parallel
processing. Single domain mesh data is described in this section.

The features of single domain mesh data are as follows.

・　This is an ASCII format file based on a free format.

・　This file consists of a header which starts with "!" and the data
following this.

・　The order of description of the header is basically free.

・　A "," is used as a punctuation mark of the data.

## Input Rules

The single domain mesh data file consists of a header line, data line
and a comment line.

One header is always included in the header line.

&lt;Header&gt;

The meaning of the data and data block is specified in the single domain
mesh data file.

When the head of the term starts with a "!", it is considered to be a
header.

&lt;Header Line&gt;

The contents of the header and the parameter accompanying this are
described in this line.

The header line must start with a header. When a parameter is required,
a "," must be used to continue after that. When the parameter takes on a
value, use an "=" after the parameter and describe the value after that.
The header line can not be described in more than two lines.

&lt;Data Line&gt;

The data line starts after the header line, and the necessary data is
described.

The data lines may be in multiple lines; however, this is determined
according to the rules of the data description defined by each header.

There are cases where data lines are not required.

&lt;Punctuation&gt;

A comma ( , ) is used as a punctuation of the data.

&lt;Handling of Blanks&gt;

Blanks are disregarded.

&lt;Name&gt;

Regarding the characters which can be used for the name, there is the
underscore "\_", hyphen "-", and alphanumeric characters "a - z, A - Z,
0 - 9"; however, the first letter of the name must start with "\_", or
an alphabetic character "a - z, A - Z". There is no distinction between
uppercase and lowercase letters, and all letters are internally handled
as uppercase letters.

The maximum length of the name is 63 characters.

&lt;File Name&gt;

Regarding the characters which can be used for the file name, there are
the underscore "\_", hyphen "-", period ".", slash "/", and the
alphanumeric characters "a - z, A - Z, 0 - 9".

As long as there is no specific description, a path can be included in
the file name. Both the relative path and the absolute path can be
specified.

The maximum length of the file name is 1,023 characters.

&lt;Floating Point Data&gt;

Exponents are optional. An "E" or "e" character must be added before the
exponent.

The selection of "E" or "e" is optional. "D" or "d" can not be used.

&lt;!!, \# Comment Line&gt;

Lines starting with "!!" or "\#" are considered to be comment lines, and
are disregarded.

A comment line can be inserted in any position in the file, and there
are no restrictions on the number of lines.

## Header List of Single Domain Mesh Data

The single domain mesh data consists of the following headers.

  Header Name          Contents                Description No.
  -------------------- ----------------------- -----------------
  !AMPLITUDE           Unsteady load           M1-1
  !EGROUP              Element group           M1-2
  !ELEMENT             Element information     M1-3
  !EQUATION            Restricted point data   M1-4
  !HEADER              Title of mesh data      M1-5
  !INITIAL CONDITION   Initial conditions      M1-6
  !MATERIAL            Material information    M1-7
  !NGROUP              Node group              M1-8
  !NODE                Node information        M1-9
  !SECTION             Section information     M1-10
  !SGROUP              Surface group           M1-11
  !ZERO                Absolute zero-point     M1-12
  !CONTACT PAIR        Contact surface pair    M1-13
  !END                 Read end                M1-14

In each header, there are data items which are compatible to the
parameter and each header.

Each of the above headers is briefly described in the following with
examples of data creation. The number indicated on the right end of the
data creation is the description number of the above Table.

&lt;Example of Mesh Data&gt;

!HEADER M1-5

TEST MODEL CTLR10

!NODE M1-9

1, 0.00000E+00, 0.00000E+00, 0.00000E+00

2, 0.50000E+01, 0.00000E+00, 0.00000E+00

3, 0.10000E+02, 0.00000E+00, 0.00000E+00

・・・・　 ・・・・ 　　　　　・・・・

!ELEMENT,TYPE=351 M1-3

1, 1, 2, 4, 34, 35, 37

2, 2, 5, 4, 35, 38, 37

3, 2, 3, 5, 35, 36, 38

・・・・　　　　　　・・・・　　　　　・・・・

!SECTION, TYPE=SOLID, EGRP=ALL, MATERIAL=M1 M1-10

1.0

!MATERIAL, NAME=M1, ITEM=2 M1-7

!ITEM=1, SUBITEM=2

2.1E6, 0.3

!ITEM=2, SUBITEM=1

7.8e-3

!NGROUP, NGRP=FIX, GENERATE M1-8

2 , 2 , 1

3 , 3 , 1

1 , 1 , 1

69 , 69 , 1

67 , 67 , 1

!NGROUP, NGRP=CL1 M1-9

50

!END M1-14

##### !AMPLITUDE (M1-1)

Specifies the changes of time of the variables which provide the load
conditions in the step.

1st Line {#st-line .afff5}

!AMPLITUDE, NAME=&lt;name&gt; \[, optional parameter\]

  Parameter    
  ------------ --------------------------------
  NAME         Name (mandatory)
  DEFINITION   Type (omissible)
  TIME         Type of time (omissible)
  VALUE        Type of value (omissible)
  INPUT        External file name (omissible)

  Parameter Name   Parameter Value    Contents
  ---------------- ------------------ -------------------------------------------------------------------------------------
  NAME             &lt;name&gt;       AMPLITUDE Name
  DEFINITION       TABULAR            Default (default only in current version)
  TIME             STEP TIME          Default (default only in current version)
  VALUE            RELATIVE           Relative value (default)
                   ABSOLUTE           Absolute value
  INPUT            &lt;filename&gt;   External file name (omissible), can also be use together with the 2nd line or later

2nd Line or later {#nd-line-or-later .afff5}

(2nd Line or later) VAL1, T1, VAL2, T2, VAL3, T3 ... (up to four items
in one line)

Hereinafter repeated

  Parameter Name   Attributions   Contents
  ---------------- -------------- ------------------
  VAL1             R              Value at time T1
  T1               R              Time T1
  VAL2             R              Value at time T2
  T2               R              Time T2
  VAL3             R              Value at time T3
  T3               R              Time T3

##### !EGROUP (M1-2）

Definition of element group

1st Line {#st-line-1 .afff5}

!EGROUP, EGRP=&lt;egrp&gt; \[, optional parameter\]

  Parameter   
  ----------- --------------------------------------------------------------------------
  EGRP        Element group name (mandatory)
  GENERATE    Automatic generation of nodes belonging to the element group (omissible)
  INPUT       External file name (omissible)

  Parameter Name   Parameter Value    Contents
  ---------------- ------------------ -------------------------------------------------------------------------------------
  EGRP             &lt;egrp&gt;       Element group name
  GENERATE         N/A                Automatic generation of nodes belonging to the element group
  INPUT            &lt;filename&gt;   External file name (omissible), can also be use together with the 2nd line or later

2nd Line or later (when GENERATE is not used) {#nd-line-or-later-when-generate-is-not-used .afff5}

(2nd Line) elem1, elem2, elem3 ...

(Hereinafter the same)

  Parameter Name   Attributions   Contents
  ---------------- -------------- -----------------------------------------------
  elemX            I              Element number belonging to the element group

2nd Line or later (when GENERATE is used) {#nd-line-or-later-when-generate-is-used .afff5}

(2nd Line) elem1, elem2, elem3

(Hereinafter the same)

  Parameter Name   Attributions   Contents
  ---------------- -------------- ---------------------------------------------------------------------------
  elem1            I              First element number in the element group
  elem2            I              Last element number in the element group
  elem3            I              Element number increment (omissible, number becomes elem3=1 when omitted)

Note: {#note .afff5}

-   Any number of elements can be inserted in one line. Any number of
    > lines can be inserted until the next option starts.

-   It is necessary to define the element to be specified
    > before "!EGROUP".

-   The element not defined in the "!ELEMENT" option will be excluded,
    > and a warning message will be displayed.

-   When the specified element exists in the same group, it will be
    > ignored and a warning message will be displayed.

-   All the elements belong to the element group named "ALL"
    > (generated automatically).

-   One group can be defined by dividing into multiple groups.

Example of Use {#example-of-use .afff5}

!EGROUP, EGRP=EA01

1, 2, 3, 4, 5, 6

101, 102

205

!EGROUP, EGRP=EA02

101, 102

!EGROUP, EGRP=EA01 "501, 505" are added to group "EA01".

501, 505

!EGROUP, EGRP=EA04,　GENERATE "301, 303, 305, 307, 309, 311, 312, 313"
are added to

301, 309, 2 group "NA04".

311, 313

##### \
!ELEMENT（M1-3）

Definition of elements

1st Line {#st-line-2 .afff5}

!ELEMENT, TYPE=&lt;type&gt; \[, optional parameter\]

  Parameter   
  ----------- -----------------------------------------------------------------------------------------------------------------------------------------------------------------
  TYPE        Element type (mandatory)
  EGRP        Element group name (omissible)
  MATITEM     Number of physical property items when defining the material physical properties for each element (not used when defining physical properties for each section)
  INPUT       External file name (omissible)

  Parameter Name   Parameter Value    Contents
  ---------------- ------------------ --------------------------------------------------------------------------------------
  TYPE             111                Rod, link element (Linear)
                   231                Triangular element (Linear)
                   232                Triangular element (Quadratic)
                   241                Quadrilateral element (Linear)
                   242                Quadrilateral element (Quadratic)
                   301                Truss element (Linear)
                   341                Tetrahedral element (Linear)
                   342                Tetrahedral element (Quadratic)
                   351                Triangular prism element (Linear)
                   352                Triangular prism element (Quadratic)
                   361                Hexahedral element (Linear)
                   362                Hexahedral element (Quadratic)
                   541                Interface element (Quadrilateral cross section, Linear)
                   611                Beam element(Linear)
                   641                Beam element(Linear, with 3-dof nodes)
                   731                Triangular shell element (Linear)
                   741                Quadrilateral shell element (Linear)
                   743                Quadrilateral shell element (Quadratic)
                   761                Triangular shell element (Linear, with 3-dof nodes)
                   781                Quadrilateral shell element (Linear, with 3-dof nodes)
  EGRP             &lt;egrp&gt;       Element group name (omissible)
  INPUT            &lt;filename&gt;   External file name (omissible), can also be used together with the 2nd line or later

2nd Line or later {#nd-line-or-later-1 .afff5}

(2nd Line) ELEM\_ID, nod1, nod2, nod3, ..., MAT1, MAT2, ...

(Hereinafter the same)

  Parameter Name   Attributions   Contents
  ---------------- -------------- ------------------------------------------
  ELEM\_ID         I              Element number
  nodX             I              Connectivity
  MATy             R              Physical Property value for each element

Note: {#note-1 .afff5}

-   For details of the element types and connectivity, refer to "Chapter
    4 Element Library".

-   The node specified by the connectivity must be defined
    before "!ELEMENT".

-   The element numbers do not have to be continued.

-   The "!ELEMENT" option can be defined any number of times.

-   The element number must be a natural number. This can not
    be omitted.

-   When the same element number is used repeatedly, the value input
    last will be used. In this case, a warning message will be output.

-   Undefined nodes can not be used for connectivity.

-   The definition of one element can be described in multiple lines.

Example of Use {#example-of-use-1 .afff5}

!ELEMENT, TYPE=231

1, 1, 2, 3

2, 4, 8, 5

4, 6, 7, 8

!ELEMENT, TYPE=361, EGRP=A

101, 101, 102, 122, 121, 201, 202, 222, 221

102, 102, 103, 123, 122, 202, 203, 223, 222

103, 103, 104, 124, 123, 203, 204, 224, 223

##### \
!EQUATION（1-4）

Definition of restricted node group

1st Line {#st-line-3 .afff5}

!EQUATION \[, optional parameter\]

  Parameter   
  ----------- --------------------------------
  INPUT       External file name (omissible)

  Parameter Name   Parameter Value    Contents
  ---------------- ------------------ --------------------------------------------------------------------------------------
  INPUT            &lt;filename&gt;   External file name (omissible), can also be used together with the 2nd line or later

2nd Line or later {#nd-line-or-later-2 .afff5}

(2nd Line) NEQ, CONST

(3rd Line or later) nod1, DOF1, A1, nod2, DOF2, A2 ... (up to seven
terms for one line)

Hereinafter repeated

  Parameter Name   Attributions   Contents
  ---------------- -------------- --------------------------------------------------------
  NEQ              I              Number of equation terms
  CONST            R              Constant term of equation (right value)
  nod1             I/C            1st node or node group
  DOF1             I              Restricted degree of freedom of 1st node or node group
  A1               R              Factor of 1st node or node group
  nod2             I/C            2nd node or node group
  DOF2             I              Restricted degree of freedom of 2nd node or node group
  A2               R              Factor of 2nd node or node group

Note: {#note-2 .afff5}

-   When a node or a node group not defined by "!NODE" is specified, it
    will be ignored and a warning message will be displayed.

-   In the case of "nod1=nod2", it will be ignored and a warning message
    will be displayed.

-   When a node group is specified, if the number of nodes is not
    consistent an error will occur.

-   The degree of freedom number differs by the type of analysis
    and elements. An inconsistent degree of freedom will be ignored, and
    a warning message will be displayed.

Example of Use {#example-of-use-2 .afff5}

!EQUATION

3

101, 1, 1.0, 102, 1, -1.0, 103, 1, -1.0

2

NG1, 2, 1.0, NG5, 2, -1.0

##### \
!HEADER（M1-5）

Title of mesh data

1st Line {#st-line-4 .afff5}

!HEADER

Parameter

N/A

2nd Line or later {#nd-line-or-later-3 .afff5}

(2nd Line) TITLE

  Parameter Name   Attributions   Contents
  ---------------- -------------- --------------
  TITLE            C              Header title

Example of Use {#example-of-use-3 .afff5}

!HEADER

Mesh for CFD Analysis

Note: {#note-3 .afff5}

-   Omissible

-   Although the header can use multiple lines, it can be recognized as
    a header up to the 127th column of the first line.

-   When "!HEADER" is defined multiple times, the contents will be
    updated and a warning message will be displayed.

##### \
!INITIAL CONDITION （M1-6）

Definition of temperature initial condition

1st Line {#st-line-5 .afff5}

!INITIAL CONDITION, TYPE=&lt;type&gt; \[, optional parameter\]

  Parameter   
  ----------- --------------------------------
  TYPE        Type (mandatory)
  INPUT       External file name (omissible)

  Parameter Name   Parameter Value    Contents
  ---------------- ------------------ --------------------------------------------------------------------------------------
  TYPE             TEMPERATURE        Temperature
  INPUT            &lt;filename&gt;   External file name (omissible), can also be used together with the 2nd line or later

2nd Line or later {#nd-line-or-later-4 .afff5}

(2nd Line or later) nod1, VAL1 (One group for one line)

Hereinafter repeated

  Parameter Name   Attributions   Contents
  ---------------- -------------- ---------------------------
  nod1             I/C            Node number or node group
  VAL1             R              Node value

Example of Use {#example-of-use-4 .afff5}

!INITIAL CONDITION，TYPE=TEMPERATURE

101, 25.0

NA01, 38.0

Note: {#note-4 .afff5}

-   When a node or a node group not defined by "!NODE" is specified, it
    will be ignored and a warning message will be displayed.

-   When the same node is redefined, an error will occur.

##### !MATERIAL (M1-7)

Definition of material physical properties

When the physical properties depend on the temperature, table input can
be performed for each compatible temperature.

The table input can also be performed for the relationship of the stress
strain in a stress analysis.

1st Line {#st-line-6 .afff5}

!MATERIAL, NAME=&lt;name&gt; \[, optional parameter\]

  Parameter   
  ----------- -------------------------------------------------------------------------
  NAME        Material name (mandatory)
  ITEM        Number of physical property items (omissible, becomes "1" when omitted)
  INPUT       External file name (omissible)

  Parameter Name   Parameter Value    Contents
  ---------------- ------------------ --------------------------------------------------------------------------------------
  NAME             &lt;name&gt;       Material name
  ITEM             &lt;ITEMnum&gt;    Number of physical property items by user definition
  INPUT            &lt;filename&gt;   External file name (omissible), can also be used together with the 2nd line or later

2nd Line or later {#nd-line-or-later-5 .afff5}

(2nd Line) !ITEM=1, SUBITEM=&lt;k&gt;

(3rd Line) VAL1-1-1, VAL1-1-2, … VAL1-1-k, TEMP1-1

(4th Line) VAL1-2-1，VAL1-2-2, … VAL1-2-k, TEMP1-2

・・

(L+2nd Line) VAL1-L-1，VAL1-L-2, … VAL1-L-k, TEMP1-L

Hereinafter, the definition is repeated until "!ITEM=&lt;ITEMnum&gt;".

  Subparameter (for "!ITEM")   
  ---------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
  SUBITEM                      Number of sub physical property items defined in each of the physical property items (omissible, becomes "1" when omitted, used to define anisotropy and etc.)

  Subparameter Name   Parameter Value      Contents
  ------------------- -------------------- ----------------------------------------------------------
  SUBITEM             &lt;subITEMnum&gt;   Number of sub physical property items by user definition

\[When the m-th physical property depends on the temperature\] {#when-the-m-th-physical-property-depends-on-the-temperature .afff5}

When the number of items of the temperature dependent table is N, input
as follows:

!ITEM=m, SUBITEM=k

VALm1-1, ..., VALm1-k, TEMPm1

VALm2-1, ..., VALm2-k, TEMPm2

...

VALmN-1, ..., VALmN-k, TEMPm-N

  Parameter Name   Attributions   Contents
  ---------------- -------------- -------------------------------------------------
  VALmn-k          R              Physical property value (Temperature dependent)
  TEMPmn           R              Compatible temperature

Must be input as TEMPm1 &lt; TEMPm2 &lt; ... &lt; TEMPmN.

VALm1 is used when the temperature is TEMPm1 or below, and VALmN is used
when the temperature is TEMPmN or more.

\[When the m-th physical property does not depend on the temperature\] {#when-the-m-th-physical-property-does-not-depend-on-the-temperature .afff5}

!ITEM=m, SUBITEM=k

VALm1-1, ..., VALm1-k

VALm2-1, ..., VALm2-k

...

VALmN-1, ..., VALmN-k

  Parameter Name   Attributions   Contents
  ---------------- -------------- -----------------------------------------------------
  VALmn-k          R              Physical property value (not temperature dependent)

Note: {#note-5 .afff5}

-   When the material name is duplicated, an error will occur.

-   When the MATERIAL referred to in the "!SECTION" option is not
    defined, an error will occur.

-   The value used to input the physical property for each element using
    the parameter "MATITEM" in the "!ELEMENT" option, is
    used preferentially. In this case, the physical property value input
    using the "!MATERIAL" option will not be used.

-   When the number of "!ITEM=m" suboptions and the number of parameters
    "ITEM" is not consistent, or when there is an undefined suboption,
    and error will occur.

-   The "!ITEM=m" suboption does not have to be in order from the
    smaller m.

-   When using the "!SUBITEM=k" suboption and the temperature
    dependency, the omitted value will become "0.0".

-   When using the temperature dependency, it must be defined in order
    from the lower temperature.

-   When using the temperature dependency, if the same temperature is
    used twice or more, an error will occur.

Example of Use {#example-of-use-5 .afff5}

!MATERIAL, NAME= STEEL, ITEM= 2

!ITEM=1 No temperature dependency

35.0

!ITEM=2

40.0, 0.0

45.0, 100.0

50.0, 200.0

!MATERIAL, NAME= CUPPER Number of items = 1 (Default value)

!ITEM=1 No temperature dependency

80.0

Incorrect Example of Use {#incorrect-example-of-use .afff5}

Example 1: \[Number of parameter "ITEM" and "!ITEM=m" suboptions are not
consistent -1\]

!MATERIAL, NAME= STEEL, ITEM= 2

!ITEM=3

20.0

!ITEM=1

35.0

!ITEM= 2

40.0

Example 2: \[Number of parameter "ITEM" and "!ITEM=m" suboptions are not
consistent -2\]

!MATERIAL, NAME= STEEL, ITEM= 3

!ITEM=3

20.0

!ITEM= 2

40.0

!MATERIAL, NAME= CUPPER

...

Elastic Static Analysis and Eigenvalue Analysis {#elastic-static-analysis-and-eigenvalue-analysis .afff5}

!MATERIAL, NAME=&lt;name&gt;, ITEM=&lt;ITEMnum&gt;

!ITEM=1, SUBITEM=2

&lt;Yang\_modulus&gt;, &lt;Poisson\_ratio&gt;

!ITEM=2

&lt;Density&gt;

!ITEM=3

&lt;Expansion\_coeff&gt;

  ------------------------------------------------------------------------------------------------------------------
  Parameter Name   Parameter Value   Contents
  ---------------- ----------------- -------------------------------------------------------------------------------
  NAME             &lt;name&gt;      Compatible to material name, and MATERIAL of !SECTION

  ITEM             &lt;ITEMnum&gt;   Number of physical property items by user definition (1 or more)

                                     &lt;Yang\_modulus&gt; ... Young's modulus (mandatory)

                                     &lt;Poisson\_ratio&gt; ... Poisson's ratio (mandatory)

                                     &lt;Density&gt; ... Mass density (mandatory when ITEMnum=3)

                                     &lt;Expansion\_coeff&gt; ... Coefficient of linear expansion (when ITEMnum=3)
  ------------------------------------------------------------------------------------------------------------------

(Example)

> !MATERIAL, NAME=M1, ITEM=3　　　---　 Intention of defining three
> types of property values in the material of material name M1
>
> !ITEM=1, SUBITEM=2 ---　 The Young's modulus and Poisson's ratio is
> defined in !ITEM=1 (mandatory)

4000., 0.3

> !ITEM=2　　　　　　　　---　 The mass density must be defined in
> !ITEM=2 (mandatory in the case of ITEM=3)

8.0102E‐10

> !ITEM=3 ---　 The coefficient of linear expansion must be defined in
> !ITEM=3

1.0E‐5　

Heat Conduction Analysis {#heat-conduction-analysis-2 .afff5}

In the case of link, plane surface, solid and three-dimensional plate
elements

!MATERIAL, NAME=&lt;name&gt;, ITEM=3

!ITEM=1, SUBITEM=2

&lt;Density&gt;, &lt;Temperature&gt;

!ITEM=2, SUBITEM=2

&lt;Specific\_heat&gt;, &lt;Temperature&gt;

!ITEM=3, SUBITEM=2

&lt;Conductivity&gt;, &lt;Temperature&gt;

  --------------------------------------------------------------------------------------------------------
  Parameter Name   Parameter Value   Contents
  ---------------- ----------------- ---------------------------------------------------------------------
  NAME             &lt;name&gt;      Compatible to material name, and MATERIAL of !SECTION

  ITEM             &lt;ITEMnum&gt;   Number of physical property items by user definition (**always 3**)

                                     &lt;Density&gt; ... Density

                                     &lt;Specific\_heat&gt; ... Specific heat

                                     &lt;Conductivity&gt; ... Thermal conductivity

                                     &lt;Temperature&gt; ... Temperature
  --------------------------------------------------------------------------------------------------------

(Example)

> !MATERIAL, NAME=M1, ITEM=3　　　---　 Intention of defining three
> types of property values in the material of material name M1
>
> !ITEM=1, SUBITEM=１　 　 ---　 The density and temperature are defined
> in !ITEM=1 (mandatory)

7850., 300.

7790., 500.

7700., 800.

> !ITEM=2, SUBITEM=1 ---　 The specific heat and temperature are defined
> in !ITEM=2 (mandatory)

0.465, 300.

0.528, 500.

0.622, 800.

> !ITEM=3 ---　 The thermal conductivity and temperature are defined in
> !ITEM=3 (mandatory)

43., 300.

38.6, 500.

27.7, 800.

In the case of interface element

Defined in the !SECTION header. (Material data is not required)

(Example)

!SECTION, TYPE=INTERFACE, EGRP=GAP　 ---　 Definition of section

1.0, 20.15, 8.99835E-9, 8.99835E-9

In the above !SECTION, the gap parameter of the element belonging to the
"group name = GAP" in the interface element is defined.

1st parameter : Gap width

2nd parameter : Gap heat transfer coefficient

3rd parameter : Gap radiation factor 1

4th parameter : Gap radiation factor 2

Reference {#reference .afff5}

program TEST

use hecmw

implicit REAL\*8 (A-H,O-Z)

type (hecmwT\_local\_mesh) :: hecMESH

!C

!C !MATERIAL, NAME=SUS304, ITEM=3

!C !ITEM=1, SUBITEM= 3

!C 100.0, 200.0, 300.0, 0.00

!C 101.0, 210.0, 301.0, 1.00

!C 102.0, 220.0, 302.0, 2.00

!C 103.0, 230.0, 303.0, 3.00

!C !ITEM=3, SUBITEM= 2

!C 1000.0, , 0.00

!C 1001.0, 1., 1.00

!C 1002.0, 2., 2.00

!C 1003.0, 3., 3.00

!C !ITEM=2

!C 5000.0

!C

!C !MATERIAL, NAME=FEC, ITEM=2

!C !ITEM=1, SUBITEM= 3

!C 2100.0, 2200.0, 2300.0, 0.00

!C 2101.0, 2210.0, 2301.0, 1.00

!C 2102.0, 2220.0, 2302.0, 2.00

!C 2103.0, 2230.0, 2303.0, 3.00

!C 3103.0, 3230.0, 2304.0, 4.00

!C !ITEM=2

!C 6000.0, 10.0

!C 6500.0, 30.0

!C

hecMESH%material%n\_mat = 2

nn= hecMESH%material%n\_mat

allocate (hecMESH%material%mat\_name(nn))

hecMESH%material%mat\_name(1)= 'SUS304'

hecMESH%material%mat\_name(2)= 'FEC'

nn= hecMESH%material%n\_mat

allocate (hecMESH%material%mat\_ITEM\_index(0:nn))

hecMESH%material%mat\_ITEM\_index(0)= 0

hecMESH%material%mat\_ITEM\_index(1)= 3

hecMESH%material%mat\_ITEM\_index(2)=
hecMESH%material%mat\_ITEM\_index(1) + 2

hecMESH%material%n\_mat\_ITEM=
hecMESH%material%mat\_ITEM\_index(hecMESH%material%n\_mat)

nn= hecMESH%material%n\_mat\_ITEM

allocate (hecMESH%material%mat\_subITEM\_index(0:nn))

hecMESH%material%mat\_subITEM\_index(0)= 0

hecMESH%material%mat\_subITEM\_index(1)= 3

hecMESH%material%mat\_subITEM\_index(2)=
hecMESH%material%mat\_subITEM\_index(1) + 1

hecMESH%material%mat\_subITEM\_index(3)=
hecMESH%material%mat\_subITEM\_index(2) + 2

hecMESH%material%mat\_subITEM\_index(4)=
hecMESH%material%mat\_subITEM\_index(3) + 3

hecMESH%material%mat\_subITEM\_index(5)=
hecMESH%material%mat\_subITEM\_index(4) + 1

hecMESH%material%n\_mat\_subITEM=

& hecMESH%material%mat\_subITEM\_index(hecMESH%material%n\_mat\_ITEM)

nn= hecMESH%material%n\_mat\_subITEM

allocate (hecMESH%material%mat\_TABLE\_index(0:nn))

hecMESH%material%mat\_TABLE\_index( 0)= 0

hecMESH%material%mat\_TABLE\_index( 1)= 4

hecMESH%material%mat\_TABLE\_index( 2)=
hecMESH%material%mat\_TABLE\_index( 1) + 4

hecMESH%material%mat\_TABLE\_index( 3)=
hecMESH%material%mat\_TABLE\_index( 2) + 4

hecMESH%material%mat\_TABLE\_index( 4)=
hecMESH%material%mat\_TABLE\_index( 3) + 1

hecMESH%material%mat\_TABLE\_index( 5)=
hecMESH%material%mat\_TABLE\_index( 4) + 4

hecMESH%material%mat\_TABLE\_index( 6)=
hecMESH%material%mat\_TABLE\_index( 5) + 4

hecMESH%material%mat\_TABLE\_index( 7)=
hecMESH%material%mat\_TABLE\_index( 6) + 5

hecMESH%material%mat\_TABLE\_index( 8)=
hecMESH%material%mat\_TABLE\_index( 7) + 5

hecMESH%material%mat\_TABLE\_index( 9)=
hecMESH%material%mat\_TABLE\_index( 8) + 5

hecMESH%material%mat\_TABLE\_index(10)=
hecMESH%material%mat\_TABLE\_index( 9) + 2

hecMESH%material%n\_mat\_TABLE=

& hecMESH%material%mat\_TABLE\_index(hecMESH%material%n\_mat\_subITEM)

nn= hecMESH%material%n\_mat\_TABLE

allocate (hecMESH%material%mat\_VAL (nn))

allocate (hecMESH%material%mat\_TEMP(nn))

hecMESH%material%mat\_VAL = 0.d0

hecMESH%material%mat\_TEMP= 0.d0

hecMESH%material%mat\_VAL ( 1)= 100.0d0

hecMESH%material%mat\_TEMP( 1)= 0.0d0

hecMESH%material%mat\_VAL ( 2)= 101.0d0

hecMESH%material%mat\_TEMP( 2)= 1.0d0

hecMESH%material%mat\_VAL ( 3)= 102.0d0

hecMESH%material%mat\_TEMP( 3)= 2.0d0

hecMESH%material%mat\_VAL ( 4)= 103.0d0

hecMESH%material%mat\_TEMP( 4)= 3.0d0

hecMESH%material%mat\_VAL ( 5)= 200.0d0

hecMESH%material%mat\_TEMP( 5)= 0.0d0

hecMESH%material%mat\_VAL (13)= 5000.0d0

hecMESH%material%mat\_VAL (14)= 1000.0d0

hecMESH%material%mat\_TEMP (14)= 0.0d0

hecMESH%material%mat\_VAL (15)= 1001.0d0

hecMESH%material%mat\_TEMP (15)= 1.0d0

hecMESH%material%mat\_VAL (16)= 1002.0d0

hecMESH%material%mat\_TEMP (16)= 2.0d0

hecMESH%material%mat\_VAL (17)= 1003.0d0

hecMESH%material%mat\_TEMP (17)= 3.0d0

hecMESH%material%mat\_VAL (18)= 0.0d0

hecMESH%material%mat\_TEMP (18)= 0.0d0

hecMESH%material%mat\_VAL (19)= 1.0d0

hecMESH%material%mat\_TEMP (19)= 1.0d0

hecMESH%material%mat\_VAL (20)= 2.0d0

hecMESH%material%mat\_TEMP (20)= 2.0d0

hecMESH%material%mat\_VAL (21)= 3.0d0

hecMESH%material%mat\_TEMP (21)= 3.0d0

hecMESH%material%mat\_VAL (22)= 2100.0d0

hecMESH%material%mat\_TEMP (22)= 0.0d0

hecMESH%material%mat\_VAL (23)= 2101.0d0

hecMESH%material%mat\_TEMP (23)= 1.0d0

hecMESH%material%mat\_VAL (24)= 2102.0d0

hecMESH%material%mat\_TEMP (24)= 2.0d0

hecMESH%material%mat\_VAL (25)= 2103.0d0

hecMESH%material%mat\_TEMP (25)= 3.0d0

hecMESH%material%mat\_VAL (26)= 3103.0d0

hecMESH%material%mat\_TEMP (26)= 4.0d0

write (\*,'(a,i10)') '%n\_mat\_ITEM ', hecMESH%material%n\_mat\_ITEM

write (\*,'(a,i10)') '%n\_mat\_subITEM',
hecMESH%material%n\_mat\_subITEM

write (\*,'(a,i10)') '%n\_mat\_TABLE ', hecMESH%material%n\_mat\_TABLE

end program TEST

##### \
!NGROUP (M1-8)

Definition of node group

1st Line {#st-line-7 .afff5}

!NGROUP, NGRP=&lt;ngrp&gt; \[, optional parameter\]

  Parameter   
  ----------- -----------------------------------------------------------------------
  NGRP        Node group name (mandatory)
  GENERATE    Automatic generation of nodes belonging to the node group (omissible)
  INPUT       External file name (omissible)

  Parameter Name   Parameter Value    Contents
  ---------------- ------------------ --------------------------------------------------------------------------------------
  NGRP             &lt;ngrp&gt;       Node group name
  GENERATE         N/A                Automatic generation of nodes belonging to the node group
  INPUT            &lt;filename&gt;   External file name (omissible), can also be used together with the 2nd line or later

2nd Line or later (when GENERATE is not used) {#nd-line-or-later-when-generate-is-not-used-1 .afff5}

(2nd Line) nod1, nod2, nod3

(Hereinafter the same)

  Parameter Name   Attributions   Contents
  ---------------- -------------- -----------------------------------------
  nodX             I              Node number belonging to the node group

2nd Line or later (when GENERATE is used) {#nd-line-or-later-when-generate-is-used-1 .afff5}

(2nd Line) nod1, nod2, nod3

(Hereinafter the same)

  Parameter Name   Attributions   Contents
  ---------------- -------------- -----------------------------------------------------------------------
  nod1             I              First node number in the node group
  nod2             I              Last node number in the node group
  nod3             I              Node number increment (omissible, number becomes nod3=1 when omitted)

Note: {#note-6 .afff5}

-   Any number of nodes can be inserted in one line. Any number of lines
    can be inserted until the next option starts.

-   It is necessary to define the nodes to be specified
    before "!NGROUP".

-   The node not defined in the "!NODE" option will be excluded, and a
    warning message will be displayed.

-   When the specified node exists in the same group, it will be ignored
    and a warning message will be displayed.

-   All the nodes belong to the node group named "ALL"
    (generated automatically).

-   One group can be defined by dividing into multiple groups.

Example of Use {#example-of-use-6 .afff5}

!NGROUP, NGRP= NA01

1, 2, 3, 4, 5, 6

101, 102

!NGROUP, NGRP= NA02

101, 102

!NGROUP, NGRP= NA01 "501 and 505" are added to group "NA01".

501, 505

!NGROUP, NGRP= NA02 "501 and 505" are added to group "NA02".

501, 505

!NGROUP, NGRP= NA04,GENERATE "301, 303, 305, 307, 309, 311, 312, 313"
are added to

301, 309, 2 group "NA04".

311, 313

##### \
!NODE (M1-9)

Definition of node coordinates

1st Line {#st-line-8 .afff5}

!NODE \[, optional parameter\]

  Parameter   
  ----------- --------------------------------
  SYSTEM      Coordinate system (omissible)
  NGRP        Node group name (omissible)
  INPUT       External file name (omissible)

  Parameter Name   Parameter Value    Contents
  ---------------- ------------------ --------------------------------------------------------------------------------------
  SYSTEM           R                  Cartesian coordinate system (Default value)
                   C                  Cylindrical coordinate system
  NGRP             &lt;ngrp&gt;       Node group name (omissible)
  INPUT            &lt;filename&gt;   External file name (omissible), can also be used together with the 2nd line or later

2nd Line or later {#nd-line-or-later-6 .afff5}

(2nd Line) NODE\_ID, Xcoord, Ycoord, Zcoord

(Hereinafter the same)

  Parameter Name   Attributions   Contents
  ---------------- -------------- --------------
  NODE\_ID         I              Node number
  Xcoord           R              X coordinate
  Ycoord           R              Y coordinate
  Zcoord           R              Z coordinate

Note: {#note-7 .afff5}

-   When node coordinates including the punctuation mark is omitted, the
    value will become "0.0".

-   When an already defined node is redefined, the contents will be
    updated and a warning message will be displayed.

-   The node which is not referred to in "!ELEMENT" will be excluded.

-   The node defined in "!ELEMENT" must be defined before "!ELEMENT".

Example of Use {#example-of-use-7 .afff5}

!NODE, NGRP=TEST

1, 0.0, 0.0, 0.5

2, 0.0, 0.0, 1.0

3, 0.0,,1.5 Y coordinate is "0.0"

4, X, Y and Z coordinates are "0.0"

##### \
!SECTION (M1-10)

Definition of section

1st Line {#st-line-9 .afff5}

!SECTION, TYPE=&lt;type&gt;, EGRP=&lt;egrp&gt; \[, optional parameter\]

  Parameter   
  ----------- -------------------------------------------------------------------------------
  TYPE        Section type (mandatory)
  EGRP        Element group name (mandatory)
  MATERIAL    User defined material name (mandatory)
  SECOPT      Auxiliary parameter for the element type (omissible, becomes =0 when omitted)
  INPUT       External file name (omissible)

  Parameter Name   Parameter Value     Contents
  ---------------- ------------------- --------------------------------------------------------------------------------------
  TYPE             SOLID               Rod, triangular, quadrilateral, tetrahedral, pentahedral, hexadedral elements
                   SHELL               Shell element
                   BEAM                Beam element
                   INTERFACE           Interface element
  EGRP             &lt;egrp&gt;        Element group name
  MATERIAL         &lt;material &gt;   Material name defined by user
  SECOPT           &lt;secopt&gt;      = 0: Not specified, plane stress
                                       = 1: Plane strain
                                       = 2: Axial symmetry
                                       = 10: 0 + reduced integration
                                       = 11: 1 + reduced integration
                                       = 12: 2 + reduced integration
  INPUT            &lt;filename&gt;    External file name (omissible), can also be used together with the 2nd line or later

2nd Line or later {#nd-line-or-later-7 .afff5}

In the case of \[TYPE=SOLID\] {#in-the-case-of-typesolid .afff5}

(2nd Line) THICKNESS

  Parameter Name   Attributions   Contents
  ---------------- -------------- -----------------------------------------
  THICKNESS        R              Element thickness, cross-sectional area

In the case of "TYPE=SOLID", the "THICKNESS" can be omitted, and default
value (1.0) is inserted.

In the case of \[TYPE=SHELL\] {#in-the-case-of-typeshell .afff5}

(2nd Line) THICKNESS, INTEGPOINTS

  Parameter Name   Attributions   Contents
  ---------------- -------------- ---------------------------------------------------
  THICKNESS        R              Shell cross section thickness
  INTEGPOINTS      I              Integral point in shell cross sectional direction

In the case of \[TYPE=BEAM\] {#in-the-case-of-typebeam .afff5}

(2nd Line) vx,vy,vz,area,Iyy,Iz,Jx

  Parameter Name   Attributions   Contents
  ---------------- -------------- ------------------------------------
  vx,vy,vz         R              Direction cosine of reference axis
  area             R              Area of cross section
  Iyy, Izz         R              Second moment of cross section
  Jx               R              Torsion constant of cross section

In the case of \[TYPE=INTERFACE\] {#in-the-case-of-typeinterface .afff5}

(2nd Line) THICKNESS, GAPCON, GAPRAD1, GAPRAD2

  Parameter Name   Attributions   Contents
  ---------------- -------------- -----------------------------------------------------
  THICKNESS        R              Cross-sectional thickness
  GAPCON           R              Gap heat transfer coefficient (0 when omitted)
  GAPRAD1          R              Gap radiant heat transfer factor-1 (0 when omitted)
  GAPRAD2          R              Gap radiant heat transfer factor-2 (0 when omitted)

Note: {#note-8 .afff5}

-   When the parameter "TYPE" is not consistent with the element type,
    an error will occur.

-   When there is an element without SECTION information, an error
    will occur.

-   When the section name is duplicated, an error will occur.

Example of Use {#example-of-use-8 .afff5}

!SECTION, EGRP=SOLID1, TYPE=SOLID, MATERIAL=STEEL

!SECTION, EGRP=SHELL2, TYPE=SHELL, MATERIAL=STEEL

1.0, 5

##### !SGROUP (M1-11)

Definition of surface group

1st Line {#st-line-10 .afff5}

!SGROUP, SGRP=&lt;sgrp&gt; \[, optional parameter\]

  Parameter   
  ----------- --------------------------------
  SGRP        Surface group name (mandatory)
  INPUT       External file name (omissible)

  Parameter Name   Parameter Value    Contents
  ---------------- ------------------ --------------------------------------------------------------------------------------
  SGRP             &lt;sgrp&gt;       Surface group name
  INPUT            &lt;filename&gt;   External file name (omissible), can also be used together with the 2nd line or later

2nd Line or later {#nd-line-or-later-8 .afff5}

(2nd Line) elem1, lsuf1, elem2, lsuf2, elem3, lsuf3, ...

(Hereinafter the same)

  Parameter Name   Attributions   Contents
  ---------------- -------------- --------------------------------------------------------------------
  elemX            I              Element number belonging to the surface group
  lsufX            I              Local surface number of the element belonging to the surface group

Note: {#note-9 .afff5}

-   For the element type and surface number, refer to "Chapter 4
    Element Library".

-   The surface consists of a combination of (elements and local
    surface numbers). Any number of surfaces can be inserted in
    one line. Any number of lines can be inserted until the next
    option starts. The combination of (elements and local
    surface numbers) must be in the same line.

-   It is necessary to define the element to be specified
    before "!SGROUP".

-   The element not defined in "!ELEMENT" option will be excluded, and a
    warning message will be displayed.

-   The surface which includes the element not defined in "!ELEMENT"
    option will be excluded, and a warning message will be displayed.

-   The surface where the element type and the surface number are not
    consistent will be excluded, and a warning message will
    be displayed.

-   One group can be defined by dividing into multiple groups.

Example of Use {#example-of-use-9 .afff5}

!SGROUP, SGRP= SUF01

101, 1, 102, 1, 103, 2, 104, 2

201, 1, 202, 1

501, 1

!SGROUP, SGRP= SUF02

101, 2, 102, 2

!SGROUP, SGRP= EA01 "(601,1) and (602 2)" are added to group "SUF01".

601, 1

602, 2

Incorrect Example of Use {#incorrect-example-of-use-1 .afff5}

Example 1: \[When (elements, and local surface numbers) group exists in
multiple lines\]

!SGROUP, SGRP= SUF01

101, 1, 102, 1, 103

1, 104, 1

Example 2: \[Local surface numbers and element type are not consistent\]

!ELEMENT, TYPE= 211, SECTION= A

101, 1, 2, 3

102, 2, 3, 4

...

!SGROUP, SGRP= SUF01

101, 1

101, 2

101, 4 Since a 4th surface does not exist in a triangular element, this
combination

will be disregarded.

##### !ZERO (M1-12)

Absolute zero-point

1st Line {#st-line-11 .afff5}

!ZERO

Parameter

N/A

2nd Line or later {#nd-line-or-later-9 .afff5}

(2nd Line) ZERO

  Parameter Name   Attributions   Contents
  ---------------- -------------- ---------------------
  ZERO             R              Absolute zero-point

Note: {#note-10 .afff5}

-   Omissible. Becomes "absolute zero-point = 0" when omitted.

-   When "!ZERO" is defined multiple times, the contents will be updated
    and a warning message will be displayed.

Example of Use {#example-of-use-10 .afff5}

!ZERO

-273.16

##### !CONTACT PAIR　(M1-13)

Definition of contact surface pair used for contact analysis

1st Line {#st-line-12 .afff5}

!CONTACT PAIR, NAME=&lt;name&gt; \[,optional parameter\]

  Parameter   
  ----------- -------------------------------
  NAME        Contact pair name (mandatory)
  TYPE        Type (omissible)

  ----------------------------------------------------------------------------------------------------
  Parameter Name   Parameter Value   Contents
  ---------------- ----------------- -----------------------------------------------------------------
  NAME             &lt;name&gt;      Contact pair name

  TYPE             NODE-SURF         Slave surface is the node group

                                     Master surface is the surface group (default)

                   SURF-SURF         Both the slave surface and master surface are the surface group
  ----------------------------------------------------------------------------------------------------

2nd Line or later {#nd-line-or-later-10 .afff5}

(2nd Line or later) SLAVE\_GRP, MASTER\_GRP

(Hereinafter the same)

  Parameter Name   Attributions   Contents
  ---------------- -------------- ------------------------------------------
  SLAVE\_GRP       C              Slave surface node / surface group name
  MASTER\_GRP      C              Surface group name of the master surface

##### !END （M1-14）

End of mesh data

When this header is displayed, the reading of the mesh data is
completed.

1st Line {#st-line-13 .afff5}

!END

Parameter

N/A

2nd Line or later {#nd-line-or-later-11 .afff5}

N/A
