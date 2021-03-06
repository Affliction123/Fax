pop = 1486981
totalNumbers = pop / 4 +  pop /1000 
probBusy = rnorm(1,0.2,0.1)
prior = 1 / totalNumbers
post = 1 / (totalNumbers*probBusy)
cat("My belief was", prior, "\n")
cat("My belief after dialing is", post, "\n")
cat("Therefore my belief increased by", post/prior, "times")

result <- function(game) {
  w <- array(0, dim=c(1,2))
  
  row1 = game[1] + game[2] + game[3]
  if (row1 == 0) {w[1] <- 1} else if (row1 == 3) {w[2] <- 1}
  
  row2 = game[4] + game[5] + game[6]
  if (row2 == 0) {w[1] <- 1} else if (row2 == 3) {w[2] <- 1}
  
  row3 = game[7] + game[8] + game[9]
  if (row3 == 0) {w[1] <- 1} else if (row3 == 3) {w[2] <- 1}
  
  col1 = game[1] + game[4] + game[7]
  if (col1 == 0) {w[1] <- 1} else if (col1 == 3) {w[2] <- 1}
  
  col2 = game[2] + game[5] + game[8]
  if (col2 == 0) {w[1] <- 1} else if (col2 == 3) {w[2] <- 1}
  
  col3 = game[3] + game[6] + game[9]
  if (col3 == 0) {w[1] <- 1} else if (col3 == 3) {w[2] <- 1}
  
  diag1 = game[1] + game[5] + game[9]
  if (diag1 == 0) {w[1] <- 1} else if (diag1 == 3) {w[2] <- 1}
  
  diag2 = game[3] + game[5] + game[7]
  if (diag2 == 0) {w[1] <- 1} else if (diag2 == 3) {w[2] <- 1}
  
  if(w[1] == 0 & w[2] == 0) {return("t")} #reprint("Its a tie")
  if(w[1] == 1 & w[2] == 0) {return("o")} #print("O wins")}
  if(w[1] == 0 & w[2] == 1) {return("x")} #print("X wins")}
  if(w[1] == 1 & w[2] == 1) {return("t")} #print("Its a tie")}
}

res <- array(NA, dim=c(1,1000))
for (k in 1:1000) {
  first = matrix(NA,3,3)
  for (i in 1:9){
    first[i]= rbinom(1,1,0.5)
  }
  res[k] <- result(first)
}
t <- sum(res == "t")
o <- sum(res == "o")
x <- sum(res == "x")
cat("Out of 1,000 games: X won", x, ", O won", o, "and there were", t, "ties")
cat("Therefore probability that X wins is :", (x/1000))

result1 <- function(game) {
  w <- array(0, dim=c(1,2))
  row1 = game[1] + game[2] + game[3]
  if (row1 == 0) {w[1] <- 1}
  row2 = game[4] + game[5] + game[6]
  if (row2 == 0) {w[1] <- 1}
  row3 = game[7] + game[8] + game[9]
  if (row3 == 0) {w[1] <- 1}
  col1 = game[1] + game[4] + game[7]
  if (col1 == 0) {w[1] <- 1}
  col2 = game[2] + game[5] + game[8]
  if (col2 == 0) {w[1] <- 1}
  col3 = game[3] + game[6] + game[9]
  if (col3 == 0) {w[1] <- 1}
  diag1 = game[1] + game[5] + game[9]
  if (diag1 == 0) {w[1] <- 1}
  diag2 = game[3] + game[5] + game[7]
  if (diag2 == 0) {w[1] <- 1}
  if(w[1] == 1) {return("o")} #print("O wins")}
}

result2 <- function(game) {
  w <- array(0, dim=c(1,2))
  row1 = game[1] + game[2] + game[3]
  if (row1 == 3) {w[2] <- 1}
  row2 = game[4] + game[5] + game[6]
  if (row2 == 3) {w[2] <- 1}
  row3 = game[7] + game[8] + game[9]
  if (row3 == 3) {w[2] <- 1}
  col1 = game[1] + game[4] + game[7]
  if (col1 == 3) {w[2] <- 1}
  col2 = game[2] + game[5] + game[8]
  if (col2 == 3) {w[2] <- 1}
  col3 = game[3] + game[6] + game[9]
  if (col3 == 3) {w[2] <- 1}
  diag1 = game[1] + game[5] + game[9]
  if (diag1 == 3) {w[2] <- 1}
  diag2 = game[3] + game[5] + game[7]
  if (diag2 == 3) {w[2] <- 1}
  if(w[2] == 1) {return("x")} #print("X wins")}
}

res1 <- array(NA, dim=c(1,1000))
for (j in 1:1000) {
  second = matrix(100,3,3)
  allCells <- seq(1:9)
  remaining <- allCells
  for (i in 1:9){
    selected <- sample(remaining,1,replace=FALSE)
    if (i == 9) {
        selected <- remaining
    }
    remaining <- setdiff(remaining,selected)
    if (i %% 2 == 0) {
      second[selected] <- 0
      if (length(result1(second)) > 0) {
        res1[j] <- result1(second) 
        break
      }
    }
    else {
      second[selected] <- 1
      if (length(result2(second)) > 0) {
        res1[j] <- result2(second) 
        break
        }
    }
  }
}
res1[is.na(res1)] <- "t"
t1 <- sum(res1 == "t")
o1 <- sum(res1 == "o")
x1 <- sum(res1 == "x")
cat("Out of 1,000 games: X won", x1, ", O won", o1, "and there were", t1, "ties")
cat("Therefore probability that X wins is :", (x1/1000))
cat("while probability that O wins is :", (o1/1000))

doors <- c("A","B","C")
decision <- c()
for (i in 1:1000) 
{
  prize <- sample(doors)[1]
  pick <- sample(doors)[1]
  open <- sample(doors[which(doors != prize & doors != pick)])[1]
  switch <- doors[which(doors != pick & doors != open)]
  if(pick == prize){decision=c(decision,"NoSwitch")}
  if(switch == prize){decision=c(decision,"Switch")}
}
cat("Switching was appropriate strategy in :", (length(which(decision == "NoSwitch"))/1000), "of times")
cat("Switching was appropriate strategy in :", (length(which(decision == "Switch"))/1000), "of times")

xx <- runif(100,0,1)
y <- array(NA, dim=c(1,100))
for(i in 1:100) {
  x <- xx[i]
  if (x <= 0.5) {
    x <- 2*x
  }
  else {
    x <- 2*(1-x)
  }
  y[i] <- x
}

x <- xx
par(mfrow=c(2,3))
plot(seq(1:100),x, type = 'l',col="Green", xlab="n", ylab="value", main="Values of Uniform")
hist(x, breaks=10, col="blue", main="Hist of Uniform")
curve(dunif(x),add=T, col="red", lwd=1)
plot(density(x),main="Density of Uniform")

remove(x)
x <- y
plot(seq(1:100),x, type = 'l', col="Green", xlab="n", ylab="value", main="Values of Transform")
hist(x, breaks=10, col="blue", main="Hist of Transform")
curve(dunif(x),add=T, col="red", lwd=1)
plot(density(x), main="Density of Transform")

remove(x,xx,y)

xx <- runif(1,0,1)
y <- array(NA, dim=c(1,100))
y[1] <- xx
for(i in 2:100) {
    x <- y[i-1]
  if (x <= 0.5) {
    x <- 2*x
  }
  else {
    x <- 2*(1-x)
  }
  y[i] <- x
}

par(mfrow=c(1,3))
x <- y
plot(seq(1:100),x, type = 'l', col="Green", xlab="n", ylab="value", main="Values of Transform")
hist(x, breaks=10, col="blue", main="Hist of Transform")
curve(dunif(x),add=T, col="red", lwd=1)
plot(density(x), main="Density of Transform")
remove(x,xx,y)

k <- rnorm(1,5,3)
xx <- 1/2^k
y <- array(NA, dim=c(1,100))
y[1] <- xx
for(i in 2:100) {
  x <- y[i-1]
  if (x <= 0.5) {
    x <- 2*x
  }
  else {
    x <- 2*(1-x)
  }
  y[i] <- x
}

par(mfrow=c(1,3))
x <- y
plot(seq(1:100),x, type = 'l', col="Green", xlab="n", ylab="value", main="Values of Transform")
hist(x, breaks=10, col="blue", main="Hist of Transform")
curve(dunif(x),add=T, col="red", lwd=1)
plot(density(x), main="Density of Transform")
