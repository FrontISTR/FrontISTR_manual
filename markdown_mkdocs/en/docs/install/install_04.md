# Installation

Use the following procedure to install this software.

## Editing Makefile.conf

Create Makefile.conf by editing Makefile.conf.org in \${FSTRBUILDDIR} to
match the computer environment where this software is to be installed.
There are a large number of variables that can be defined, but most of
them can be used “as is” (without having to change the default values).
For most environments, there should be no need to change variables other
than those shown below.

MPIDIR: Specifies the directory where MPI has been installed

PREFIX: Specifies the directory where the executable module of this
software

is to be installed

METISDIR: Specifies the directory where METIS has been installed

PARMETISDIR: Specifies the directory where ParMETIS has been installed

REFINERDIR: Specifies the directory where REVOCAP\_Refiner has been
installed

REVOCAPDIR: Specifies the directory where REVOCAP\_Coupler has been
installed

MUMPSDIR: Specifies the directory where MUMPS has been installed

CC: Specifies the C compiler start command

CPP: Specifies the C++ compiler start command

F90: Specifies the Fortran90 compiler start command

Refer to Appendix A, “List of Makefile.conf Variables” for details on
all variables. Refer also to Appendix B, “Makefile.conf Setting Example”
for an example of Makefile.conf settings.

## Executing setup.sh

Create Makefile by executing the setup.sh shell script in
\${FSTRBUILDDIR}, as below.

\$ ./setup.sh

To generate a library for parallel computing, for example, execute
setup.sh with the following options specified.

Table 2: Options specified when setup.sh is executed

  --------------------------------------------------------------------------------------------------------
  Option             Description                                  Remarks
  ------------------ -------------------------------------------- ----------------------------------------
  -g or --debug      Generates a library for debugging            

  -p or --parallel   Generates a library for parallel execution   

  --with-tools       Generates a tool such as a partitioner       

  --with-refiner     Includes REVOCAP\_Refiner                    

  --with-revocap     Includes REVOCAP\_Coupler                    

  --with-metis       Uses METIS                                   

  --with-parmetis    Uses ParMETIS                                Disabled at present

  --with-mkl         Uses Intel MKL                               

  --with-mumps       Uses MUMPS                                   

  --with-paracon     Generates a executable module                

                     for parallel contact analysis                

  --with-lapack      Uses Lapack                                  Needed for condition number estimation

  --with-ml          Uses ML                                      
  --------------------------------------------------------------------------------------------------------

Examples of setup.sh execution are shown below.

\(1) Compiling for parallel processing

If this software is used in a parallel execution environment where MPI
has been installed, execute setup.sh with the -p or -parallel option
specified, as below.

\$ ./setup.sh –p

\(2) Generating a tool such as a partitioner

If a preprocessing or post-processing tool such as a partitioner (RCB)
or visualizer is required, execute setup.sh with the -with-tools option
specified, as below.

\$ ./setup.sh –p --with-tools

\(3) Using METIS

If METIS is used with a partitioner in an environment where METIS has
been installed, execute setup.sh with the --with-metis option specified,
as below.

\$ ./setup.sh –p --with-tools --with-metis

\(4) Compiling for contact analysis

If this software is used in a sequential processing with contact
analysis, execute setup.sh with the --with-mkl or -with-mumps option
specified, as below.

Sequential processing

\$ ./setup.sh --with-mkl or \$ ./setup.sh --with-mumps

If this software is used in a parallel processing with contact analysis,
execute setup.sh with -p, --with-metis, --with-mumps and --with-paracon
options specified, as below

\$ ./setup.sh –p --with-metis --with\_mumps --with\_paracon

## Executing make

Execute make in \${FSTRBUILDDIR} as below.

\$ make 2&gt;&1 | tee make.log

It may take several minutes to execute make, depending on the computer
environment. If an error occurs during execution, take appropriate
actions such as reviewing the Makefile.conf settings.

## Executing make install

After make has finished executing normally, execute make install to
install this software in the directory specified in Makefile.conf, as
below.

\$ make install

## Installing in Windows environments

In Windows environments, the following UNIX-like environments can be
used to install this software according to the above procedures.

> Sequential processing version: MinGW
>
> Parallel processing version: Cygwin
