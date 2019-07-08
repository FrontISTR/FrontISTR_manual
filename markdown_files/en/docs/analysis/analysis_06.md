## User Subroutines

An interface is provided for users to expand the FrontISTR functions by programming. These interfaces are basically FORTRAN subroutines which include the subroutine header, and are a description of the I/O parameters and the declaration statement of these parameters. The main portion of the routine must be written by the user.

FrontISTR provides the following user subroutine interfaces.

### Input of User Defined Material

When using user defined materials, up to a maximum of 100 material constants defined by the user can be used. As shown in the following, up to 10 values per line and a maximum of 10 lines of material constants can be input in the control data file.

**2nd line - 10th line maximaum**

v1, v2, v3, v4, v5, v6, v7, v8, v9, v10

### Subroutine regarding Elastoplasticity Deformation (`uyield.f90`)

The subroutines are provided in order to calculate the elastoplasticity stiffness matrix and stress return mapping. When using the user defined yield function, first, it is necessary to set the `!PLASTIC`, `TYPE=USER` in the input file, input the required material constants and then, create the subroutines uElastoPlasticMatrix and uBackwardEuler.

#### (1) Calculation subroutines of elastoplasticity stiffness matrix

```
subroutine uElastoPlasticMatrix( matl, stress, istat, fstat, D )
	REAL(KIND=kreal), INTENT(IN) :: matl(:)
	REAL(KIND=kreal), INTENT(IN) :: stress(6)
	INTEGER, INTENT(IN) :: istat
	REAL(KIND=kreal), INTENT(IN) :: fstat(:)
	REAL(KIND=kreal), INTENT(OUT) :: D(:,:)
```

  - `matl`:　Array to save the material constants (100 max)
  - `stress`: 2nd Piola-Kirchhoff stress
  - `istat`: Yield state (0: not yielded; 1: yielded)
  - `fstat`: State variable, fstat(1) = plastic strain, fstat(2:7) = back stress (while moving or complex hardening)
  - `D`: Elastoplasticity matrix

#### (2) Return mapping calculation subroutine of stress

```
subroutine uBackwardEuler ( matl, stress, istat, fstat )
	REAL(KIND=kreal), INTENT(IN) :: matl(:)
	REAL(KIND=kreal), INTENT(INOUT) :: stress(6)
	INTEGER, INTENT(INOUT) :: istat
	REAL(KIND=kreal), INTENT(IN) :: fstat(:)
```

  - `matl`: Array to save the material constants (100 max)
  - `stress`: 2nd Piola-Kirchhoff stress acquired by assuming trial stress elastic deformation
  - `istat`: Yield state (0: not yielded; 1: yielded)
  - `fstat`: State variable, fstat(1) = plastic strain, fstat(2:7) = back stress (while moving or complex hardening)

### Subroutine regarding Elastic Deformation (`uelastic.f90`)

The subroutines are provided in order to perform update calculations of the elastic stiffness matrix and stress of the elasticity and hyperelasticity problems. When using the user elasticity, or a hyperelasticity constitutive equation, first, it is necessary to set the `!ELASTIC, TYPE=USER` or the `!HYPERELASTIC, TYPE=USER` in the input file, input the required material constants and then, create the subroutines uElasticMatrix and uElasticUpdate.

#### (1) Calculation subroutine of elastic stiffness matrix

```
subroutine uElasticMatrix( matl, strain, D )
	REAL(KIND=kreal), INTENT(IN) :: matl(:)
	REAL(KIND=kreal), INTENT(IN) :: strain(6)
	REAL(KIND=kreal), INTENT(OUT) :: D(6,6)
```

  - `matl`: Array to save the material constants (100 max)
  - `strain`: Green-Lagrange strain
  - `D`: Elastic matrix


#### (2) Calculation subroutine of stress

```
subroutine uElasticUpdate ( matl, strain, stress )
	REAL(KIND=kreal), INTENT(IN) :: matl(:)
	REAL(KIND=kreal), INTENT(IN) :: strain(6)
	REAL(KIND=kreal), INTENT(OUT) :: stress(6)
```

  - `matl`: Array to save the material constants (100 max)
  - `strain`: Green-Lagrange strain
  - `stress`: Stress

### Subroutine regarding User Defined Materials (`umat.f`)

The interface of the deformation analysis of general materials is provided irrespective of elastic, hyperelastic and elastoplastic materials.

#### (1) Calculation subroutine of stiffness matrix

```
subroutine uMatlMatrix( mname, matl, ftn, stress, fstat, D, temperature, dtime )
	CHARACTER(len=\*), INTENT(IN) :: mname
	REAL(KIND=kreal), INTENT(IN) 　 :: matl(:)
	REAL(KIND=kreal), INTENT(IN) 　:: ftn(3,3)
	REAL(KIND=kreal), INTENT(IN) 　 :: stress(6)
	REAL(KIND=kreal), INTENT(IN) 　:: fstat(:)
	REAL(KIND=kreal), INTENT(OUT)　:: D(:,:)
	REAL(KIND=kreal), optional 　　 :: temperature
	REAL(KIND=kreal), optional :: dtime
```

  - `mname`: Material name
  - `matl`: Array to save the material constants (100 max)
  - `ftn`: Deformation gradient tensor
  - `stress`: 2nd Piola-Kirchhoff stress
  - `fstat`: State variable
  - `D`: Constitutive equation
  - `temperature`: Temperature
  - `dtime`: Time increment

#### (2) Update calculation subroutine of strain and stress

```
subroutine uUpdate( mname, matl, ftn, strain, stress, fstat, temperature, dtime )
	character(len=\*), intent(in) :: mname
	real(KIND=kreal), intent(in) :: matl
	real(kind=kreal), intent(in) 　 :: ftn(3,3)
	real(kind=kreal), intent(inout) :: strain(6)
	real(kind=kreal), intent(inout) :: stress(6)
	real(kind=kreal), intent(inout) :: fstat(:)
	real(KIND=kreal), optional :: temperature
	real(KIND=kreal), optional :: dtime
```

  - `mname`: Material name
  - `matl`: Array to save the material constants (100 max)
  - `ftn`: Deformation gradient tensor
  - `strain`: Strain
  - `stress`: 2nd Piola-Kirchhoff stress
  - `fstat`: State variable
  - `temperature`: Temperature
  - `dtime`: Time increment

### Process Subroutine of User Defined External Load (`uload.f`)

An interface is provided to process the external load defined by the user.

In order to use the external load defined by the user, first, numerical structure tULoad is defined in order to define the external load, and the definition is read using the `!ULOAD` of the input file. Subsequently, the external load is incorporated using the following interfaces.

#### (1) Subroutine for reading external load

```
integer function ureadload( fname )
	character(len=\*), intent(in) :: fname
```

  - `fname`: External file name. The user defined external load is read from this file.

#### (2) Subroutine for incorporating the external load into the overall load vector

```
subroutine uloading( cstep, factor, exForce )
	integer, INTENT(IN) :: cstep
	REAL(KIND=kreal), INTENT(IN) :: factor
	REAL(KIND=kreal), INTENT(INOUT) :: exForce(:)
```

  - `cstep`: Current number of analysis steps
  - `factor`: Load factor of current step
  - `exForce`: Overall load vector

#### (3) Calculation subroutine of residual stress

```
subroutine uResidual( cstep, factor, residual )
	integer, INTENT(IN) :: cstep
	REAL(KIND=kreal), INTENT(IN) :: factor
	REAL(KIND=kreal), INTENT(INOUT) :: residual(:)
```

  - `cstep`: Current number of analysis steps
  - `factor`: Load factor of current step
  - `residual`: Overall residual stress vector


