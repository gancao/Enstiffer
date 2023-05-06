calculate_LR_score <-
function(exp_count,LR_weight_file,parallel_flag='no',cores=50){
  #print(rownames(exp_count)[1:100])
  if('Entrez_Gene_Id' %in% colnames(exp_count)){
    exp_count <- subset(exp_count,select = -Entrez_Gene_Id)
  }
  LR_pair_list <- read.delim(LR_weight_file,header=T,check.names = F)
  LR_pair_list$V1 <- as.character(unlist(strsplit(as.character(LR_pair_list[,1]),split='[+]')))[seq(1,2*nrow(LR_pair_list),2)]
  LR_pair_list$V2 <- as.character(unlist(strsplit(as.character(LR_pair_list[,1]),split='[+]')))[seq(2,2*nrow(LR_pair_list),2)]
  colnames(LR_pair_list) <- c("lr","weight","V1","V2")
  cat("original LR pairs:",nrow(LR_pair_list),"\n")
  LR_pair_list <- LR_pair_list[,c("V1","V2")]
  
  c_LR_pair_flag <- apply(LR_pair_list,1,function(x){
    if(x[1] %in% rownames(exp_count) & x[2] %in% rownames(exp_count)){
      return(1)
    }else{
      return(0)
    }
  })
  c_LR_pair_list <- LR_pair_list[c_LR_pair_flag==1,]
  cat("obtained LR pairs in expression matrix:",nrow(c_LR_pair_list),"\n")
  exp_count <- exp_count[rownames(exp_count) %in% c(c_LR_pair_list[,1],c_LR_pair_list[,2]),]
  rowname_gene_list <- rownames(exp_count)
  
  if(parallel_flag=='yes'){
    cl <- makeCluster(cores)
    registerDoParallel(cl)
    interaction_score_matrix <- foreach(y=colnames(exp_count),.export=c(ls(.GlobalEnv)), .combine='cbind') %dopar% {
      x <- as.numeric(exp_count[,y])
      each_interaction_score <- apply(as.matrix(c_LR_pair_list),1,function(y){
        return(as.numeric(x[rowname_gene_list==y[1]])*as.numeric(x[rowname_gene_list==y[2]]))
      })
      
      return(each_interaction_score)
    }
    stopCluster(cl)
  }
  else{
    interaction_score_matrix <- apply(exp_count,2,function(x){
      
      each_interaction_score <- apply(as.matrix(c_LR_pair_list),1,function(y){
        
        return(as.numeric(x[rowname_gene_list==y[1]])*as.numeric(x[rowname_gene_list==y[2]]))
        
      })
      #	print(sum(each_interaction_score))
      return(each_interaction_score)
    })
  } 
  
  #print(head(interaction_score_matrix))
  rownames(interaction_score_matrix) <- apply(as.matrix(c_LR_pair_list),1,function(y){return(paste(y,collapse = '+'))})
  colnames(interaction_score_matrix) <- colnames(exp_count)
  
  return(interaction_score_matrix)
}
