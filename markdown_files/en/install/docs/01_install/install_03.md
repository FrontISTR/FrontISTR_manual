# Installation

## Supported installation procedure

This software supports two procedure for compiling.

### Compile with cmake

This software supports compiling the software using cmake.

cmake need to be installed in advance. cmake can be downloaded from the following website:

[https://cmake.org/](https://cmake.org/)

```
$ cd `${FSTRBUILDDIR}`
$ mkdir build
$ cd build
$ cmake ..
$ make -j2
$ make install
```

cmake will search libraries and headers and gererate proper Makefiles for compiling. If you have multi-cored CPU, you will run parallel make for saving compile time.

[continue... (Compile with cmake)](install_04)

#### Appendix

  - [Appendix: Example of installation procedure to CentOS7.3(cmake)](install_07)
  - [Appendix: Example of installation procedure to Ubuntu16.04(cmake)](install_09)

### Compile with editing Makefile.conf manually

This software supports compiling the software manually edited Makfile.conf.

```
$ cd `${FSTRBUILDDIR}`
$ cp Makefile.conf.org Makefile.conf
$ vi Makefile.conf
  Edit Makefile.conf manually, indicate the location of libraries and headers.
$ ./setup.sh [Options]
$ make
$ make install
```

When difficult to set automatic configuration with cmake, recommend manually editing Makefile.conf.

[continue... (Compile with editing Makefile.conf)](install_05)

#### Appendix

  - [Appendix: Example of installation procedure to CentOS7.3(Makefile.conf)](install_08)
  - [Appendix: Example of installation procedure to Ubuntu16.04(Makefile.conf)](install_10)
  - [Appendix: Example of installation procedure to Windows10(Makefile.conf)](install_11)


