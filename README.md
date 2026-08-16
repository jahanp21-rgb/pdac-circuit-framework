# PDAC Circuit Framework

> Three Coupled Survival Circuits May Govern Adaptive Therapeutic Resistance in KRAS-Mutant PDAC

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![R Version](https://img.shields.io/badge/R-4.6.0-276DC3.svg)](https://www.r-project.org/)

**Live site:** https://[YOUR-USERNAME].github.io/pdac-circuit-framework

## Overview
Multi-cohort transcriptomic, Boolean network, and CRISPR-validated computational framework
integrating 183 TCGA-PAAD patients, external validation in GSE183795 (n=134),
47 PDAC CRISPR cell lines, and mechanistic Boolean network simulation.

## Key Results
| Analysis | Result |
|---|---|
| BCL2–CASP9 Spearman r | −0.47 (FDR p < 0.001) |
| Kaplan-Meier log-rank p | 0.009 (3 subtypes) |
| Cell Cycle CDS Cox HR (discovery) | 10.84 (95% CI 1.75–66.96, p=0.010) |
| Cell Cycle CDS Cox HR (validation) | 12.08 (95% CI 2.89–50.43, p=0.0006) |
| Boolean triple combination | 100% death-attractor convergence |
| CRISPR — CCND1 essentiality | −1.13 (threshold −0.5) |
| Classifier external AUC | 0.742 (Subtype A: 0.970) |

> ⚠️ All findings are computational. Wide confidence intervals reflect exploratory cohort sizes. Experimental validation required.

## Quick Start
```r
source("R/00_setup.R")         # Install packages, set seed=12345
source("R/02_circuit_scores.R") # Compute CDS scores
source("R/04_survival_analysis.R") # Cox + KM + C-index + DCA
```

## R Version: 4.6.0 | Seed: 12345 | License: MIT
