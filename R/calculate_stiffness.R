calculate_stiffness <-
function(save_sample_lr_matrix_file,lr_weights,result_dir,prefix){
  sample_lr_score <- read.delim(save_sample_lr_matrix_file,header=T,row.names = 1,check.names = FALSE)
  sample_lr_score <- as.matrix(sample_lr_score)
  sample_lr_score <- sample_lr_score[,intersect(colnames(sample_lr_score),names(lr_weights))]
  
  #cosine similarity
  c_predict_exp <- sample_lr_score %*% as.matrix(lr_weights[colnames(sample_lr_score)])
  c_predict_exp <- c_predict_exp[,1]
  predicted_exp <- data.frame(sample_id=rownames(sample_lr_score),stiffness=as.vector(c_predict_exp))
  save_file <- paste(result_dir,"/",prefix,"_stiffness.txt",sep="")
  write.table(predicted_exp,save_file,sep="\t",quote=F)
  return(predicted_exp)
  
  cosine_score <- cosine(as.vector(stiffness_vector),as.vector(c_predict_exp))[1]
  cat(item_list[i],cosine_score,"\n")
  c_predict_result <- data.frame(stiffness=as.vector(stiffness_vector),
                                 predict_stiffness=as.vector(c_predict_exp),
                                 item = rep(item_list[i],length(stiffness_vector)))
}
