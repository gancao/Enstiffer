# RedeStiff #


RedeStiff is a R-based computational software for eastimation of tissue stiffness score based on ligand-receptors interaction from RNA-seq data. This tool was tested on various RNA-seq datasets across several sequencing platforms including bulk RNA-seq, Visium, slide-RNA-seq, Xenium and so on. RedeStiff was tested on Windows 11 and CentOS 7. Through RedeStiff, users can not only predict tissue stiffness score from RNA-seq data but also identify highly contributed ligand-receptors to tissue stiffness. RedeStiff could probably provide new molecular targeted therapy for different diseases.

![RedeStiff](https://github.com/gancao/RedeStiff/blob/main/files/RedeStiff.png)

## Installtion ##

    install.packages("devtools")
	library(devtools)
    devtools::install_github("gancao/RedeStiff")

## Usage ##
Before running RedeStiff, the users require downloading the trained ligand-receptor (LR) weight list file from [https://github.com/gancao/RedeStiff](https://github.com/gancao/RedeStiff "RedeStiff") and providing expression matrix file in TPM values (Row:Gene, Column: Sample).  In addition, output folder (result\_dir) and the prefix name of reuslt files are required to input to RedeStiff. <br>
**step1: download LR weight list file** <br>

    wget -c https://github.com/gancao/RedeStiff/blob/main/files/LR_weights_final.txt

**step2: run RedeStiff** <br>

    library(RedeStiff)
    analyse_stiffness(train_LR_weight_file,exp_file,result_dir,prefix='RedeStiff',parallel_flag='yes',cores=50)
**Alternatively, you can run RedeStiff by three stages: ** <br>
    exp_count <- read.delim(exp_file,header=T,row.names=1,check.names=F)
    #step1:calculate LR score matrix
    LR_sample_matrix <- calculate_LR_score(exp_count,train_LR_weight_file,parallel_flag='yes',cores)
    sample_LR_matrix <- t(LR_sample_matrix)
    save_sample_lr_matrix_file <- paste(result_dir,'/',prefix,'_sample_LR_score.txt',sep='')
    write.table(sample_LR_matrix,save_sample_lr_matrix_file,quote=F,sep="\t")
    
    LR_weights <- read.delim(train_LR_weight_file,header=T,check.names = F)
    lr_weights <- LR_weights[,2]
    names(lr_weights) <- as.character(LR_weights[,1])
    
    print('step2:calculate stiffness')
    data_result <- calculate_stiffness(save_sample_lr_matrix_file,lr_weights,result_dir,prefix)
    data_result_file <- paste(result_dir,'/',prefix,'_stiffness.txt',sep='')
    data_result <- read.delim(data_result_file,header=T)
    
    #step3:calculate LR contribution
    predict_LR_contribution(save_sample_lr_matrix_file,lr_weights,data_result,result_dir,prefix)
    
The required parameters are listed as follows:

- train\_LR\_weight_file: The trained LR weight table file in two colums, the first column represents LR pairs and the second column represents corresponding weight of the LR.
- exp_file: Gene expression matrix file of samples that user input (Row:Gene, Column: Sample).
- result\_dir: The ouput folder of all results.
- prefix: the prefix name of reuslt files.
    
The optinal parameters are listed as follows: <br> 

- parallel\_flag: "‘yes’" (default) or "‘no’", "‘yes’" denotes multiple cores and "‘no’" denotes single core for calculaing LR score matrix; <br>

- cores: Number of cores to be used when doing parallel computing, default is "50". <br>

## Output ##
The contents of the output directory include three files: <br>
1. **<prefix\>\_sample\_LR_score.txt**: A matrix file that saves ligand-receptor scores where row represent samples, columns represent ligand-receptors and the values represent the product of the ligand and receptor TPM values in the sample. <br>
2. **<prefix\>\_stiffness.txt**: A table file in tab-delimited format that saves the predicted stiffness of each sample. The first column represents sample identifiers given by tpm\_file and the second column represents the corresponding stiffness value. <br>
3. **<prefix\>\_sample\_LR\_contribution.txt**: A matrix file that saves ligand-receptor  contribution scores where row represent samples, columns represent ligand-receptors and the values represent the corresponding contribution score. <br>

## Others ##
We provide test files (GSE145429_tpm.txt) under "files". In addition, we provide training codes under "train". Other codes and files can be downloaded from https://zenodo.org/records/11514581.



