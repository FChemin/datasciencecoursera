corr <- function(directory, threshold = 0) {
        
        corr <- numeric()
        files <- complete(directory)
        ids = files[files["nobs"] > threshold, ]$id
        for (i in ids) {
                
                newRead <- read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""))
                data <- newRead[complete.cases(newRead), ]
                corr <- c(corr, cor(data$sulfate, data$nitrate))
        }
        return(corr)
}