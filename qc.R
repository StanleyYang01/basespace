rm(list = ls())
setwd("~/Dropbox/GitHub/basespace/")
options(stringsAsFactors = F)

pkg <- c("tidyr","dplyr", "ggvis", "Biobase", "biomaRt")
sapply(pkg, require, character.only = T)

qc <- read.delim("./shell/log.rsem/rsem.out", header = F) 

(qc$age <- gsub("(Aged|Young).*", "\\1", qc$V1)); table(qc$age)
(qc$sex <- gsub(".*(Male|Female).*", "\\1", qc$V1)); table(qc$sex)
(qc$cel <- gsub(".*(Microglia|Macrophage).*", "\\1", qc$V1)); table(qc$cel)

(qc$group = paste0(qc$age, qc$sex, qc$cel)); table(qc$group)

(qc$count = as.numeric(gsub(".*alignment: (.*) \\(.*", "\\1", qc$V2)))
(qc$rate = as.numeric(gsub(".*\\((.*)%\\)", "\\1", qc$V2)))

qc$count <- qc$count * 1e-6
qc$x <- as.numeric(as.factor(qc$group))

qc %>% ggvis(~x, ~rate) %>% 
  layer_boxplots(fill=~group, width = 0.2) %>% layer_points() %>% layer_text(text:=~V1) %>% 
  add_axis("x", title = "", values = 1:4) %>% add_axis("y", title = "alignment rate in %")

qc %>% ggvis(~x, ~count) %>% 
  layer_boxplots(fill=~group, width = 0.2) %>% layer_points() %>% layer_text(text:=~V1) %>% 
  add_axis("x", title = "", values = 1:4) %>% add_axis("y", title = "number of aligned reads in million")

name <- list.files(path = "./rsem/", pattern = "*genes.results")
rsem <- lapply(name, function(x) { cat(x, "\n"); read.delim(file.path("./rsem/", x))}) 
names(rsem) <- gsub("_.*", "", name)

tpm <- sapply(rsem, function(x) x$TPM) %>% as.data.frame
count <- sapply(rsem, function(x) x$expected_count) %>% as.data.frame
rownames(tpm) <- rownames(count) <- rsem[[1]]$gene_id

mart = useMart("ensembl", dataset = "mmusculus_gene_ensembl")
biomart <- getBM(c("ensembl_gene_id", "external_gene_name"), "ensembl_gene_id", rownames(tpm), mart)

tpm <- tpm[biomart$ensembl_gene_id, ]
count <- count[biomart$ensembl_gene_id, ]

tpm <- apply(tpm, 2, function(x) tapply(x, biomart$external_gene_name, sum))
count <- apply(count, 2, function(x) tapply(x, biomart$external_gene_name, sum))

colSums(count)
apply(count, 2, max)

(extreme = count[rowMax(as.matrix(count)) > 1e5, ])

count_fil <- count[rowMax(count) > 30, ]
dim(count_fil)
hist(count_fil)
