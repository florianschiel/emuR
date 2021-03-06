##' Create demo data for emuR package
##' 
##' Create a folder in the folder specified
##' by the dir argument called emuR_demoData.
##' This folder contains the folders:
##' \itemize{
##' \item{ae: }{Containing an emuDB that adheres to the new formant specification (as expected by the \code{\link{load_emuDB}} function)} 
##' \item{TextGrid_collection: }{Containing a TextGrid collection (as expected from the \code{\link{convert_TextGridCollection_to_emuDB}} function)}
##' \item{legacy_ae: }{Containing legacyEmuDB (as expected by the \code{\link{convert_legacyEmuDB_to_emuDB}} function)}
##' }
##' @param dir directory to create demo data in (default= tempdir())
##' @param precache load and purge the create ae database to create an on-file-system cache
##' @export
##' @author Raphael Winkelmann 
create_emuRdemoData <- function(dir = tempdir(), precache = F){
  
  ddPath = file.path(dir,"emuR_demoData")
  
  path2data = system.file("extdata", package = "emuR")
  
  if(file.exists(ddPath)){
    stop("Path '", ddPath,"' already exists!")
  }
  
  dir.create(ddPath)
  #################################
  # create ae
  configPath = list.files(path2data, pattern = "DBconfig.json$", recursive = T, full.names = T)
  wavPaths = list.files(path2data, pattern = ".wav$", recursive = T, full.names = T)
  annotPaths = list.files(path2data, pattern = "_annot.json$", recursive = T, full.names = T)
  aePath = file.path(ddPath, "ae")
  
  dir.create(aePath)
  
  file.copy(configPath, aePath)
  
  sesPath = file.path(aePath, "0000_ses")
  dir.create(sesPath)
  
  for(p in wavPaths){
    bndlName = gsub(".wav$", "", basename(p))
    bndlPath = file.path(sesPath, paste0(bndlName, "_bndl"))
    dir.create(bndlPath)
    
    file.copy(p, bndlPath)
    idx = grep(paste0(bndlName, "_annot.json$"), annotPaths)
    file.copy(annotPaths[idx], bndlPath)
    
  }
  
  # calc dft and fms files
  wps = list.files(sesPath, pattern = ".wav$", recursive = T, full.names = T)
  dftSpectrum(wps)
  forest(wps)
  
  
  # generate cache of ae emuDB
  if(precache){
    dbName=load_emuDB(aePath, inMemoryCache = F, verbose = F)
    purge_emuDB(dbName, interactive = F)
  }
  
  ####################################
  # create TextGrid_collection and BPF_collections
  fpltgc = create_filePairList(path2data, path2data, "wav", "TextGrid")
  fplbpf_original = create_filePairList(path2data, path2data, "wav", "par")
  fplbpf_manipulated = create_filePairList(path2data, path2data, "wav", "parmanipulated")
  tgcPath = file.path(ddPath, "TextGrid_collection")
  bpfPath_original = file.path(ddPath, "BPF_collection_original")
  bpfPath_manipulated = file.path(ddPath, "BPF_collection_manipulated")
  
  dir.create(tgcPath)
  dir.create(bpfPath_original)
  dir.create(bpfPath_manipulated)
  
  dir.create(file.path(bpfPath_original, "0000"))
  dir.create(file.path(bpfPath_manipulated, "0000"))
  
  file.copy(fpltgc[,1], tgcPath)
  file.copy(fpltgc[,2], tgcPath)
  file.copy(fplbpf_original[,1], file.path(bpfPath_original, "0000"))
  file.copy(fplbpf_original[,2], file.path(bpfPath_original, "0000"))
  file.copy(fplbpf_manipulated[,1], file.path(bpfPath_manipulated, "0000"))
  file.copy(fplbpf_manipulated[,2], file.path(bpfPath_manipulated, "0000"))
  
  #################################
  # create legacyEmuDB
  tplPath = list.files(path2data, pattern = ".tpl$", recursive = T, full.names = T)
  wavPaths = list.files(path2data, pattern = ".wav$", recursive = T, full.names = T)
  hlbPaths = list.files(path2data, pattern = "hlb$", recursive = T, full.names = T)
  labPaths = list.files(path2data, pattern = "lab$", recursive = T, full.names = T)
  tonePaths = list.files(path2data, pattern = "tone$", recursive = T, full.names = T)
  
  legacyAePath = file.path(ddPath, "legacy_ae")
  dir.create(legacyAePath)
  labelsPath = file.path(legacyAePath, "labels")
  dir.create(labelsPath)
  signalsPath = file.path(legacyAePath, "signals")
  dir.create(signalsPath)
  
  # copy files
  file.copy(tplPath, legacyAePath)
  file.copy(wavPaths, signalsPath)
  file.copy(hlbPaths, labelsPath)
  file.copy(labPaths, labelsPath)
  file.copy(tonePaths, labelsPath)
  
  # calc dft and fms files
  wps = list.files(signalsPath, pattern = ".wav$", recursive = T, full.names = T)
  dftSpectrum(wps)
  forest(wps)
  
}

########################
# FOR DEVELOPMENT 
# unlink(file.path(tempdir(),"emuR_demoData"), recursive = T)
# create_emuRdemoData(precache = T)