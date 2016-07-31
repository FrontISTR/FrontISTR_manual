# Analysis Procedure

## Analysis by Sequential Processing

### Execution Flow

The execution flow by sequential processing of a single processor using
FrontISTR is shown in Figure 3.1.1.

Figure 3.1.1: Execution Flow by Sequential Processing

### Preparation of Input File

\(1) Overall control data (Ext. dat)

The input file and the analysis results output file of the mesh data and
analysis control data are specified in this file. The fixed file name is
hecmw\_ctrl.dat.

An example of the overall control data is shown in the following. In
this example, FrontSTR reads the single domain mesh data model.msh and
analysis control data model.cnt, and writes the analysis output data
model.res.0.1. Moreover, hecmw\_vis reads the single domain mesh data
model.msh and analysis results data model.res.0.1, and writes the
model\_vis\_psf.0000. (Ext.) corresponding to the specified output. For
details, refer to Chapter 5 of the User's Manual.

\(2) Single domain mesh data (Ext. msh)

The overall mesh configuration applicable for analysis, material data,
group data used in the analysis control data and etc., are defined in
this file. For details, refer to Chapter 6 of the User's Manual.

\(3) Analysis control data (Ext. cnt)

The analysis classification, displacement boundary conditions, load
boundary conditions and etc., are defined in this file. The solver
control data and the visualizer control data are also specified in this
file. An example of the analysis control data is shown in Chapter 3. For
details, refer to Chapter 7 of the User's Manual.

\(4) Visualization control data (Ext. ini)

The control data of hecmw\_vis is specified in this file. The default
file name is hecmw\_vis.ini. An example of the visualization control
data is shown in the following. In this example, an unstructured mesh
type data for MicroAVS (Ext. inp) is output. For details, refer to
Section 7.3.3 and Section 7.4.7 of the User's Manual.

### Execution Procedure

Execute FrontISTR with the following command line in the directory where
the input file is saved.

> \$ fistr1

Two methods can be used to execute the visualization. The first method
is used when executing as a post process of FrontISTR. By specifying
!WRITE, VISUAL in the analysis control data, the visualization will
automatically be executed. In this case, it is necessary to describe the
visualization control data included in the analysis control data.

When executing the visualization after the execution of FrontISTR is
completed, first specify !WRITE, RESULT in the analysis control data,
and then execute FrontISTR.

After the execution of FrontISTR is completed, execute hecmw\_vis by the
following command line in the directory where the input file and
analysis results file are saved.

> \$ hecmw\_vis1

### Description of Output File

\(1) Analysis results message file (Ext. msg)

Messages, such as the analysis progression process of FrontISTR will be
output in this file. One file will be created with one execution, and
the fixed file name is FSTR.msg.

\(2) Analysis results log file (Ext. log)

The physical quantity analysis results of each node and element of
FrontISTR will be output in this file. The analysis results of the
maximum, minimum and eigenvalues of the physical quantity will also be
output in this file. In the case of dynamic analysis, the analysis
results of all the steps will be output in this file. One file will be
created with one execution, and the fixed file name is 0.log.

\(3) Analysis results file (no Ext.)

The analysis results will be output in this file, when the !WRITE,
RESULT option is specified.

The physical quantity analysis results of each node and element of
FrontISTR will be output in this file. A file will be created for each
step, and the file will be named as follows using the file header
specified in the overall control data.

Naming rule: (File header specified by !RESUT).0. (Step No.)

> Example: model.res.0.1

\(4) Analysis results bitmap file (Ext. bmp)

The analysis results will be output in this file when specified in the
visualization control data.

The visualized bitmap data will be output in this file. The file will be
named using the file header specified in the overall control data. For
details on the naming rules, refer to the hecmw1 document
(0803\_001f\_hecmw\_PC\_cluster\_201\_vis.pdf).

\(5) Analysis results unstructured mesh type data file (Ext. inp)

The analysis results will be output in this file when specified in the
visualization control data.

The post process can be executed with REVOCAP\_PrePost, MicroAVS and
etc. using this file. The file will be named as follows, using the file
header specified in the overall control data.

Naming rule: (File header specified by !RESUT)\_psf.(Step No).inp

> Example: model\_vis\_psf.0000.inp

\(6) Analysis results neutral file (Ext. neu)

The analysis results will be output in this file when specified in the
visualization control data.

The post process can be executed with Femap using this file. The file
will be named as follows, using the file header specified in the overall
control data.

Naming rule: (File header specified by !RESUT)\_psf.(Step No.).neu

> Example: model\_vis\_psf.0000.neu

Note: In addition to the above, the FSTR.dbg file will be output;
however, since this is for debugging, it is normally not necessary to
refer to this file.

1.  ## Analysis by Parallel Processing

    1.  ### Execution Flow

The execution flow by parallel processing of a multiprocessor using
FrontISTR is shown in Figure 3.2.1.

Figure 3.2.1: Execution Flow by Parallel Processing

### Preparation of Input File

\(1) Overall control data (Ext. dat)

The input file and the analysis results output file of the mesh data and
analysis control data are specified in this file. The fixed file name is
hecmw\_ctrl.dat.

An example of the overall control data is shown in the following. In
this example, first, hecmw\_part reads the single domain mesh data
model.msh, and writes the distributed domain mesh data model\_8.0\~n.
FrontSTR reads the distributed domain mesh data model\_8.0\~n and the
analysis control data model.cnt, and writes the analysis results data
model.res.0\~n.1. Moreover, hecmw\_vis reads the distributed domain mesh
data model\_8.0\~n and the analysis results data model.res.0\~n.1, and
writes the model\_vis\_psf.0000. (Ext.) corresponding to the specified
output. For details, refer to Chapter 5 of the User's Manual.

\(2) Single domain mesh data (Ext. msh)

The overall mesh configuration applicable for analysis, material data,
group data used in the analysis control data and etc., are defined in
this file. For details, refer to Chapter 6 of the User's Manual.

\(3) Analysis control data (Ext. cnt)

The analysis classification, displacement boundary conditions, load
boundary conditions and etc., are defined in this file. The solver
control data and the visualizer control data are also specified in this
file. An example of the analysis control data is shown in Chapter 3. For
details, refer to Chapter 7 of the User's Manual.

\(4) Domain partitioning utility control data (Ext. dat)

The control data of hecmw\_part is specified in this file. The fixed
file name is hecmw\_part\_ctrl.dat. An example of the domain
partitioning utility control data is shown in the following. In this
example, a single domain is partitioned into 8 domains by the domain
decomposition method PMETIS. Moreover, file model\_8.inp will be output
to display the mesh after the domains are partitioned. For details,
refer to the hecmw1 document (0803\_001x\_hecmw\_part\_201\_users.pdf).

\(5) Visualization control data (Ext. ini)

The control data of hecmw\_vis is specified in this file. The default
file name is hecmw\_vis.ini. An example of the visualization control
data is shown in the following. In this example, an unstructured mesh
type data for MicroAVS (Ext. inp) is output. For details, refer to
Section 7.3.3 and Section 7.4.7 of the User's Manual.

### Execution Procedure

Execute hecmw\_part with the following command line in the directory
where the input file is saved.

\$ hecmw\_part1

Execute FrontISTR with the following command line in the directory where
the input file is saved. In addition, in the execution procedure of the
MPI process, it is necessary to make corrections according to each
environment.

\$ mpirun –np 8 fistr1

Two methods can be used to execute the visualization. The first method
is used when executing as a post process of FrontISTR. By specifying
!WRITE, VISUAL in the analysis control data, the visualization will
automatically be executed. In this case, it is necessary to describe the
visualization control data included in the analysis control data.

When executing the visualization after the execution of FrontISTR is
completed, first specify !WRITE, RESULT in the analysis control data,
and then execute FrontISTR.

After the execution of FrontISTR is completed, execute hecmw\_vis by the
following command line in the directory where the input file and
analysis results file are saved. In addition, in the execution procedure
of the MPI process, it is necessary to make corrections according to
each environment.

\$ mpirun –np 8 hecmw\_vis1

### Description of Output File

\(1) Domain partitioning utility log file (Ext. log)

Messages, such as the analysis progression process of hecmw\_part will
be output in this file. The fixed file name is hecmw\_part.log.

\(2) Distributed domain mesh file (no Ext.)

The mesh configuration partitioned into domains, material data, group
data used in the analysis control data and etc, will be output in this
file. A file will be created for each distributed domains, and the file
will be named as follows using the file header specified in the overall
control data.

Naming rule: (File header specified by !MESH).(Distributed domain
number)

> Example: model\_8.0　～　model\_8.7

\(3) File for domain partitioning mesh display (Ext. inp)

The unstructured mesh type data to display the mesh partitioned into
domains will be output in this file. This can be displayed by MicroAVS,
etc.

\(4) Analysis results message file (Ext. msg)

Messages, such as the analysis progression process of FrontISTR will be
output in this file. One file will be created with one execution, and
the fixed file name is FSTR.msg.

\(5) Analysis results log file (Ext. log)

The physical quantity analysis results of each node and element of
FrontISTR will be output in this file. The analysis results of the
maximum, minimum and eigenvalues of the physical quantity will also be
output in this file. In the case of dynamic analysis, the analysis
results of all the steps will be output in this file. A file will be
created for each distributed domain, and the fixed file name is n.log (n
is the distributed domain number).

\(6) Analysis results file (no Ext.)

The analysis results will be output in this file, when the !WRITE,
RESULT option is specified.

The physical quantity analysis results of each node and element of
FrontISTR will be output in this file. A file will be created for each
distributed domain and step, and the file will be named as follows using
the file header specified in the overall control data.

Naming rule: (File header specified by !RESUT).(Distributed domain
number).(Step number)

> Example: model\_8.res.0.1　～　model\_8.res.7.1

\(7) Analysis results bitmap file (Ext. bmp)

The analysis results will be output in this file when specified in the
visualization control data.

The visualized bitmap data will be output in this file. The file will be
named using the file header specified in the overall control data. For
details on the naming rules, refer to the hecmw1 document
(0803\_001f\_hecmw\_PC\_cluster\_201\_vis.pdf).

\(8) Analysis results unstructured mesh type data file (Ext. inp)

The analysis results will be output in this file when specified in the
visualization control data.

The post process can be executed with REVOCAP\_PrePost, MicroAVS and
etc. using this file. The file will be named as follows, using the file
header specified in the overall control data.

Naming rule: (File header specified by !RESUT)\_psf.(Step No.).inp

> Example: model\_vis\_psf.0000.inp

\(9) Analysis results neutral file (Ext. neu)

The analysis results will be output in this file when specified in the
visualization control data.

The post process can be executed with Femap using this file. The file
will be named as follows, using the file header specified in the overall
control data.

Naming rule: (File header specified by !RESUT)\_psf.(Step No).neu

> Example: model\_vis\_psf.0000.neu

Note: In addition to the above, the FSTR.dbg.0 \~ n files will be
output; however, since these are for debugging, it is normally not
necessary to refer to these files.
