# Data Download Instructions

All datasets are publicly available. No raw data are stored in this repository.

## 1. TCGA-PAAD (n = 183)
Source: https://xenabrowser.net
Download: HiSeqV2 expression + PAAD_clinicalMatrix + PAAD_survival.txt
Save to: data/TCGA_PAAD/

## 2. GSE183795 (n = 134)
Source: https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE183795
In R: library(GEOquery); gse <- getGEO("GSE183795", GSEMatrix=TRUE)
Save to: data/GSE183795/

## 3. DepMap CRISPR (47 PDAC lines)
Source: https://depmap.org/portal/download/ (DepMap 23Q4)
Files: CRISPRGeneEffect.csv + Model.csv
In R: library(depmap); crispr_data <- depmap_crispr()
Save to: data/DepMap/

## 4. Protein interactions
In R: library(OmnipathR)
interactions <- import_omnipath_interactions(resources=c("SignaLink3","SIGNOR","PhosphoSitePlus"))

## 5. MSigDB Hallmark gene sets
Source: https://www.gsea-msigdb.org
Download: h.all.v2023.2.Hs.symbols.gmt
Save to: data/gene_sets/
