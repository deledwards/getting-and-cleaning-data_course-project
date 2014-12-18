
downloadDataset = function(){
    downloadArchive <- "Dataset.zip"
    extractDir <- "extract"
    if(!file.exists(downloadArchive)){        
        datasetUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(datasetUrl, destfile=downloadArchive, method="curl")
    }
    
    if(!file.exists(extractDir)){
        dir.create(extractDir)
        unzip(downloadArchive, exdir = extractDir)
    }
    
}

downloadDataset()