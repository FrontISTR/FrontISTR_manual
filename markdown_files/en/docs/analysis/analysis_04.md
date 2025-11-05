## Single Domain Mesh Data

Individual header descriptions have been moved to the [new manual](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/index.html).
Only overviews and data definition examples are provided here.

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
| [`!AMPLITUDE`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/amplitude.html)      | Unsteady load         | M1-1            |
| [`!EGROUP`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/egroup.html)            | Element group         | M1-2            |
| [`!ELEMENT`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/element.html)          | Element information   | M1-3            |
| [`!EQUATION`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/equation.html)        | Restricted point data | M1-4            |
| [`!HEADER`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/header.html)            | Title of mesh data    | M1-5            |
| [`!MATERIAL`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/material.html)        | Material information  | M1-6            |
| [`!NGROUP`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/ngroup.html)            | Node group            | M1-7            |
| [`!NODE`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/node.html)                | Node information      | M1-8            |
| [`!SECTION`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/section.html)          | Section information   | M1-9            |
| [`!SGROUP`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/sgroup.html)            | Surface group         | M1-10           |
| [`!ZERO`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/zero.html)                | Absolute zero-point   | M1-11           |
| [`!CONTACT PAIR`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/contactpair.html) | Contact surface pair  | M1-12           |
| [`!END`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/msh/end.html)                  | Read end              | M1-13           |

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
