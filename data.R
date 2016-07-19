library(dplyr)
library(xlsx)
library(biomaRt)
library(Biobase)

## RSEM output

setwd("~/Dropbox/GitHub/basespace") 
name <- list.files(path = "./rsem_new/", pattern = "*.genes.results")
ge <- lapply(name, function(x) {
  cat(x, "\n"); filepath <- file.path("./rsem_new/", x)
  read.delim(filepath, stringsAsFactors = F)
}); names(ge) <- name
save(ge, file = "~/Dropbox/GitHub/basespace/data20160709.rdt")

## TPM 

ge_tpm <- sapply(ge, function(x) x$TPM) %>% as.data.frame
rownames(ge_tpm) <- ge[[1]]$gene_id

write.xlsx(ge_tpm, file = "data20160709.xlsx", sheetName = "T cells")

## Ensembl ID to gene symbol

ensId <- rownames(ge_tpm)
mart = useMart("ensembl", dataset = "mmusculus_gene_ensembl")
biomart <- getBM(c("ensembl_gene_id", "external_gene_name"), "ensembl_gene_id", ensId, mart)

all(biomart$ensembl_gene_id %in% rownames(ge_tpm))

tpm.dt <- ge_tpm[match(biomart$ensembl_gene_id, rownames(ge_tpm)), ]
tpm.dt <- apply(tpm.dt, 2, function(x) tapply(x, biomart$external_gene_name, sum))

tpm.dt <- as.data.frame(tpm.dt)

## analysis

tpm.dt <- tpm.dt[apply(tpm.dt, 1, function(x) max(x) > 10 & sum(x > 0) > 2), ]
tpm.dt[rowMax(as.matrix(tpm.dt)) > 1e4, ] %>% rownames

names(tpm.dt)
(group <- factor(gsub("^(Aged|Young).*", "\\1", names(tpm.dt)), levels = c("Young", "Aged")))

fit <- apply(log2(tpm.dt + 1), 1, function (x) lm(x ~ group))

fit.pv <- sapply(fit, function(x) summary(x)$coefficients["groupAged", "Pr(>|t|)"])
fit.et <- sapply(fit, function(x) summary(x)$coefficients["groupAged", "Estimate"])

y = cbind(logFC = fit.et, Pval = fit.pv)

tpm.m <- sapply(levels(group), function(x) rowMeans(tpm.dt[group == x]))

y = cbind(tpm.m, y)
y = y[order(y[, "Pval"]), ]

write.xlsx(y, file = "report20160718.xlsx", sheetName = "T cells")
