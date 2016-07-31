# Appendix

## Appendix A: List of Makefile.conf Variables {#appendix-a-list-of-makefile.conf-variables .ListParagraph}

\(1) Settings related to MPI

MPIDIR

Description: This variable specifies the path to the directory where MPI
has been installed. If an MPI-compatible compiler automatically refers
to the path, there is no need to set this variable together with the
following variables.

Default value: None

MPIBINDIR

> Description: This variable specifies the path to the directory where
> MPI executable
>
> files have been installed.

Default value: None

MPILIBDIR

> Description: This variable specifies the path to the directory where
> MPI libraries
>
> have been installed.

Default value: .

MPIINCDIR

Description: This variable specifies the path to the directory where MPI
header files have been installed.

Default value: .

MPILIBS

Description: This variable specifies the MPI library that will be linked
to C and Fortran90 object files.

Default value: None

\(2) Settings related to the installation directory

PREFIX

Description: This variable specifies the path to the directory where
this software is to be installed.

Default value: \$(HOME)/FrontISTR

BINDIR

Description: This variable specifies the path to the directory where the
executable files of this software are to be installed. Normally, there
is no need to change the value of this variable.

Default value: \$(PREFIX)/bin

LIBDIR

Description: This variable specifies the path to the directory where the
libraries of this software are to be installed. Normally, there is no
need to change the value of this variable from the default value.

Default value: \$(PREFIX)/lib

INCLUDEDIR

Description: This variable specifies the path to the directory where the
header files of this software are to be installed. Normally, there is no
need to change the value of this variable from the default value.

Default value: \$(PREFIX)/include

\(3) Settings related to METIS

METISDIR

Description: This variable specifies the path to the directory where
METIS has been installed.

Default value: \$(HOME)/metis-4.0

METISLIBDIR

Description: This variable specifies the path to the directory where the
library (libmetis.a) of METIS has been installed. Normally, there is no
need to change the value of this variable from the default value.

Default value: \$(METISDIR)

METISINCDIR

Description: This variable specifies the path to the directory where the
header files (such as metis.h) of METIS have been installed. Normally,
there is no need to change the value of this variable from the default
value.

Default value: \$(METISDIR)/Lib

\(4) Settings related to ParMETIS

PARMETISDIR

Description: This variable specifies the path to the directory where
ParMETIS has been installed.

Default value: \$(HOME)/ParMetis-3.1

PARMETISLIBDIR

Description: This variable specifies the path to the directory where the
library (libparmetis.a) of ParMETIS has been installed. Normally, there
is no need to change the value of this variable from the default value.

Default value: \$(PARMETISDIR)

PAEMETISINCDIR

Description: This variable specifies the path to the directory where the
header files (such as parmetis.h) of ParMETIS have been installed.
Normally, there is no need to change the value of this variable from the
default value.

Default value: \$(PARMETISDIR)/ParMETISLib

\(5) Settings related to REVOCAP\_Refiner

REFINERDIR

Description: This variable specifies the path to the directory where
REVOCAP\_Refiner has been installed.

Default value: \$(HOME)/ REVOCAP\_Refiner

REFINERINCDIR

Description: This variable specifies the path to the directory where
REVOCAP\_Refiner header files have been installed. Normally, there is no
need to change the value of this variable from the default value.

Default value: \$(REFINERDIR)/Refiner

REFINERLIBDIR

Description: This variable specifies the path to the directory where
REVOCAP\_Refiner libraries have been installed. Normally, there is no
need to change the value of this variable from the default value.

Default value: \$(REFINERDIR)/lib

\(6) Settings related to REVOCAP\_Coupler

REVOCAPDIR

Description: This variable specifies the path to the directory where
REVOCAP\_Coupler has been installed.

Default value: \$(HOME)/ REVOCAP\_Coupler

REVOCAPINCDIR

Description: This variable specifies the path to the directory where
REVOCAP\_Coupler header files have been installed. Normally, there is no
need to change the value of this variable from the default value.

Default value: \$(REVOCAPDIR)/librcap

REVOCAPLIBDIR

Description: This variable specifies the path to the directory where
REVOCAP\_Coupler libraries have been installed. Normally, there is no
need to change the value of this variable from the default value.

Default value: \$(REVOCAPDIR)/librcap

\(7) Settings related to MUMPS

MUMPSDIR

Description: This variable specifies the path to the directory where
MUMPS has been installed.

Default value: \$(HOME)/MUMPS

MUMPSINCDIR

Description: This variable specifies the path to the directory where
MUMPS header files have been installed. Normally, there is no need to
change the value of this variable from the default value.

Default value: \$(MUMPSDIR)/include

MUMPSLIBDIR

Description: This variable specifies the path to the directory where
MUMPS libraries have been installed. Normally, there is no need to
change the value of this variable from the default value.

Default value: \$(MUMPSDIR)/lib

\(8) Settings related to ML

> MLDIR
>
> Description: This variable specifies the path to the directory where
> ML is installed.
>
> Default value: \$(HOME)/ trilinos/11.8.1/ml
>
> MLINCDIR
>
> Description: This variable specivies the path to the directory where
> ML header files are installed. Normally, there is no need to change
> the value of this variable from the default value.
>
> Default value: \$(MLDIR)/include
>
> MLLIBDIR
>
> Description: This variable specivies the path to the directory where
> ML libraries are installed. Normally, there is no need to change the
> value of this variable from the default value.
>
> Default value: \$(MLDIR)/lib

\(9) Settings related to the C compiler

CC

Description: This variable specifies the C compiler start command.

Default value: mpicc

CFLAGS

Description: This variable specifies the option to be assigned to the C
compiler. Normally, there is no need to change the value of this
variable from the default value.

Default value: None

LDFLAGS

Description: This variable specifies the option to be assigned to the C
linker. Normally, there is no need to change the value of this variable
from the default value. However, when REVOCAP\_Refiner (written in C++)
is to be used and C compiler is used for linking C programs, C++
standard library (e.g. -lstdc++) needs to be specified here.

Default value: -lm

OPTFLAGS

Description: This variable specifies the optimization option (or another
option) to be assigned to the C compiler.

Default value: -O3

CLINKER

Description: This variable specifies the linker command for C program.
This is used when, for example, REVOCAP\_Refiner (written in C++) is to
be used and C++ compiler needs to be used for linking C programs with
C++ libraries.

Default value: \[The value specified for CC\]

\(10) Settings related to the C++ compiler

CPP

Description: This variable specifies the C++ compiler start command.

Default value: mpic++

CPPFLAGS

Description: This variable specifies the option to be assigned to the
C++ compiler. Normally, there is no need to change the value of this
variable from the default value. However, if Boost Libraries are not
automatically referenced from the C++ compiler, use the -I option to
specify the directory that contains the include files.

Default value: -DMPICH\_IGNORE\_CXX\_SEEK (Note: This is required for
Intel compilers.)

CPPLDFLAGS

Description: This variable specifies the option to be assigned to the
C++ linker. Normally, there is no need to change the value of this
variable from the default value.

Default value: None

CPPOPTFLAGS

Description: This variable specifies the optimization option (or another
option) to be assigned to the C++ compiler.

Default value: -O3

\(11) Settings related to the Fortran90 compiler

F90

Description: This variable specifies the Fortran90 compiler start
command.

Default value: mpif90

F90FLAGS

Description: This variable specifies the option to be assigned to the
Fortran90 compiler. Normally, there is no need to change the value of
this variable from the default value.

Default value: None

F90LDFLAGS

Description: This variable specifies the option to be assigned to the
Fortran90 linker. Normally, there is no need to change the value of this
variable from the default value. However, if Intel MKL is used, specify
its link option. Also, when REVOCAP\_Refiner (written in C++) is to be
used and Fortran90 compiler is used for linking Fortran90 programs, C++
standard library (e.g. -lstdc++) needs to be specified here.

Default value: None

F90OPTFLAGS

Description: This variable specifies the optimization option (or another
option) to be assigned to the Fortran90 compiler.

Default value: -O2

F90LINKER

Description: This variable specifies the linker command for Fortran90
program. This is used when, for example, REVOCAP\_Refiner (written in
C++) is to be used and C++ compiler needs to be used for linking
Fortran90 programs with C++ libraries. (E.g. on K-computer, “mpiFCCpx
--linkfortran” needs to be specified.)

Default value: \[The value specified for F90\]

\(12) Settings related to UNIX commands

MAKE

Description: This variable specifies the make start command. If options
are required, specify them together. Normally, there is no need to
change the value of this variable from the default value.

Default value: make

AR

Description: This variable specifies the command for creating or
changing an archive file. If options are required, specify them
together. Normally, there is no need to change the value of this
variable from the default value.

Default value: ar ruv

CP

Description: This variable specifies the command for copying files or
directories. If options are required, specify them together. Normally,
there is no need to change the value of this variable from the default
value.

Default value: cp -f

RM

Description: This variable specifies the command for deleting files or
directories. If options are required, specify them together. Normally,
there is no need to change the value of this variable from the default
value.

Default value: rm -f

MKDIR

Setting： This variable specifies the command for creating directories.
If options are required, specify them together. Normally, there is no
need to change the value of this variable from the default value.

Default value: mkdir –p

## Appendix B: Makefile.conf Setting Example  {#appendix-b-makefile.conf-setting-example .ListParagraph}

## Appendix C: Notes on K-computer and Fujitsu FX10 {#appendix-c-notes-on-k-computer-and-fujitsu-fx10 .ListParagraph}

This version includes tuned codes for K-computer and Fujitsu FX10.
However, in order to maximize the performance, a part of the source code
needs to be changed for corresponding environment.

File to be changed:

hecmw1/src/solver/solver\_33/hecmw\_tuning\_fx.f90

Changes:

Set the value of parameter **TotalSectorCacheSize** defined in the file
to

-   **12** on K-computer,

-   **24** on FX10.

Initially, the parameter is set for K-computer.
