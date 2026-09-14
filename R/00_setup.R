# ============================================================
# 00_setup.R — PDAC Circuit Dependency Framework
# Load all required packages and set global parameters
# ============================================================
set.seed(12345)

required_packages <- c(
  "UCSCXenaTools","GEOquery","depmap","OmnipathR",
  "survival","survminer","dcurves","rms","timeROC",
  "ConsensusClusterPlus","BoolNet","igraph","RCy3",
  "fgsea","msigdbr","caret","glmnet","pROC","fastshap","MLmetrics",
  "ggplot2","pheatmap","corrplot","forestplot","ggpubr","RColorBrewer",
  "dplyr","tidyr","tibble","readr","stringr"
)
missing_pkgs <- required_packages[!sapply(required_packages, requireNamespace, quietly=TRUE)]
if(length(missing_pkgs)>0){
  bioc_pkgs <- c("GEOquery","depmap","OmnipathR","ConsensusClusterPlus","fgsea","RCy3","BiocManager")
  bioc_missing <- intersect(missing_pkgs, bioc_pkgs)
  if(length(bioc_missing)>0){ if(!requireNamespace("BiocManager",quietly=TRUE)) install.packages("BiocManager"); BiocManager::install(bioc_missing,ask=FALSE) }
  cran_missing <- setdiff(missing_pkgs, bioc_pkgs)
  if(length(cran_missing)>0) install.packages(cran_missing)
}
invisible(lapply(required_packages, function(pkg) suppressPackageStartupMessages(library(pkg,character.only=TRUE))))

SEED           <- 12345
ALPHA          <- 0.05
FDR_THRESHOLD  <- 0.05
ESSENTIALITY   <- -0.5
STABILITY_MIN  <- 0.70
N_BOOTSTRAP    <- 1000
N_SHAP         <- 100

pH_GENES    <- c("CA9","CA12","HIF1A","EGLN1","HSP90AA1")
DEATH_GENES <- c("BCL2","BCL2L1","CASP9","BAX","FADD","APAF1","IRS1","BCL9","BCL9L","CHUK","MAP3K7")
CYCLE_GENES <- c("CDK4","CCND1","TTK","SLC29A1")
ALL_CIRCUIT_GENES <- c(pH_GENES, DEATH_GENES, CYCLE_GENES)

dirs <- c("figures","results","data/TCGA_PAAD","data/GSE183795","data/DepMap","data/gene_sets")
invisible(lapply(dirs, function(d) if(!dir.exists(d)) dir.create(d,recursive=TRUE)))
message("Setup complete. R version: ", R.version$version.string)
message("Seed set to: ", SEED)
