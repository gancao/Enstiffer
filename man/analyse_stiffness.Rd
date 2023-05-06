\name{analyse_stiffness}
\alias{analyse_stiffness}
\title{
Main function for stiffness and LR contribution calculation
}
\description{
Stiffness and LR contribution calculation for each sample
}
\usage{
analyse_stiffness(train_LR_weight_file, exp_file, result_dir, prefix, parallel_flag = "yes", cores = 50)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{train_LR_weight_file}{
The trained LR weight table file in two colums, the first column represents LR pairs and the second column represents corresponding weight of the LR
}
  \item{exp_file}{
Gene expression matrix file of samples that user input
}
  \item{result_dir}{
The ouput dir of all results
}
  \item{prefix}{
The prefix of saved files
}
  \item{parallel_flag}{
"\code{yes}" (default) or "\code{no}", "\code{yes}" denotes multiple cores and "\code{no}" denotes single core for calculaing LR score matrix
}
  \item{cores}{
Number of cores to be used when doing parallel computing, default is "\code{50}". 
}
}

\value{
A data frame returned by function of calculate_stiffness in two columns. The first column represents the sample ID and the second column represents the predicted stiffness (kPa)
}
