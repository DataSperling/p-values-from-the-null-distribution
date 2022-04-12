# introduction to p-values: how p-values can be used to support scientific statements
# this analysis uses mouse weights to


# import dplyr for data filtering
library(dplyr)

# import data for experiment group and whole population
data <- read.csv("femaleMiceWeights.csv")
population <- read.csv("femaleControlsPopulation.csv")
population <- unlist(population)


# create control group eating chow diet
control <- dplyr::filter(data,Diet=="chow") %>% 
  dplyr::select(Bodyweight) %>% 
  unlist

# create treatment group eating high-fat (hf) diet
treatment <- filter(data,Diet=="hf") %>% 
  dplyr::select(Bodyweight) %>% 
  unlist

# show difference in means of control and treatment groups 3.020833g
obs <- mean(treatment) - mean(control)

# Null Hypothesis: "Diet, specifically a high-fat diet, has no effect on 
# the mass of the mice eating it"
RNGkind()
control_samp <- sample( population, 12)

# if the null hypothesis holds there is no difference between treatment and control
# we can therefore use the same population data
RNGkind()
treatment_samp <- sample( population, 12)

# under the above circumstances we are guaranteed to have no high-fat diet effect
# look at difference in mean masses: -0.4958333g
mean(treatment_samp) - mean(control_samp)

# each time we repeat the above sampling we get a different value for the null 
# hypothesis the null distribution is the distribution of all possible realizations
# under the null hypothesis

# now we repeat the above experiment 10,000 times and record the distribution
# of values under the null hypothesis
RNGkind()
n <- 10000
nulls <- vector("numeric",n)
for(i in 1:n) {
  control <- sample(population, 12)
  treatment <- sample(population, 12)
  # save results in a vector
  nulls[i] <- mean(treatment) - mean(control)
}

# look at min and max values of the null distribution (5.443333g and
# -5.966667g respectively)
max(nulls)
min(nulls)

# plot histogram to see the relative proportions
hist(nulls,
     main="Simulated Null Distribution of Mice Masses'",
     xlab="Mass Difference in gramms Between Control and Treatment Groups",
     ylab="Relative Proportion")

# return to our question: How likely are we to see differences as large as
# 3g under the null hypothesis? The null distribution shows differences
# as large as +/- 3g. The answer to this question will help support scientific 
# statements about the effect of a high-fat diet on mouse mass.

# we report the number of times the null distribution was larger than 3g
# 0.0142
sum( nulls > obs) / n

# alternative method is to use mean() 0.0142
mean(nulls > obs)

# this means the null is larger than the observation 1.42% of the time

# can compute the difference in absolute value taking account of both sides
# of the distribution, 0.0282 or ~2.8% of the time
mean( abs( nulls) > obs)

# the p-value is the probability that an outcome from the null distribution
# is larger than the observed difference in means of treatment and control groups
# when the null hypothesis is true. The answer is about 2.8%.#

# the real challenge is making this calculation without the population data














