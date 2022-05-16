# Co udelat aby veci fungovaly:

#dostat se do karoliny a :

#module load R
# R

remotes::install_github("RBigData/pbdIO")

install.packages("BioManager")
BiocManager::install("rhdf5")

install.packages("flexiblas")  #mozna, nevim

remotes::install_github("RBigData/pbdBASE")
remotes::install_github("RBigData/pbdDMAT")
remotes::install_github("RBigData/pbdML")

