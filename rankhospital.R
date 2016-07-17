rankhospital <- function(state, outcome, num = "best") {
        originalData <- read.csv("outcome-of-care-measures.csv", colClasses = "character") ## Read outcome data
        state <- originalData$State == state
        state.data <- originalData[state,]
        if(nrow(state.data) == 0){
                stop(print("invalid state"))
        } ## Check that state is valid
        
        if(outcome == "heart attack") col.data <- 11
        else if(outcome == "heart failure") col.data <- 17
        else if(outcome == "pneumonia") col.data <- 23
        else stop(print("invalid outcome")) ## Check that outcome is valid
        
        state.data[,col.data] <- suppressWarnings(as.numeric(state.data[,col.data]))
        wo_na <- complete.cases(state.data[,col.data]) ## omit missing data
        state.wo_na <- state.data[wo_na,]
        
        ordered <- as.vector(state.wo_na[order(state.wo_na[,col.data], state.wo_na[,2]),2])
        
        if (num == "best") {
                as.character(ordered[1])
        } else if (num == "worst") {
                as.character(ordered[length(ordered)])
        } else if (is.numeric(num)) {
                as.character(ordered[num])
        } else {
                stop("invalid num")
        } ## Return hospital name in that state with the given rank 30-day death rate
}