library(ggplot2)
library(broom)
library(dplyr)

df <- read.csv('merged.csv')

# rating

ggplot(data = df, aes(x = rating, y = log(revenue))) +
  geom_point() +
  geom_smooth(method = "lm", se = 0)

mean <- mean(df$revenue)
log(mean)

mod_rating <- lm(log(revenue) ~ rating, data = df)
summary(mod_rating)
coef(mod_rating)

percent_change_rating <- (exp(0.4954)-1)*100
percent_change_rating

# budget

ggplot(data = df, aes(x = log(budget), y = log(revenue))) +
  geom_point() +
  geom_smooth(method = "lm", se = 0)

mod_budget <- lm(log(revenue) ~ log(budget), data = df)
summary(mod_budget)

# runtime

mod_runtime <- lm(log(revenue) ~ runtime, data = df)
summary(mod_runtime)

ggplot(data = df, aes(x = runtime, y = log(revenue))) +
  geom_point() +
  geom_smooth(method = "lm", se = 0)

# collection

df$belongs_to_collection <- grepl("Collection", df$belongs_to_collection)

ggplot(data = df, aes(x = factor(belongs_to_collection), y = log(revenue))) +
  geom_boxplot() +
  geom_smooth(method = "lm", se = 0)

mod_collection <- lm(log(revenue) ~ factor(belongs_to_collection), data = df)
summary(mod_collection)$coef

# Release decade

df$release_decade <- substring(df$release_date, 1, 4) %>%
  as.numeric()

df$release_decade <- (df$release_decade %/% 10) * 10

ggplot(data = df, aes(x = factor(release_decade), y = log(revenue))) +
  geom_boxplot() +
  geom_smooth(method = "lm", se = 0)

mod_decade <- lm(log(revenue) ~ factor(release_decade), data = df)
summary(mod_decade)$coef

# end