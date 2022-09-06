---
title: FrontISTR FAQ
date: 2020-10-05
author: FrontISTR Commons
---

<!-- 表記は FrontISTR ver. 0.0 で統一します -->
# FrontISTR FAQ

- [PDF](faq_en.pdf)

## General questions

### What is FrontISTR?

FrontISTR is an open-source structual analysis solver that can be used not only Windows and Linux PC clusters, but also on massively parallel supercomputers such as the K computer.

### Dose FrontISTR include a meshing tools or result visualization tool?

No, FrontISTR does not include meshing tools and visualization tools. The meshing tool and the result visualization require a separate pre-post tool.

### What pre-post tools are available that support it?

In the open-source tools.

- [REVOCAP_Prepost(up to Version 4.6)](https://www.frontistr.com/download/)
- [EasyISTR](http://opencae.gifu-nct.ac.jp/pukiwiki/index.php?AboutEasyISTR)

and so on.

In commercial software.

- A
- B
- C

and others are supported.

### Where can I download FrontISTR from?

[FrontISTR Group](https://www.frontistr.com/) Download it from [Download](https://www.frontistr.com/download/).

### What is the license for FrontISTR?

The license is [MIT License](https://gitlab.com/FrontISTR-Commons/FrontISTR/-/blob/master/License.txt).

### Where can I find FrontISTR manual

Please see [FrontISTR Manual](https://frontistr-commons.gitlab.io/FrontISTR_manual/en/).

## About element types

### Default element type

By default, hexahedral first-order elements are

 - Linear analysis, Non-conforming elements
 - Non-linear analysis, B-bar elements(< version 5.0a)
 - Non-linear analysis, F-bar elements(> version 5.0b)

### Why do the direct and iterative methods give different results for multi-point constraints (MPC)

`!SOLVER` changes the default method for handling multi-point constraints.

    - Direct method (DIRECTmkl, MUMPS), the penalty method
    - Iterative method (CG method, GMRES method, etc.), the explicit degree-of-freedom elimination method

The penalty method will have an error of less than 10^{-4}. The explicit degrees-of-freedom elimination method does not produce errors because the constraints are strictly satisfied. However, it is more computationally demanding than the penalty method.

The MPCMETHOD parameter can be changed (Deprecated due to lack of maintenance of the MPC-CG method).
