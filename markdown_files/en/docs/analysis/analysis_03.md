
# Overall Control Data

## Outline of Overall Control Data

The overall control data is for defining the file name of the input/output files for FrontISTR.  The features of the overall control data file are as follows.

  - This is an ASCII format file based on a free format.
  - This file consists of a header which starts with "`!`" and the data following this.
  - The order of description of the header is basically free.
  - A "`,`" is used as a punctuation mark of the data.

## Input Rules

The overall control data file consists of a header line, data line and a comment line. One header is always included in the header line.

### Header

The meaning of the data and data block is specified in the overall control data file.

When the head of the term starts with a "`!`", it is considered to be a header.

### Header Line

The header and the parameter accompanying this are described in this line.

The header line must start with a header.

When a parameter is required, a "`,`" must be used to continue after that.

When the parameter takes on a value, use an "`=`" after the parameter and describe the value after that.

### Data Line

The data line starts from the next line of the header line, and the necessary data is described.

The data lines may be in multiple lines; however, this is determined according to the rules of the data description defined by each header.

There are cases where data lines are not required.

### Punctuation

A comma "`,`" is used as a punctuation of the data.

### Handling of Blanks

Blanks are disregarded.

### Name

Regarding the characters which can be used for the name, there is the underscore "`_`", hyphen "`-`", and alphanumeric characters "`a - z, A - Z, 0 - 9`"; however, the first letter of the name must start with "`_`", or an alphabetic character "`a - z, A - Z`".

There is no distinction between uppercase and lowercase letters, and all letters are internally handled as uppercase letters.

The maximum length of the name is 63 characters.

### File Name

Regarding the characters which can be used for the file name, there are the underscore "`_`", hyphen "`-`", period "`.`", slash "`/`", and the alphanumeric characters "`a - z, A - Z, 0 - 9`".

As long as there is no specific description, a path can be included in the file name. Both the relative path and the absolute path can be specified.

The maximum length of the file name is 1,023 characters.

### Floating Point Data

Exponents are optional. An "`E`" or "`e`" character must be added before the exponent.

The selection of "`E`" or "`e`" is optional. "`D`" or "`d`" can not be used.

### `!!`, `#` Comment Line

Lines starting with "`!!`" or "`#`" are considered to be comment lines, and are disregarded. A comment line can be inserted in any position in the file, and there are no restrictions on the number of lines.

## Header List

The overall control data consists of the following headers.

|Header Name |Contents                        |
|:-----------|:-------------------------------|
|`!CONTROL`  |Analysis control data definition|
|`!MESH`     |Mesh data definition            |
|`!RESTART`  |Restart data definition         |
|`!RESULT`   |Analysis results data definition|
|`!SUBDIR`   |Dividing to sub directories     |

In each header, there are data items which are compatible to the parameter and each header. Each of the above headers is described in the following with examples of data creation.

### (1) `!CONTROL`

Specifies the analysis control data file.

#### 1st Line

```
!CONTROL,NAME=<name>
```

|Parameter  |                      |
|:----------|:---------------------|
|`NAME`     |Identifier (mandatory)|

|Parameter Name|Parameter Value|Contents             |
|:-------------|:--------------|:--------------------|
| `NAME`       |`fstrCNT`      |Analysis control data|

#### 2nd Line or later

```
(2nd Line) file
```

|Parameter Name |Contents|
|:--------------|:-------|
| file          |Analysis control data file name (both the relative path and the absolute path can be specified. When the relative path is specified, it becomes the path from the current directory.)|

#### Example of Use

```
!CONTROL, NAME=fstrCNT
  myctrl.dat
```

### (2) `!MESH`

Specifies the mesh data file.

#### 1st Line

```
!MESH, NAME=<name>, TYPE=<type> [,optional parameter]
```

|Parameter   |                                           |
|:-----------|:------------------------------------------|
| `NAME`     |Identifier (mandatory)                     |
| `TYPE`     |Mesh type (mandatory)                      |
| `IO`       |Input/output specification (omissible)     |
| `REFINE`   |Mesh subdivision specification (arbitrary) |

|Parameter Name |Parameter Value  |Contents                      |
|:--------------|:----------------|:-----------------------------|
| `NAME`        |`fstrMSH`        |Solver input data             |
|               |`part_in`        |Partitioner input data        |
|               |`part_out`       |Partitioner output data       |
| `TYPE`        |`HECMW-DIST`     |HEC-MW distribution mesh data |
|               |`HECMW-ENTIRE`   |HEC-MW single domain mesh data|
| `IO`          |`IN`             |For input (default)           |
|               |`OUT`            |For output                    |
| `REFINE`      |&lt;integer&gt;  |Number of mesh subdivisions   |

#### 2nd Line or later

```
(2nd Line) fileheader
```

|Parameter Name|Contents |
|:-------------|:---------------------------------------------------------------------|
| fileheader   |Header of the mesh data file name (both the relative path and the absolute path can be specified. When the relative path is specified, it becomes the path from the current directory.)|

> Note:
>
> The existence of IO parameters, or parameter values will have no affect on others. When the `TYPE` is `HECMW-DIST`, the end of the file name ".&lt;rank&gt;" is excluded for the file header specified in the data line.

#### Example of Use

```
!MESH, NAME=fstrMSH, TYPE=HECMW-DIST, REFINE=1
 Mesh.in
```

### (3) `!RESTART`

Specifies the restart data file.

#### 1st Line

```
!RESTART, NAME=<name>, IO=<io>
```

|Parameter|内容                                  |
|:--------|:-------------------------------------|
| `NAME`  |Identifier (mandatory)                |
| `IO`    |Input/output specification (mandatory)|

|Parameter Name|Parameter Value|Contents              |
|:-------------|:--------------|:---------------------|
|`NAME`        |&lt;name&gt;   |Identifier            |
|`IO`          |IN             |For input             |
|              |OUT            |For output            |
|              |INOUT          |Common to input/output|

#### 2nd Line or later

```
(2nd Line) fileheader
```

|Parameter Name|Contents|
|:-------------|--------|
|fileheader    |Header of the restart data file name (both the relative path and the absolute path can be specified. When the relative path is specified, it becomes the path from the current directory.)|

> Note:
>
> The file name created by this definition is the file header+.&lt;rank&gt;.

#### Example of Use

```
!RESTART, NAME=restart-in, IO=IN
 restart.in
```

### (4) `!RESULT`

Specifies the analysis results data file.

#### 1st Line

```
!RESULT, NAME=<name> [,optional parameter]
```

|Parameter|                                      |
|:--------|:-------------------------------------|
|`NAME`   |Identifier (mandatory)                |
|`IO`     |Input/output specification (mandatory)|
|`TYPE`   |Output format (omissible)             |

|Parameter Name|Parameter Value|Contents                                       |
|:-------------|:-------------|------------------------------------------------|
| `NAME`       |`fstrRES`     |Solver output data, Visualizer input data       |
|              |`fstrTEMP`    |Temperature input data (Result of heat analysis)|
|              |`vis_out`     |Visualizer output data                          |
| `IO`         |`IN`          |For input                                       |
|              |`OUT`         |For output                                      |
| `TYPE`       |`TEXT`        |Text format (default)                           |
|              |`BINARY`      |Binary format                                   |

#### 2nd Line or later

```
(2nd Line) fileheader
```

|Parameter Name|Contents |
|:-------------|:--------|
| fileheader   |Header of the analysis results data file name (both the relative path and the absolute path can be specified. When the relative path is specified, it becomes the path from the current directory.)|

> Note:
>
> The file name created by this definition is the file header+.&lt;rank&gt;.

#### Example of Use

```
!RESULT, NAME=fstrRES, IO=OUT, TYPE=BINARY
 result.out
```

### (5) `!SUBDIR`

Specifies storing input/output files into subdirectories

#### 1st Line

```
!SUBDIR, ON [,optional parameter]
```

|Parameter   |                           |
|:-----------|:--------------------------|
| `ON`       |Enable (mandatory)         |
| `LIMIT`    |Number of files (omissible)|

|Parameter Name|Parameter Value|Contents                                             |
|:-------------|:--------------|:----------------------------------------------------|
|`ON`          |N/A            |                                                     |
|`LIMIT`       |&lt;integer&gt;|Maximum number of files per directory (default:5000) |

#### 2nd Line or later

N/A

> Note:
>
> The input/output data which are comprised of plural files are automatically stored into each
subdirectory by this definition.
> Furthermore, if the number of ranks exceeds “`LIMIT`”, those files are divided to subdirectoris
such as TRUNK0, TRUNK1.

#### Example of Use

```
!SUBDIR, ON, LIMIT=8000
```



