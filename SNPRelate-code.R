setwd("/Users/annebrown/Documents/SNPRelate")
install.packages("devtools")
library("devtools")
install_github("zhengxwen/gdsfmt")
install_github("zhengxwen/SNPRelate")

if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("gdsfmt")
BiocManager::install("SNPRelate")


library(gdsfmt)
library(SNPRelate)
sessionInfo()
l
# Import VCF file 
vcf.fn <- "/Users/annebrown/Documents/SNPRelate/50K-Zhou302merged-edit2.vcf.gz"
#Reformat VCF file in a GDS file
#GDS – Genomic Data Structures used for storing genetic array-oriented data, and the file format used in the gdsfmt package. We use biallelic to only extract bi-allelic SNPs. 
snpgdsVCF2GDS(vcf.fn, "Zhou302-50k.gds", method="biallelic.only")
#Print information stored in the GDS file
snpgdsSummary("Zhou302-50k.gds")

#open the GDS file
genofile <- snpgdsOpen("Zhou302-50k.gds")
#Create a list/ Retrieve Sample names
Z50ksample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))
#Create Similarity Matrix
Zhou30250ksimMatrix <- snpgdsIBS(genofile, sample.id=Z50ksample.id, num.thread=4, verbose=TRUE)
# rename rows as sample ids
rownames(Zhou30250ksimMatrix$ibs) <- Z50ksample.id
# rename columns as sample ids
colnames(Zhou30250ksimMatrix$ibs) <- Z50ksample.id
#export similarity matrix
write.table(Zhou30250ksimMatrix$ibs, file="Zhou302-50k_simMat_SNPRelate.txt", quote=FALSE, sep ="\t")

# Redo Korean Similarity matrix with Heterozygotes removed:
vcf1.fn <- "/Users/annebrown/Documents/SNPRelate/50K-KoreanMerged-HetRemoved.vcf.gz"
snpgdsVCF2GDS(vcf1.fn, "Kor-50k.gds", method="biallelic.only")
snpgdsSummary("Zhou302-50k.gds")
genofile1 <- snpgdsOpen("Kor-50k.gds")
kor50ksample.id <- read.gdsn(index.gdsn(genofile1, "sample.id"))
Kor50ksimMatrix <- snpgdsIBS(genofile1, sample.id=kor50ksample.id, num.thread=4, verbose=TRUE)
rownames(Kor50ksimMatrix$ibs) <- kor50ksample.id
colnames(Kor50ksimMatrix$ibs) <- kor50ksample.id
write.table(Kor50ksimMatrix$ibs, file="Korean-50k_simMat_HETsRemoved-SNPRelate.txt", quote=FALSE, sep ="\t")

# Field 2017 data
setwd("/Users/annebrown/Documents/Side_Projects/Field2017")
library(SNPRelate)
library(gdsfmt)
vcf.fn <- "field2017.vcf.gz"
snpgdsVCF2GDS(vcf.fn, "field.gds", method="biallelic.only")
snpgdsSummary("field.gds")
genofile <- snpgdsOpen("field.gds")
fieldsample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))
field17simMatrix <- snpgdsIBS(genofile, sample.id=fieldsample.id, num.thread=4, verbose=TRUE)
rownames(field17simMatrix$ibs) <- fieldsample.id
colnames(field17simMatrix$ibs) <- fieldsample.id
write.table(field17simMatrix$ibs, file="field2017_simMat_SNPRelate.txt", quote=FALSE, sep ="\t")

## Comparing 481 data to 50K ####
setwd("/Users/annebrown/Documents/MO481_paper")
library(SNPRelate)
library(gdsfmt)
vcf.fn <- "ngs481_50K_25kPos_merged.vcf.gz"
snpgdsVCF2GDS(vcf.fn, "USB481-50k.gds", method="biallelic.only")
snpgdsSummary("USB481-50k.gds")
genofile <- snpgdsOpen("USB481-50k.gds")
usb50ksample.id <- read.gdsn(index.gdsn(genofile, "sample.id"))
usb50ksimMatrix <- snpgdsIBS(genofile, sample.id=usb50ksample.id, num.thread=4, verbose=TRUE)
rownames(usb50ksimMatrix$ibs) <- usb50ksample.id
colnames(usb50ksimMatrix$ibs) <- usb50ksample.id
write.table(usb50ksimMatrix$ibs, file="USB481-50k_simMat_SNPRelate.txt", quote=FALSE, sep ="\t")
