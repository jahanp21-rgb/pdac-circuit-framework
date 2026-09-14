# ============================================================
# 04_survival_analysis.R — Cox, KM, C-index, DCA, Calibration
# ============================================================
source("R/00_setup.R"); set.seed(SEED)

cds      <- readRDS("results/circuit_dependency_scores.rds")
clinical <- readRDS("data/TCGA_PAAD/clinical.rds")
df <- merge(cds, clinical, by.x="sample_id", by.y="row.names")
df <- df[!is.na(df$OS.time) & !is.na(df$OS),]
message("n = ", nrow(df), " | Events = ", sum(df$OS==1))

surv_obj <- Surv(time=df$OS.time, event=df$OS)
km_fit   <- survfit(surv_obj ~ subtype, data=df)
km_diff  <- survdiff(surv_obj ~ subtype, data=df)
km_pval  <- 1 - pchisq(km_diff$chisq, df=length(km_diff$n)-1)
message("Log-rank p = ", signif(km_pval,3))

df$stage_binary <- ifelse(df$pathologic_stage %in% c("Stage I","Stage IA","Stage IB","Stage IIA"),"Early","Late")
df$grade_binary <- ifelse(df$neoplasm_histologic_grade %in% c("G1","G2"),"Low","High")

cox_fit <- coxph(Surv(OS.time,OS) ~ pH_CDS+death_CDS+cycle_CDS+
  age_at_initial_pathologic_diagnosis+stage_binary+grade_binary+gender,
  data=df, ties="efron")
cox_summary <- summary(cox_fit)
message("Concordance index: ", round(cox_summary$concordance["C"],3))

ph_test <- cox.zph(cox_fit)
message("Schoenfeld residuals:"); print(round(ph_test$table,3))

cox_clinical <- coxph(Surv(OS.time,OS) ~ age_at_initial_pathologic_diagnosis+stage_binary+grade_binary+gender, data=df, ties="efron")
cox_circuit  <- coxph(Surv(OS.time,OS) ~ pH_CDS+death_CDS+cycle_CDS, data=df, ties="efron")

message("C-index clinical only:  ", round(summary(cox_clinical)$concordance["C"],3))
message("C-index circuit only:   ", round(summary(cox_circuit)$concordance["C"],3))
message("C-index combined:       ", round(cox_summary$concordance["C"],3))

cox_table <- as.data.frame(round(cox_summary$conf.int[,c(1,3,4)],3))
colnames(cox_table) <- c("HR","HR_lower95","HR_upper95")
cox_table$p_value   <- round(cox_summary$coefficients[,"Pr(>|z|)"],4)
write.csv(cox_table, "results/cox_model_discovery.csv")
saveRDS(list(km_fit=km_fit, km_pval=km_pval, cox_fit=cox_fit, ph_test=ph_test, data=df),
        "results/survival_analysis.rds")
message("Saved to results/survival_analysis.rds and results/cox_model_discovery.csv")
