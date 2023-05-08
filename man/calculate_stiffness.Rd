\name{calculate_stiffness}
\alias{calculate_stiffness}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Stiffness calculation for each sample
}
\description{
Stiffness calculation for each sample
}
\usage{
calculate_stiffness(save_sample_lr_matrix_file, lr_weights, result_dir, prefix)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{save_sample_lr_matrix_file}{
A table file that saves LR score matrix returned by function of calculate_LR_score
}
  \item{lr_weights}{
The trained LR weight vector
}
  \item{result_dir}{
The ouput dir of all results
}
  \item{prefix}{
The prefix of saved files
}
}

\value{
A data frame returned by function of calculate_stiffness in two columns. The first column represents the sample ID and the second column represents the predicted stiffness (kPa)
}
