## Overall Control Data

### Outline of Overall Control Data

The overall control data is for defining the file name of the input/output files for FrontISTR.  The features of the overall control data file are as follows.

  - This is an ASCII format file based on a free format.
  - This file consists of a header which starts with "`!`" and the data following this.
  - The order of description of the header is basically free.
  - A "`,`" is used as a punctuation mark of the data.

### Input Rules

The overall control data file consists of a header line, data line and a comment line. One header is always included in the header line.

Header
:    The meaning of the data and data block is specified in the overall control data file.
:    When the head of the term starts with a "`!`", it is considered to be a header.

Header Line
:    The header and the parameter accompanying this are described in this line.
:    The header line must start with a header.
:    When a parameter is required, a "`,`" must be used to continue after that.
:    When the parameter takes on a value, use an "`=`" after the parameter and describe the value after that.

Data Line
:    The data line starts from the next line of the header line, and the necessary data is described.
:    The data lines may be in multiple lines; however, this is determined according to the rules of the data description defined by each header.
:    There are cases where data lines are not required.

Punctuation
:    A comma "`,`" is used as a punctuation of the data.

Handling of Blanks
:    Blanks are disregarded.

Name
:    Regarding the characters which can be used for the name, there is the underscore "`_`", hyphen "`-`", and alphanumeric characters "`a - z, A - Z, 0 - 9`"; however, the first letter of the name must start with "`_`", or an alphabetic character "`a - z, A - Z`".
:    There is no distinction between uppercase and lowercase letters, and all letters are internally handled as uppercase letters.
:    The maximum length of the name is 63 characters.

File Name
:    Regarding the characters which can be used for the file name, there are the underscore "`_`", hyphen "`-`", period "`.`", slash "`/`", and the alphanumeric characters "`a - z, A - Z, 0 - 9`".
:    As long as there is no specific description, a path can be included in the file name. Both the relative path and the absolute path can be specified.
:    The maximum length of the file name is 1,023 characters.

Floating Point Data
:    Exponents are optional. An "`E`" or "`e`" character must be added before the exponent.
:    The selection of "`E`" or "`e`" is optional. "`D`" or "`d`" can not be used.

!!, # Comment Line
:    Lines starting with "`!!`" or "`#`" are considered to be comment lines, and are disregarded. A comment line can be inserted in any position in the file, and there are no restrictions on the number of lines.

### Header List

The overall control data consists of the following headers.

| Header Name | Contents                         |
|:------------|:---------------------------------|
| [`!CONTROL`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/dat/control.html)  | Analysis control data definition |
| [`!MESH`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/dat/mesh.html)        | Mesh data definition             |
| [`!RESTART`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/dat/restart.html)  | Restart data definition          |
| [`!RESULT`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/dat/result.html)    | Analysis results data definition |
| [`!SUBDIR`](https://frontistr-commons.gitlab.io/frontistr_documents/en/keyword_reference/dat/subdir.html)    | Dividing to sub directories      |
