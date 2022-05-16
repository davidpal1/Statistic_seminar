# Compares data structures of shaq and ddmatrix with row-block input
source("mnist_read_mpi.R") # reads blocks of rows
suppressMessages(library(kazaam))

if(comm.rank() == 0) str(my_train) # local matrices
sq_train = kazaam::shaq(my_train) # shaq class distributed matrix from local pieces
if(comm.rank() == 0) str(sq_train) # still local matrices but with global context

sq_train2 = new("shaq", Data=my_train, nrows=nrow(my_train), ncols=ncol(my_train))
allreduce(all.equal(sq_train, sq_train2), op = "land")

suppressMessages(library(pbdDMAT))
init.grid()
bldim = c(allreduce(nrow(my_train), op = "max"), ncol(my_train))
gdim = c(allreduce(nrow(my_train), op = "sum"), ncol(my_train))
dmat_train = new("ddmatrix", Data = my_train, dim = gdim, 
                 ldim = dim(my_train), bldim = bldim, ICTXT = 2)
comm.cat(comm.rank(), "dmat_train - Data dim:", dim(dmat_train@Data), 
         "bldim:", dmat_train@bldim, "ICTXT:", dmat_train@ICTXT,
         "dim:", dmat_train@dim, "ldim:", dmat_train@ldim, "\n",
         all.rank = TRUE, quiet = TRUE)
comm.print(dmat_train)
cyclic_train = pbdDMAT::as.blockcyclic(dmat_train)
comm.print(cyclic_train)
comm.cat(comm.rank(), "cyclic_train - Data dim:", dim(cyclic_train@Data), 
         "bldim:", cyclic_train@bldim, "ICTXT:", cyclic_train@ICTXT,
         "dim:", cyclic_train@dim, "ldim:", cyclic_train@ldim, "\n",
         all.rank = TRUE, quiet = TRUE)
finalize()
