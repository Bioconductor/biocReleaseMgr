## In the below, devel means the version that's about to be released and
## release means the current (before the release) release version

develDir_ <- "~/devel" # not portable
releaseDir_ <- "~/release"
develVersion_ <- "3.0"
releaseVersion_ <- '2.14'


# get new pkgs
getNewPkgs <- function(develDir=develDir_, releaseDir=releaseDir_,
                           develVersion=develVersion_, releaseVersion=releaseVersion_)
{
    develPkgs <- getPkgList(develDir, develVersion)
    releasePkgs <- getPkgList(releaseDir, releaseVersion)
    setdiff(develPkgs, releasePkgs)
}


# get removed pkgs 
getRemovedPkgs <- function(develDir=develDir_, releaseDir=releaseDir_,
                           develVersion=develVersion_, releaseVersion=releaseVersion_)
{
    develPkgs <- getPkgList(develDir, develVersion)
    releasePkgs <- getPkgList(releaseDir, releaseVersion)
    setdiff(releasePkgs, develPkgs)
}

# get list of pkgs


getPkgList <- function(dir=develDir_, version=develVersion_)
{
    #dir <- normalizePath(dir)
    manifestfile <- file.path(dir, paste0("bioc_", version, ".manifest"))
    lines <- readLines(manifestfile)
    lines <- lines[grep("^Package: ", lines)]
    lines <- sub("^Package: ", "", lines)
    lines <- sub(" ", "", lines)
    sort(lines)
}


# get pkg descriptions

getPkgDescriptions <- function(develDir=develDir_, releaseDir=releaseDir_,
                               develVersion=develVersion_, releaseVersion=releaseVersion_)
{
    pkgList <- getNewPkgs(develDir, releaseDir, develVersion, releaseVersion)
    descs <- lapply(pkgList, function(x){
        dcf <- read.dcf(file.path(develDir, x, "DESCRIPTION"))
        desc <- paste(strwrap(sub("^ +", "", unname(dcf[, "Description"]))), collapse=" ")
        paste0(x, " - ", desc, "\n", "\n")
    })
    unlist(descs)
}



# collate news -> biocViews

# count new pkgs, anno pkgs

# make release announcements

