analyse_stiffness <-
function(train_LR_weight_file,exp_file,result_dir,prefix,parallel_flag='yes',cores=50){
  exp_count <- read.delim(exp_file,header=T,row.names = 1,check.names = F)
  print('step1:calculate LR score matrix')
  LR_sample_matrix <- calculate_LR_score(exp_count,train_LR_weight_file,parallel_flag='yes',cores)
  sample_LR_matrix <- t(LR_sample_matrix)
  save_sample_lr_matrix_file <- paste(result_dir,'/',prefix,'_sample_LR_score.txt',sep='')
  write.table(sample_LR_matrix,save_sample_lr_matrix_file,quote=F,sep="\t")
  # 
  LR_weights <- read.delim(train_LR_weight_file,header=T,check.names = F)
  lr_weights <- LR_weights[,2]
  names(lr_weights) <- as.character(LR_weights[,1])
  
  print('step2:calculate stiffness')
  data_result <- calculate_stiffness(save_sample_lr_matrix_file,lr_weights,result_dir,prefix)
  
  data_result_file <- paste(result_dir,'/',prefix,'_stiffness.txt',sep='')
  data_result <- read.delim(data_result_file,header=T)
  
  print("step3:calculate LR contribution")
  predict_LR_contribution(save_sample_lr_matrix_file,lr_weights,data_result,result_dir,prefix)
  
  return(data_result)
}
