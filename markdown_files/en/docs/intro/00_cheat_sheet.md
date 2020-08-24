---
title: FrontISTR Ver.5.1 CheatSheet(2020/08/24)
# pandoc -s ../en/docs/intro/00_cheat_sheet.md -c css/mystyle.css -o 00_cheat_sheet.html
---

## Cheat Sheet

### Install

~~~
$ tar xzf FrontISTR-v5.1.tar.gz
$ cd FrontISTR-v5.1
$ mkdir build; cd build
$ cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/local
$ make -j2; make install
~~~

### Parallel Execution

~~~
$ hecmw_part1
$ mpirun -np <4> fistr1
~~~

### Input

| File Type     | File Name          |
|:--------------|:--------------------|
| Overall Control Data | hecmw_ctrl.dat      |
| Mesh Data     | <ModelName>.msh     |
| Analysis Control Data | <ModelName>.cnt     |
| Partitioning Control Data | hecmw_part_ctrl.dat |

### Output

| File Type     | File Name          |
|:--------------|:--------------------|
| Log File       | <0>.log             |
| Analysis Result File | <ModelName>.res.<0>.<Step> |
| Visualization File | <ModelName>_vis_psf.<Step>.pvtu |

### Overall Control Data (hecmw_ctrl.dat)

~~~
!MESH, NAME=part_in, TYPE=HECMW-ENTIRE
 <ModelName>.msh
!MESH, NAME=part_out, TYPE=HECMW-DIST
 <ModelName>.p
!MESH, NAME=fstrMSH, TYPE=HECMW-DIST, REFINE=<1>
 <ModelName>.p
!CONTROL, NAME=fstrCNT
 <ModelName>.cnt
!RESTART, NAME=restart_in, IO=INOUT
 <ModelName>.restart
!RESULT, NAME=fstrTEMP, IO=IN
 <ModelName>.res
!RESULT, NAME=fstrRES, IO=OUT, TYPE=BINARY
 <ModelName>.res
!RESULT, NAME=vis_out, IO=OUT
 <ModelName>_vis
!SUBDIR, ON
~~~

### Partitioning Control Data (hecmw_part_ctrl.dat)

~~~
!PARTITION, TYPE=NODE-BASED, METHOD=PMETIS, DOMAIN=<4>
~~~

### MeshData

~~~
!HEADER
 <TITLE>
!NODE
 <NODE_ID>, <x>, <y>, <z>
!ELEMENT, TYPE=<341>, EGRP=<E1>
 <ELEM_ID>, <node1>, <node2>, <node3>, ...
!MATERIAL, NAME=<STRMAT>, ITEM=<3>
!ITEM=1, SUBITEM=2
 <YoungModulus>, <PoissonRatio>
!ITEM=2
 <Density>
!ITEM=3
 <ExpansionCoeff>
!MATERIAL, NAME=<HEATMAT>, ITEM=<3>
!ITEM=1, SUBITEM=2
 <Density>, <Temperature>
!ITEM=2, SUBITEM=2
 <SpecificHeat>, <Temperature>
!ITEM=3, SUBITEM=2
 <Conductivity>, <Temperature>
!SECTION, TYPE=<SOLID>, EGRP=<E1>, MATERIAL=<STRMAT>
!NGROUP, NGRP=<NG1>
 <node1>, <node2>, ...
!SGROUP, SGRP=<SG1>
 <elem1>, <localsurf1>, <elem2>, <localsurf2>, ...
!EGROUP, EGRP=<EG1>
 <elem1>, <elem2>, ...
!CONTACT PAIR, NAME=<CP1>
 <Slave_NodeGroup>, <Master_SurfaceGroup>
!AMPLITUDE, NAME=<AMP1>, VALUE=<RELATIVE|ABSOLUTE>
 <value1>, <time1>, <value2>, <time2>, ...
!EQUATION
 <Num_terms>, <RHS>
 <NODE_ID>, <dof>, <coeff>, ...
!ZERO
 <AbsoluteZero>
!END
~~~

### Version

~~~
!VERSION
 5
~~~

### Static Analysis

~~~
!SOLUTION, TYPE=STATIC
!STATIC
!BOUNDARY,GRPID=<1>
 <NODE_ID>, <StartDOF>, <EndDOF>, <Value>
!CLOAD,GRPID=<1>
 <NODE_ID>, <DOF>, <LoadValue>
!DLOAD,GRPID=<1>
 <SGRP>, <LoadType>, <LoadParameter>
!SPRING,GRPID=<1>
 <NODE_ID>, <DOF>, <SpringConstant>
~~~

### Contact

~~~
!CONTACT_ALGO, TYPE=<SLAGRANGE|ALAGRANGE>
!CONTACT, GRPID=<1>, NTOL=<NormalThreshold>, TTOL=<TangentThreshold>, NPENALTY=<NormalPenalty>, TPENALTY=<TangentPenalty>
 <ContactPair>, <FrictionCoeff>, <FrictionPenalty>
~~~

### Thermal Stress

~~~
!REFTEMP
 <Temperature>
!TEMPERATURE, READRESULT=<ResultStep>, SSTEP=<FirstStep>, INTERVAL=<StepInterval>
~~~

### Eigen

~~~
!SOLUTION, TYPE=EIGEN
!EIGEN
 <NumOfEigenvalues>, <Allowance>, <MaxIterations>
!BOUNDARY
~~~

### Heat Conduction

~~~
!SOLUTION, TYPE=HEAT
!HEAT
 <DT>, <CalcTime>, <TimeIncrement>, <Allowable>, <MaxIteration>, <Allowance>
!INITIAL_CONDITION, TYPE=<TEMPERATURE>
 <NODE_ID>, <Temperature>
!FIXTEMP
 <NODE_ID>, <Temperature>
!CFLUX
 <NODE_ID>, <HeatFlux>
!DFLUX
 <ELEMENT_ID>, <LoadType>, <HeatFlux>
!SFLUX
 <SGRP>, <HeatFlux>
!FILM
 <ELEMENT_ID>, <LoadType>, <HeatTransferCoeff>, <AmbientTemp>
!SFLIM
 SGRP, <HeatTransferCoeff>, <AmbientTemp>
!RADIATE
 ELEMENT_ID, <LoadType>, <RadiationFactor>, <AmbientTemp>
!SRADIATE
 SGRP, <RadiationFactor>, <AmbientTemp>
!WELD_LINE
 <Current>, <Voltage>, <HeatInput>, <TorchSpeed>
 EGRP, <DOF>, <StartPoint>, <EndPoint>, <TorchWidth>, <StartTime> 
~~~

### Dynamic Analysis

~~~
!SOLUTION, TYPE=DYNAMIC
!BOUNDARY
!CLOAD
!DLOAD
!SPRING
!VELOCITY, TYPE=<INITIAL|TRANSIT>, AMP=<NAME>
 NODE_ID, <DOF>, <DOF>, <RestrictedValue>
!ACCELERATION, TYPE=<INITIAL|TRANSIT>, AMP=<NAME>
 NODE_ID, <DOF>, <DOF>, <RestrictedValue>
!INITIAL_CONDITION, TYPE=<VELOCITY|ACCELERATION>
 NODE_ID, <DOF>, value
~~~

### Time History Response Analysis

~~~
!DYNAMIC, TYPE=<LINEAR|NONLINEAR>
 <ImplicitMethod1|ExplicitMethod11>, 1
 <StartTime>, <EndTime>, <NumberOfSteps>, <TimeIncrement>
 <gamma>, <beta>
 <LumpedMass1|ConsistentMass2>, 1, <Rm>, <Rk>
 1, <MonitoringNode>, <OutputInterval>
 <Displacement>, <Velocity>, <Acceleration>, <Reaction>, <Strain>, <Stress>
~~~

### Frequency Response Analysis

~~~
!DYNAMIC, TYPE=NONLINEAR
 <ImplicitMethod1|ExplicitMethod11>, 2
 <MinFrequency>, <MaxFrequency>, <NumOfDivisions>, <MeasurementFrequency>
 <StartTime>, <EndTime>
 <LumpedMass1>, 1, <Rm>, <Rk>
 <ResultInterval>, <Mode1|TimeHistory2>, <MonitoringNode>
 <Displacement>, <Velocity>, <Acceleration>, 0, 0, 0
!EIGENREAD
 <EigenAnalysisLog>
 <StartMode>, <EndMode>
!FLOAD
 NODE_ID, <DOC>, <LoadValue>
~~~

### Analysis Step

~~~
!STEP, TYPE=<STATIC|VISCO>, SUBSTEPS=<NumOfSubsteps>, CONVERG=<Threshold>, MAXITER=<MaxIteration>
 <TimeIncrement>, <EndValueOfTimeIncrement>
 BOUNDARY, <GRPID>
 LOAD, <GRPID>
 CONTACT, <GRPID>
~~~

### Auto Time Increment

~~~
!AUTOINC_PARAM, NAME=<AP1>
 <DecreaseRate>, <MaxIteration>, <TotalIteration>, <ContactIteration>, <NumOfDecreaseSubsteps>
 <IncreaseRate>, <MaxIteration>, <TotalIteration>, <ContactIteration>, <NumOfIncreaseSubsteps>
 <CutbackRate>, <NumberOfCutbacks> 
!TIME_POINTS, NAME=<NameofList>, TIME=<STEP|TOTAL>
 <TIME>
!STEP, TYPE=<STATIC|VISCO>, SUBSTEPS=<MaxSubsteps>, CONVERG=<Threshold>, MAXITER=<MaxIteration>, INC_TYPE=AUTO, MAXRES=<MaxAllowance>, TIME_POINTS=<NameOfTimeList>, AUTOINCPARAM=<NameOfAutoIncrementParameter>, MAXCONTITER=<ContactIteration>
 <InitialTimeIncrement>, <StepIncrement>, <UpperLimitOfTimeIncrement>, <LowerLimitOfTimeIncrement>
 BOUNDARY, <GRPID>
 LOAD, <GRPID>
 CONTACT, <GRPID>
~~~

| Boundary Condition Type | Card              |
|:-------------|:-----------------------------|
| BOUNDARY     | !BOUNDARY, !SPRING           |
| LOAD         | !CLOAD, !DLOAD, !TEMPERATURE |
| CONTACT      | !CONTACT                     |

### Output

~~~
!WRITE, VISUAL, FREQUENCY=<OutputInterval>
!WRITE, RESULT, FREQUENCY=<OutputInterval>
!OUTPUT_VIS
 <OutputVariableName>, <ON|OFF>
!OUTPUT_RES
 <OutputVariableName>, <ON|OFF>
!OUTPUT_SSTYPE, TYPE=<SOLUTION|MATERIAL>
~~~

| VariableName | Physical Value  | Target    |
|:-----------|:-----------------|:--------|
| DISP       | Displacement   | VIS,RES |
| REACTION   | Nodal Reaction Force  | VIS,RES |
| NSTRAIN    | Nodal Strain       | VIS,RES |
| NSTRESS    | Nodal Stress       | VIS,RES |
| NMISES     | Nodal Mises Stress | VIS,RES |
| ESTRAIN    | Elemental Strain   | RES     |
| ESTRESS    | Elemental Stress   | RES     |
| EMISES     | Elemental Mises Stress | RES     |
| VEL        | Velocity       | VIS,RES |
| ACC        | Acceleration    | VIS,RES |
| TEMP       | Temperature     | VIS,RES |

### Restart

~~~
!RESTART, FREQUENCY=<n>
~~~

### Local Coordinate

~~~
!ORIENTATION, NAME=<CoordinateSystem>, DEFINITION=COORDINATES
<ax,ay,az>,<bx,by,bz>,<cx,cy,cz>
~~~

~~~
!ORIENTATION, NAME=<CoordinateSystem>, DEFINITION=NODES
<a,b,c>
~~~

### Section

~~~
!SECTION, SECNUM=<IndexOfSectionOfMeshData>, ORIENTATION=<CoordinateSystem>, FORM361=<FBAR|IC|BBAR|FI>
~~~

### Material Property

~~~
!MATERIAL, NAME=<NameOfMaterial>
!ELASTIC, TYPE=<ISOTROPIC|ORTHOTROPIC>, DEPENDENCIES=<0>
 <YoungsModulus>, <PoissonRatio>
!DENSITY
 <MassDensity>
!EXPANSION_COEFF, TYPE=<ISOTROPIC|ORTHOTROPIC>, DEPENDENCIES=<0>
 <LinearExpansion>
~~~

~~~
!PLASTIC, YIELD=MISES, HARDEN=BILINEAR, DEPENDENCIES=<0>
 <InitialYieldStress>, <CuringCoefficient>
~~~

~~~
!PLASTIC, YIELD=MISES, HARDEN=MULTILINEAR, DEPENDENCIES=<0>
 <YieldStress>, <PlasticStrain>
 <YieldStress>, <PlasticStrain>
 ...
~~~

~~~
!PLASTIC, YIELD=MISES, HARDEN=SWIFT, DEPENDENCIES=<0>
 <ε0>, <K>, <n>
~~~

~~~
!PLASTIC, YIELD=<Mohr-Coulomb|Drucker-Prager>, HARDEN=BILIENAR, DEPENDENCIES=<0>
 <Adhesive>, <InternalFrictionAngle>, <Curing>
~~~

~~~
!HYPERELASTIC, TYPE=NEOHOOKE
 <C10>, <D>
~~~

~~~
!VISCOELASTIC
 <ShearRelaxationModulus>, <RelaxationTime>
~~~

~~~
!CREEP, TYPE=Norton, DEPENDENCIES=<0>
 <A>, <n>, <m>
~~~

### Solver Control

~~~
!SOLVER, METHOD=<CG>, PRECOND=<1>, MPCMETHOD=<3>
 <MaxIteration>, <PreIteration>, <Krilov>, <Color>, <ReuseSetup>
 <TruncationError>, <DiagonalScale>, 0.0
~~~

| Method     | Notes                          |
|:----------|:---------------------------------|
| CG        |                                  |
| BiCGSTAB  |                                  |
| GMRES     | Enable Number Of Krilov Subspaces |
| GPBiCG    |                                  |
| DIRECT    |                                  |
| DIRECTmkl | Use for Contact Analysis         |
| MUMPS     |                                  |

| Value | Precondition     |
|:----|:-----------------|
| 1,2 | SSOR             |
| 3   | Diagonal Scaling |
| 5   | AMG              |
| 10  | Block ILU(0)     |
| 11  | Block ILU(1)     |
| 12  | Block ILU(2)     |

| Value | Method of MPC   |
|:---|:-----------------|
| 1  | Penalty     |
| 2  | MPC-CG      |
| 3  | Explicit Elimination |

### Solver Control （AMG）

~~~
!SOLVER, METHOD=<CG>, PRECOND=5, MPCMETHOD=<3>
 <MaxIteration>, <PreIteration>, <Krilov>, <Color>, <ReuseSetup>
 <TruncationError>, <DiagonalScale>, 0.0
 <CoarseSolver>, <Smoother>, <MultigridCycle>, <MaxLevel>, <Scheme>, <Sweep>
~~~

### Post Process （for ParaView）

~~~
!VISUAL
!output_type=VTK
~~~

### Post Process （output BMP）

~~~
!VISUAL, method=PSR
!surface_num=1
!surface
!surface_style=1
!display_method=1
!color_comp_name=STRESS
!color_comp=7
!x_resolution=800
!y_resolution=600
!output_type=BMP
~~~

### Nonlinear Analysis

| Analysis Type | Related Cards                                                      |
|:-----------|:----------------------------------------------------------------|
| Static Analysis | !SOLUTION, TYPE=NLSTATIC<BR>!STEP                                                            |
| Dynamic Analysis | !DYNAMIC, TYPE=NONLINEAR<BR>!STEP                                |
| Contact Analysis | !CONTACT<BR>!CONTACT_ALGO<BR>!STEP                               |
| Material Nonlinear | !PLASTIC<BR>!HYPERELASTIC<BR>!VISCOELASTIC<BR>!CREEP              |