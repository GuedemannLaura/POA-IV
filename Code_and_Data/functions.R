#
# Q-statistics function ----
#

Q_statistics <- function(x,E,E2, nE){
C     <- cov(x)
V     <- diag(C)
W     <- 1/V
MU    <- sum(W*E)/sum(W)
d     <- E-MU
if(nE < 3){
  Q     <- as.numeric(rbind(d)%*%solve(C)%*%t(rbind(d)))
}else{
  Q     <- as.numeric(d%*%solve(C)%*%t(d))
}
MU2   <- sum(W*E2)/sum(W)
d2    <- E2-MU2
if(nE < 3){
  Q2    <- rbind(d2)%*%solve(C)%*%t(rbind(d2))
}else{
  Q2    <- d2%*%solve(C)%*%t(d2)
}
df    <- length(V)-1
return(list(Q=Q, Q2 = Q2, df=df))
}




#
# Q-statistics function application study ----
#

Q_statistics_a <- function(x){
  
  
  M         <- x
  C         <- cov(M)
  V         <- diag(C)
  W         <- 1/V
  Ests      <- matrix(nrow = 1, ncol = dim(C)[1])
  Ests[1,]  <- apply(M, 2, mean)
  MU        <- sum(W*Ests)/sum(W)
  d         <- Ests-MU
  Q         <- d%*%solve(C)%*%t(d)
  
  df        <- length(V)-1
  Qp        <- 1-pchisq(Q,df)
  
  return(list(Q=Q,Qp=Qp,df=df))
  
}

# x: data frame with bootstrap results (one column per estimate, N_boostrap rows)

## description:
# calculates adjusted Q statistics in case of correlated estimates using a empirical variance covariance matrix

## outcomes:
# Q:  Q statistics


## data: 
# x: empirical variance covariance matrix (eg. from a bootstrap)






######----
## example:
# A <- c(1,2,3,4,NA,3,54)
# table_na(A)$abs_table
# table_na(A)$prop_table





