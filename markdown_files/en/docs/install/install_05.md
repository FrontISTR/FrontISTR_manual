## Compile with editing Makefile.conf manually

### Editing Makefile.conf

Create `Makefile.conf` by editing `Makefile.conf.org` in ${FSTRBUILDDIR} to match the computer environment where this software is to be installed. There are a large number of variables that can be defined, but most of them can be used “as is” (without having to change the default values). For most environments, there should be no need to change variables other than those shown below.

| Variable    | Description                                                                             |
|:------------|:----------------------------------------------------------------------------------------|
| MPIDIR      | Specifies the directory where MPI has been installed                                    |
| PREFIX      | Specifies the directory where the executable module of this software is to be installed |
| METISDIR    | Specifies the directory where METIS has been installed                                  |
| REFINERDIR  | Specifies the directory where REVOCAP_Refiner has been installed                        |
| REVOCAPDIR  | Specifies the directory where REVOCAP_Coupler has been installed                        |
| MUMPSDIR    | Specifies the directory where MUMPS has been installed                                  |
| CC          | Specifies the C compiler start command                                                  |
| CPP         | Specifies the C++ compiler start command                                                |
| F90         | Specifies the Fortran90 compiler start command                                          |

Refer to Appendix A, “List of Makefile.conf Variables” for details on all variables. Refer also to Appendix B, “Makefile.conf Setting Example” for an example of Makefile.conf settings.

### Executing setup.sh

Create Makefile by executing the `setup.sh` shell script in `${FSTRBUILDDIR}`, as below.

```txt
$ ./setup.sh
```

To generate a library for parallel computing, for example, execute `setup.sh` with the following options specified.

#### Options specified when setup.sh is executed

| Option           | Description                                | Remarks                                |
|:-----------------|:-------------------------------------------|:---------------------------------------|
| -g or --debug    | Generates a library for debugging          |                                        |
| -p or --parallel | Generates a library for parallel execution |                                        |
| --with-tools     | Generates a tool such as a partitioner     |                                        |
| --with-refiner   | Includes REVOCAP_Refiner                   |                                        |
| --with-revocap   | Includes REVOCAP_Coupler                   |                                        |
| --with-metis     | Uses METIS                                 |                                        |
| --with-mkl       | Uses Intel MKL                             |                                        |
| --with-mumps     | Uses MUMPS                                 |                                        |
| --with-lapack    | Uses Lapack                                | Needed for condition number estimation |
| --with-ml        | Uses ML                                    |                                        |
| --old-res-format | Revert result file format                  |                                        |

Examples of `setup.sh` execution are shown below.

#### Compiling for parallel partitioner

If this software is used in parallel execution environment where MPI has installed, execute `setup.sh` with the `-p` or `--parallel` option specified, as below.

```txt
$ ./setup.sh –p
```

#### Generating a tool such as a partitioner

If a processing or post-processing tool such as a partitioner (RCB) or visualizer is required, execute `setup.sh` with the `--with-tools` option specified, as below.

```txt
$ ./setup.sh –p --with-tools
```

#### Using METIS

If METIS is used with a partitioner in an environment where METIS has been installed, execute `setup.sh` with the `--with-metis` option specified, as below.

```txt
$ ./setup.sh –p --with-tools --with-metis
```

### Executing make

Execute make in `${FSTRBUILDDIR}` as below.

```txt
$ make 2 > & 1 | tee make.log
```

It may take sevral minutes to execute make, depending on the computer environment. If an error occurs during execution, take appropriate actions such as reviewing the `Makefile.conf`

### Executing make install

After make has finished executing normally, execute make install to install this software in the directory specified in `Makefile.conf`, as below.

```txt
$ make install
```

### Installing in Windows environments

In Windows environments, the following UNIX-like environments can be used to install this software according to the above procedures.

- Sequential processing version : MinGW, Cygwin
- Parallel processing version : MinGW + Microsoft MPI, Cygwin + OpenMPI


