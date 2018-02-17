splitv <- function(d, with){
    switch(with,
           yes = {
               sample <- sample.split(d$class, SplitRatio = .8)
               
               train_x <- d[sample,]
               train_y <- as.factor(train_x$class)
               train_x$class <- NULL
               
               test_x <- d[!sample,]
               test_y <- as.factor(test_x$class)
               test_x$class <- NULL
           },
           no = {
               train_x <- d
               train_y <- as.factor(train_x$class)
               train_x$class <- NULL
               
               test_x <- 0
               test_y <- 0
           })
    return(list(train_x,train_y,test_x,test_y))
}