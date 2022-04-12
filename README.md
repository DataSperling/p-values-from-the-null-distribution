## Using R and p-values to Support Scientific Conclusions

This repository demonstrates how p-values, determined from statistical inference
can be used to support scientific conclusions. It is based on a paper that investigated
the effect of diet on diabetes incidence:

DIABETES, VOL. 53, SUPPLEMENT 3, DECEMBER 2004 "The High-Fat Diet–Fed Mouse A 
Model for Studying Mechanisms and Treatment of Impaired Glucose Tolerance and Type 
2 Diabetes"
(https://github.com/DataSperling/p-values-from-the-null-distribution/blob/main/The-high-fat-diet-fed-mouse.pdf)

### Experimental Overview

The experiment is one in which 24 mice are fed different diets for a period of
12 months and their weight was measured weekly as well as blood samples taken 
which were tested for glucose tolerance. This analysis is concerned only with the 
mass measurements i.e.: the effect of diet on mass.

The experimental data is contained in `femaleMiceWeights.csv` and the population data
is in `femaleControlsPopulation.csv`. Respective test cohorts are formed from the 
data in the following way:

### Extracting the Experimental Cohorts

```
# extract control group that were fed normal diet (chow)
control <- dplyr::filter(data,Diet=="chow") %>% 
  dplyr::select(Bodyweight) %>% 
  unlist
  
# extract treatment group that were fed high-fat (hf) diet
treatment <- filter(data,Diet=="hf") %>% 
  dplyr::select(Bodyweight) %>% 
  unlist
```

We can see the difference in experiemntal means of the two groups like this:

```
# difference in control and treatment mean masses is 3.020833g
obs <- mean(treatment) - mean(control)
```
The question we want to answer is; "What is the probability that an outcome from 
the null distribution is larger than the experimental value?" This is a p-value.
Here we have access to the population data:

### Using the Population Data to Simulate the Null Distribution

```
# view population data
population <- read.csv("femaleControlsPopulation.csv")
population <- unlist(population)
View(population)
```
We want to first see what the effect is when the null hypothesis is true, i.e.
when there is no high-fat diet effect on the mass of the mice. We can simulate 
this by sampling the population data for both treatment and control groups, after 
all, on the null there is no effect on mass.

```
# take a sample of 12 from the population data to form the control group
control_samp <- sample( population, 12)

# take a sample of 12 from the population data to form the treatment group
treatment_samp <- sample( population, 12)

# take note of the sampling method use as its important
RNGkind()
```

We can now look at the difference in mean masses within the above samples 
`control_samp` and `treatment_samp`.

```
# difference in mean masses of smaples
mean(control_samp) - mean(treatment_samp)
```

For each new pair of samples for which the above difference in means is calculated, 
a different difference is seen. These data span the so called "null distribution";
the realization of all differences in mean under the null hypothesis. The benefit
of the null distribution is allows one to describe the proportion of values seen
for any interval.

### Using the Null Distribution to Infer p-values

A for loop can be used to intuitively (but inefficiently) repeat the above sampling
10,000 times saving the resulting differences as a vector `nulls`, which can be used
for further analysis.

```
n <- 10000
nulls <- vector("numeric",n)
for(i in 1:n) {
  control <- sample(population, 12)
  treatment <- sample(population, 12)
  nulls[i] <- mean(treatment) - mean(control)
}
```

How do the maximum and minimum values from the above null distribution simulation
compare to those observed in experimental data?

```
# maximum and minimum values from sample data
max(nulls)
min(nulls)
```

The respective values are 5.443333g and -5.966667g respectively. Both are larger
than our experimental observation of ~3.021g. We can look at a histogram of `nulls`
to get an idea of the distribution of masses under the null.

```
# plot histogram of the null distribution in nulls
hist(nulls,
     main="Simulated Null Distribution of Mice Masses'",
     xlab="Mass difference in g between control and treatment groups",
     ylab="Relative Proportion")
```
![simulatedNullDistribution](https://user-images.githubusercontent.com/78074172/163004447-99c651bf-616e-4dfb-87ff-c28c6bf00eb6.jpg)

Now we have data which we can use to calculate how likely it is to see differences 
in mean mass as large as the experimental value (~3.021g) under the null hypothesis.
We calculate the proportion of times the value of the null distribution was larger
than the experimentally observed value.

```
# count how often the difference simulated under the null is larger than the
# experimental difference
sum( nulls > obs) / n
```

The answer is 1.42% of the time. However this is only for the positive side, we
must also take account of the negative side of the distribution:

```
sum(nulls < obs)/n
```

The actual p-value is thus twice the above value:

```
mean( abs( nulls > obs))
```

The answer is about ~2.8% of the time. This is the answer to the original question
"What is the probability that an outcome from the null distribution is larger than 
the experimental value. this is a p-value".











  
  





