---
title: FrontISTR Analysis Flow Manual
date: \today
author: FrontISTR Commons
---

<!-- 表記は FrontISTR ver. 0.0 で統一します -->
# FrontISTR Analysis Flow Manual

This software is the outcome of "Research and Development of Innovative Simulation Software" project supported by Research and Development for Next-generation Information Technology of Ministry of Education, Culture, Sports, Science and Technology. We assume that you agree with our license agreement of "MIT License" by using this software either for the purpose of profit-making business or for free of charge. This software is protected by the copyright law and the other related laws, regarding unspecified issues in our license agreement and contact, or condition without either license agreement or contact.

[![FrontISTR](../image/FrontISTR_logo.png){.center width=350px}](https://www.frontistr.com)

| Item                 | Content                                                        |
|----------------------|----------------------------------------------------------------|
| Name of Software     | FrontISTR                                                      |
| Version              | 5.0                                                            |
| License              | MIT License                                                    |
| Correnponding Clerks | FrontISTR Commons<br>2-11-16 Yayoi, Bunkyo-ku, Tokyo<br>c/o Institute of Engineering Innovation, School of Engineering<br>E-mail：support@frontistr.com |

## Manuals

  - [Introduction](../intro/index.md)
  - [How to install](../install/index.md)
  - [Theory](../theory/index.md)
  - [User's manual](../analysis/index.md)
  - [Tutorial](../tutorial/index.md)

<!-- ここまでテンプレート -->

This manual describes the analysis method by the finite element method (FEM) used in FrontISTR. 

Regarding the stress analysis method of solids, the infinitesimal deformation linear elasticity static analyais method is described first, and geometric nonlinear analysis method and elastoplasticity analysis method which are required when handling finite deformation problems are described next. Furthermore, a summarized evaluation method of the facture mechanics parameters which can be acquired using the results of the stress analysis by FEM is described. Finally, th eigenvalue analysis and heat conduction analysis method is described.

## List of description on this manual

- [PDF](analysis_en.pdf)

- [Analysis Flow](analysis_01.md)
- [Input File](analysis_01.md)
    - [Overall Control Data](analysis_02.md)
    - [Mesh Partitioning Data](analysis_03.md)
    - [Mesh Data](analysis_04.md)
    - [Analysis Control Data](analysis_05.md)
    - [Visualization Control Data](analysis_05.md)
- [Output File](analysis_01.md)
    - [Log Data](analysis_05.md)
    - [Restart Data](analysis_05.md)
    - [Visualization Data](analysis_05.md)
- [User Subroutines](analysis_06.md)


