source("mnist_read_mpi.R") # reads blocks of rows
suppressMessages(library(kazaam))

## construct shaq matrix
sq_train = shaq(my_train)

## svd (shaq class: tall-skinny matrix)
options(warn = -1) ## suppress warnings about negative eigenvalues for mnist
train_svd = svd(sq_train, nu = 0, nv = 10)
comm.cat("kazaam top 10 singular values:", train_svd$d[1:10], "\n")

finalize()
