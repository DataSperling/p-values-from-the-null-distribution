## Using R and p-values to Support Scientific Conclusions

This repository demonstrates how p-values, determined from statistical inference
can be used to support scientific conclusions. It is based on a paper that investigated
the effect of diet on diabetes incidence:

DIABETES, VOL. 53, SUPPLEMENT 3, DECEMBER 2004 "The High-Fat Diet–Fed Mouse A 
Model for Studying Mechanisms and Treatment of Impaired Glucose Tolerance and Type 
2 Diabetes"

### Experimental Overview
The experiment is one in which 24 mice are fed different diets for a period of
12 months and their weight was measured weekly as well as blood samples taken 
which were tested for glucose tolerance. This analysis is concerned only with the 
mass measurements ie: the effect of diet on mass.

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

We can see the difference in means of the two groups like this:

```
# difference in control and treatment mean masses
obs <- mean(treatment) - mean(control)
```
The question we want to answer is if the above mass difference is due to chance 
alone or if the diet has an effect. Here we have access to the population data:

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














  
  





