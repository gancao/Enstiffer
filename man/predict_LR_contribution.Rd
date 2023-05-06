\name{predict_LR_contribution}
\alias{predict_LR_contribution}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
LR contribution calculation
}
\description{
LR contribution calculation for each sample
}
\usage{
predict_LR_contribution(sample_lr_matrix_file, lr_weight, predict_stiffness, result_dir, prefix)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{sample_lr_matrix_file}{
A table file that saves LR score matrix returned by function of calculate_LR_score
}
  \item{lr_weight}{
The trained LR weight vector
}
  \item{predict_stiffness}{
A data frame returned by function of calculate_stiffness in two columns. The first column represents the sample ID and the second column represents the predicted stiffness (kPa)
}
  \item{result_dir}{
The ouput dir of all results
}
  \item{prefix}{
The prefix of saved files
}
}

\value{
A matrix (sample x LR) that save LR contrbution matrix of each sample
}
