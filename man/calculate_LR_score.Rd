\name{calculate_LR_score}
\alias{calculate_LR_score}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
calculate LR score matrix (sample x LR)
}
\description{
calculate LR score matrix (sample x LR)
}
\usage{
calculate_LR_score(exp_count, LR_weight_file, parallel_flag = "no", cores = 50)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{exp_count}{
Gene expression matrix in TPM 
}
  \item{LR_weight_file}{
The trained LR weight table file in two colums, the first column represents LR pairs and the second column represents corresponding weight of the LR
}
  \item{parallel_flag}{
yes (default) or no, "yes" denotes multiple cores and no denotes single core for calculaing LR score matrix
}
  \item{cores}{
Number of cores to be used when doing parallel computing, default is 50. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
A matrix (sample x LR) that represents the LR score in the sample based on TPM value
}
