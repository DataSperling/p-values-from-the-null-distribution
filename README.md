## Using R and p-values to Support Scientific Conclusions

This repository demonstrates how p-values, determined from statistical inference
can be used to support scientific conclusions. It is based on a paper that investigated
the effect of diet on diabetes incidence:

DIABETES, VOL. 53, SUPPLEMENT 3, DECEMBER 2004 "The High-Fat Diet–Fed Mouse A 
Model for Studying Mechanisms and Treatment of Impaired Glucose Tolerance and Type 
2 Diabetes"

The experiment is one in which 24 mice are fed different diets for a period of
12 months and their weight was measured weekly as well as blood samples taken 
which were tested for glucose tolerance. This analysis is concerned only with the 
mass measurements ie: the effect of diet on mass.

The experimental data is contained in femaleMiceWeights.csv and the population data
is in femaleControlsPopulation.csv. Respective test cohorts are formed from the 
data in the following way:

# extract control group that were fed normal diet (chow)
control <- dplyr::filter(data,Diet=="chow") %>% 
  dplyr::select(Bodyweight) %>% 
  unlist
  
# extract treatment group that were fed high-fat (hf) diet
treatment <- filter(data,Diet=="hf") %>% 
  dplyr::select(Bodyweight) %>% 
  unlist
  
We can see the difference in means of the two groups like this:

# difference in control and treatment mean masses
obs <- mean(treatment) - mean(control)

The question we want to answer is if this mass difference is due to chance alone
or if the diet has an effect.




  
  





