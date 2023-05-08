# Estifflr #

----------

Estifflr is a R-based computational software for eastimation of tissue stiffness based on ligand-receptors interaction from RNA-seq data. This tool was tested on various RNA-seq datasets across several sequencing platforms. Estifflr was tested on Windows 11 and CentOS 7.

## Installtion ##
    install.packages("devtools")
    devtools::install_github("gancao/Estifflr")

## Usage ##
Before running Estifflr, the users require preparing the trained ligand-receptor (LR) weight list file deposited on the github and expression mtraix file in TPM values (Row:Gene, Column: Sample).  In addition, output folder (result\_dir) and the prefix name of reuslt files are required to input to Estifflr. The optinal parameters is listed as follows: <br> 
**parallel\_flag**: "‘yes’" (default) or "‘no’", "‘yes’" denotes multiple cores and "‘no’" denotes single core for calculaing LR score matrix; <br>
**cores**: Number of cores to be used when doing parallel computing, default is "50".


    library(Estifflr)
    analyse_stiffness(train_LR_weight_file,exp_file=tpm_file,result_dir,prefix,parallel_flag='yes',cores=50)

## Output ##
The contents of the output directory include three files: <br>
1. **<prefix\>\_sample\_LR_score.txt**: A matrix file that saves ligand-receptor scores where row represent samples, columns represent ligand-receptors and the values represent the product of the ligand and receptor TPM values in the sample. <br>
2. **<prefix\>\_stiffness.txt**: A table file in tab-delimited format that saves the predicted stiffness of each sample. The first column represents sample identifiers given by tpm\_file and the second column represents the corresponding stiffness value. <br>
3. **<prefix\>\_sample\_LR\_contribution.txt**: A matrix file that saves ligand-receptor  contribution scores where row represent samples, columns represent ligand-receptors and the values represent the corresponding contribution score. <br>




