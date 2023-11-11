# use consistent code to determine where to find or add packages on disk.

# ensure the default package installation library is found
usr <- Sys.info()["effective_user"]
rversion <- substr(getRversion(), start = 1, stop = 3)
.libPaths(paste0("C:/Users/", usr, "/Documents/R/win-library/", rversion))
.libPaths(paste0("C:/Users/", usr, "/AppData/Local/R/win-library/", rversion))

# CRAN mirror
# Set default CRAN mirror to prevent dialogue boxes from appearing
# (dialogue boxes crash rscript.exe)
mirror <- "https://cloud.r-project.org/"
options(repos = mirror)
