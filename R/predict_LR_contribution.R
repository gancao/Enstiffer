predict_LR_contribution <-
function(sample_lr_matrix_file,lr_weight,predict_stiffness,result_dir,prefix){
  sample_lr_matrix <- read.delim(sample_lr_matrix_file,header=T,row.names = 1,check.names = F)
  lr_weight <- lr_weight[colnames(sample_lr_matrix)]
  
  print(setdiff(colnames(sample_lr_matrix),names(lr_weight)))
  predict_stiffness_vector <- predict_stiffness$stiffness
  names(predict_stiffness_vector) <- as.character(predict_stiffness$sample_id)
  predict_stiffness_vector <- predict_stiffness_vector[rownames(sample_lr_matrix)]
  
  
  #m2
  lr_sample_matrix <- t(sample_lr_matrix)
  lr_sample_weight_score <- lr_sample_matrix*lr_weight
  sample_lr_weight_score <- t(lr_sample_weight_score)
  sample_lr_contribution <- sample_lr_weight_score/predict_stiffness_vector
  sample_lr_contribution[is.na(sample_lr_contribution)] <- 0
  rownames(sample_lr_contribution) <- rownames(sample_lr_matrix)
  colnames(sample_lr_contribution) <- colnames(sample_lr_matrix)
  save_file <- paste(result_dir,"/",prefix,"_sample_LR_contribution.txt",sep="")
  write.table(sample_lr_contribution,save_file,quote=F,sep="\t")
}
