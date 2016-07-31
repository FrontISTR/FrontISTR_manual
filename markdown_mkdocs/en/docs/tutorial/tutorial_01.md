# Notes for Use in this Release

There are two versions of FrontISTR included in this release.

\(1) FrontISTR Ver.3.6

> All the functions of FrontISTR can be used in versions constructed
> with HEC-MW Ver.2.7. However, there are the following restrictions
> regarding the contact analysis function.
>
> ・When the MUMPS is linked, process parallel can be executed in the
> analysis by parallel processing. Also, when the Intel MKL is linked,
> thread parallel can be executed in the analysis by parallel
> processing. Before executing, set the environmental variables
> according to the computer environment being used.

　(2) FrontISTR Ver.4.4

> The following functions of FrontISTR can be used in versions
> constructed with HEC-MW Ver.4.4.
>
> ・Elastic Static Analysis
>
> ・Nonlinear Static Analysis (except for Contact Analysis)

Each version can be executed with the execution commands which are as
follows.

　(1) When executing FrontISTR Ver.3.6

　　　　　hecmw\_part1、　fistr1、　hecmw\_vis1

　(2) When executing FrontISTR Ver.4.4

　　　　　hecmw\_part2、　fistr2、　hecmw\_vis2
