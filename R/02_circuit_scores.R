# ============================================================
# 02_circuit_scores.R — Compute Circuit Dependency Scores
# ============================================================
source("R/00_setup.R"); set.seed(SEED)

expr     <- readRDS("data/TCGA_PAAD/expression_matrix.rds")
clinical <- readRDS("data/TCGA_PAAD/clinical.rds")
common_samples <- intersect(colnames(expr), rownames(clinical))
expr <- expr[, common_samples]; clinical <- clinical[common_samples,]
message("Samples: ", ncol(expr))

compute_cds <- function(expr_matrix, gene_set, label){
  available <- intersect(gene_set, rownames(expr_matrix))
  missing   <- setdiff(gene_set, rownames(expr_matrix))
  if(length(missing)>0) warning(label,": missing genes: ", paste(missing,collapse=", "))
  colMeans(expr_matrix[available,,drop=FALSE], na.rm=TRUE)
}

pH_raw    <- compute_cds(expr, pH_GENES,    "pH_CDS")
death_raw <- compute_cds(expr, DEATH_GENES, "death_CDS")
cycle_raw <- compute_cds(expr, CYCLE_GENES, "cycle_CDS")
minmax    <- function(x) (x-min(x,na.rm=TRUE))/(max(x,na.rm=TRUE)-min(x,na.rm=TRUE))

cds <- data.frame(
  sample_id=names(pH_raw),
  pH_CDS_raw=pH_raw, death_CDS_raw=death_raw, cycle_CDS_raw=cycle_raw,
  pH_CDS=minmax(pH_raw), death_CDS=minmax(death_raw), cycle_CDS=minmax(cycle_raw),
  stringsAsFactors=FALSE
)
cds$subtype <- apply(cds[,c("pH_CDS","death_CDS","cycle_CDS")], 1, function(row){
  arms <- c(A_pH=row["pH_CDS"], B_death=row["death_CDS"], C_cycle=row["cycle_CDS"])
  names(which.max(arms))
})
cds$subtype <- dplyr::recode(cds$subtype, A_pH="Subtype_A", B_death="Subtype_B", C_cycle="Subtype_C")

message("Subtype distribution:"); print(table(cds$subtype))
saveRDS(cds, "results/circuit_dependency_scores.rds")
write.csv(cds, "results/circuit_dependency_scores.csv", row.names=FALSE)
message("Saved to results/circuit_dependency_scores.csv")
