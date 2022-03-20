library(randomForest)
library(parallel)
data(LetterRecognition, package = "mlbench")
set.seed(seed = 123, "L'Ecuyer-CMRG")

n = nrow(LetterRecognition)
n_test = floor(0.2 * n)
i_test = sample.int(n, n_test)
train = LetterRecognition[-i_test, ]
test = LetterRecognition[i_test, ]

ntree = 200
nfolds = 10
mtry_val = 1:(ncol(train) - 1) 
folds = sample( rep_len(1:nfolds, nrow(train)), nrow(train) ) #each observation "randomly" put into one of  1:10 folds
cv_df = data.frame(mtry = mtry_val, incorrect = rep(0, length(mtry_val)))
cv_pars = expand.grid(mtry = mtry_val, f = 1:nfolds)#table that combines all combination of folds and mtry
fold_err = function(i, cv_pars, folds, train) {
  mtry = cv_pars[i, "mtry"]                                                     #given i - which mtry I will use
  fold = (folds == cv_pars[i, "f"])                                             #given i I will use fond(i) - this gives all rows from train that are in fold i
  rf.all = randomForest(lettr ~ ., train[!fold, ], ntree = ntree,               #random forest No.1
                        mtry = mtry, norm.votes = FALSE)
  pred = predict(rf.all, train[fold, ])                                         #prediction on fold data given the random forest
  sum(pred != train$lettr[fold])                                                #prediciton error
}

nc = as.numeric(commandArgs(TRUE)[1])                                           #setting n.cores
cat("Running with", nc, "cores\n")
system.time({
  cv_err = parallel::mclapply(1:nrow(cv_pars), fold_err, cv_pars, folds = folds,
                              train = train, mc.cores = nc)                     #do fold_err for yeach combination of fold(1:10 groups) and mtry (1:16 branches for forest)
  err = tapply(unlist(cv_err), cv_pars[, "mtry"], sum)                          #number of wrong precitions for each mtry (sum over all different folds))
})
pdf(paste0("rf_cv_mc", nc, ".pdf")); plot(mtry_val, err/(n - n_test)); dev.off()


#Making parallel this particular tree
ntree_par = lapply(splitIndices(ntree, nc), length)
rf_par = function(x) randomForest(lettr ~ ., train, ntree=x, norm.votes = FALSE)
rf.out = mclapply(ntree_par, rf_par, mc.cores = nc)
rf.all = do.call(combine, rf.out)

crows = splitIndices(nrow(test), nc) 
rfp = function(x) as.vector(predict(rf.all, test[x, ])) 
cpred = mclapply(crows, rfp, mc.cores = nc) 
pred = do.call(c, cpred) 
correct <- sum(pred == test$lettr)

#old code upgraded above
#rf.all = randomForest(lettr ~ ., train, ntree = ntree)
#pred = predict(rf.all, test)
#correct = sum(pred == test$lettr)

mtry_cv = mtry_val[which.min(err)]

rf_par2 = function(x) randomForest(lettr ~ ., train, ntree=x, mtry=mtry_cv, norm.votes = FALSE)
rf.out = mclapply(ntree_par, rf_par2, mc.cores = nc)
rf.all = do.call(combine, rf.out)

rfp = function(x) as.vector(predict(rf.all, test[x, ])) 
cpred = mclapply(crows, rfp, mc.cores = nc) 
pred = do.call(c, cpred) 
correct_cv <- sum(pred == test$lettr)

#rf.all = randomForest(lettr ~ ., train, ntree = ntree, mtry = mtry)
#pred_cv = predict(rf.all, test)
#correct_cv = sum(pred_cv == test$lettr)
cat("Proportion Correct: ", correct/n_test, "(mtry = ", floor((ncol(test) - 1)/3),
    ") with cv:", correct_cv/n_test, "(mtry = ", mtry_cv, ")\n", sep = "")