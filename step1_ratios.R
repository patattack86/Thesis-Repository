#start out in R, use function defined in other repository to graph all permutations of simple ratios in a matric

```{r setup, include=FALSE}
setwd("E:/Thesis/Thesis-Excel-files")

alldata <- read.csv("jul25-aug23data.csv")

allreflect <- read.csv("all_reflectance.csv")

#subsetting dataset to region of interest
pair.data17 <- allreflect[70:408]

applying function defined in previous repository
ratio17 <- pairwise.ratios(pair.data17)

#Use a linear model to compare each ratio against a measured value
n.ratio = length(1:ncol(ratio17))

ratio_lms17 <- lapply(1:n.ratio, function(x) lm(ratio17[,x] ~ alldata$TP))

ratio17.sum <- lapply(ratio_lms17, summary)

#extract rsquared values and rsquared adjusted
ratio_rsquared17 <- sapply(ratio17.sum, function(x) c(r_sq = x$r.squared, 
                                adj_r_sq = x$adj.r.squared))


#Applying the correct column names to the ratio data frame
wv.ratio <- colnames(ratio17)

colnames(ratio_rsquared17) <- c(wv.ratio)

#transpose dataframe then save
tr.ratio_rsquared17 <- t(ratio_rsquared17)

write.csv(tr.ratio_rsquared17, file = "allreflecttp.csv", sep = ",")
```

###Next step is to take the dataframe into python(mainly because I like pandas for dataframe manipulation
