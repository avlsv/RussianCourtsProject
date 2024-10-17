library(stats)      # Simple statistical functions
library(tidyverse)  # Data managing
library(lmtest)     # linear hypothesis tests
library(sandwich)   # Sandwich estimator
library(clubSandwich)   # Sandwich estimator

library(stargazer)  # Nice output tables
library(car)        # Linear Hypothesis
library(ggplot2)    # Graphs
library(AER)        # IV & Tobit
library(data.table)
library(plm)

#setwd("/Volumes/HD/results")
setwd(
  "~/Library/CloudStorage/GoogleDrive-avlasov@nes.ru/My Drive/Техать тут!/MAE Development/Courts"
)
all_articles <- read_csv("all_articles.csv")
article_105 <- read_csv("article_105.csv")
article_159 <- read_csv("article_159.csv")
article_228 <- read_csv("article_228.csv")

# Panel Creation ----





asd |> arrange(-number_of_letters)




all_articles$year <-
  format(dmy(all_articles$endDate), "%Y")
article_105$year <-
  format(dmy(article_105$endDate), "%Y")
article_159$year <-
  format(dmy(article_159$endDate), "%Y")
article_228$year <-
  format(dmy(article_228$endDate), "%Y")





all_articles$career_start_Y <-
  format(ymd(all_articles$career_start), "%Y") |> as.numeric()

article_105$career_start_Y <-
  format(ymd(article_105$career_start), "%Y") |> as.numeric()

article_159$career_start_Y <-
  format(ymd(article_159$career_start), "%Y") |> as.numeric()

article_228$career_start_Y <-
  format(ymd(article_228$career_start), "%Y") |> as.numeric()



panel_all_articles <-
  pdata.frame(all_articles,
              index = c("region", "year"),
              row.names = F)
table(index(panel_all_articles), useNA = "ifany")
dim(table(index(panel_all_articles), useNA = "ifany"))
sum(table(index(panel_all_articles), useNA = "ifany") == 0)

panel_article_105 <-
  pdata.frame(article_105,
              index = c("region", "year"),
              row.names = F)

table(index(panel_article_105), useNA = "ifany")
dim(table(index(panel_article_105), useNA = "ifany"))
sum(table(index(panel_article_105), useNA = "ifany") == 0)

panel_article_159 <-
  pdata.frame(article_159 ,
              index = c("region", "year"),
              row.names = F)

table(index(panel_article_159), useNA = "ifany")
dim(table(index(panel_article_159), useNA = "ifany"))
sum(table(index(panel_article_159), useNA = "ifany") == 0)


panel_article_228 <-
  pdata.frame(article_228,
              index = c("region", "year"),
              row.names = F)

table(index(panel_article_228), useNA = "ifany")
dim(table(index(panel_article_228), useNA = "ifany"))
sum(table(index(panel_article_228), useNA = "ifany") == 0)




# Summmary Statistics ------

all_articles$instance_first <- all_articles$instance == "FIRST"
df_all_articles <-
  all_articles |> select(
    verdict,
    guilty,
    prison,
    suspended,
    treated,
    share_of_new,
    post,
    number_of_letters,
    instance_first
  ) |> mutate_if(is.logical, as.numeric) |> as.data.frame()


article_105$instance_first <- article_105$instance == "FIRST"
df_article_105 <-
  article_105 |> select(
    verdict,
    guilty,
    prison,
    suspended,
    treated,
    share_of_new,
    post,
    number_of_letters,
    instance_first
  ) |> mutate_if(is.logical, as.numeric) |> as.data.frame()

article_159$instance_first <- article_159$instance == "FIRST"
df_article_159 <-
  article_159 |> select(
    verdict,
    guilty,
    prison,
    suspended,
    treated,
    share_of_new,
    post,
    number_of_letters,
    instance_first
  ) |> mutate_if(is.logical, as.numeric) |> as.data.frame()

article_228$instance_first <- article_228$instance == "FIRST"
df_article_228 <-
  article_228 |> select(
    verdict,
    guilty,
    prison,
    suspended,
    treated,
    share_of_new,
    post,
    number_of_letters,
    instance_first
  ) |> mutate_if(is.logical, as.numeric) |> as.data.frame()


stargazer(df_all_articles,
          summary = TRUE,
          mean.sd	= TRUE)
all_articles |> group_by(name) |> summarize(n = n(), share = share_of_new, post =
                                              post) |> distinct() |> ungroup() |> summarize(n = sum(n), mean(share), sd(share), mean(post), sd(post))

stargazer(df_article_105,
          summary = TRUE,
          mean.sd	= TRUE)

stargazer(df_article_159,
          summary = TRUE,
          mean.sd	= TRUE)


stargazer(df_article_228,
          summary = TRUE,
          mean.sd	= TRUE)

summary(df_all_articles)
summary(df_article_105)
summary(df_article_159)
summary(df_article_228)


# Treated ------
## All Articles ------




model_all_verdict_a <-
  plm(verdict ~ treated  + instance,
      panel_all_articles, effect = "twoways")


model_all_verdict_b <-
  plm(verdict ~ treated  + instance + number_of_letters,
      panel_all_articles,
      effect = "twoways")

model_all_guilty <-
  plm(guilty ~   treated  + number_of_letters + instance,
      data = panel_all_articles,
      effect = "twoways")

model_all_prison <-
  plm(prison ~  treated  + number_of_letters + instance,
      data = panel_all_articles,
      effect = "twoways")


model_all_suspended <-
  plm(suspended ~  treated  + number_of_letters + instance,
      data = panel_all_articles,
      effect = "twoways")

m1 <-
  list(
    model_all_verdict_a,
    model_all_verdict_b,
    model_all_guilty,
    model_all_prison,
    model_all_suspended
  )
summary(model_all_prison)




ses1 <- list(
  coeftest(model_all_verdict_a,
           vcov. = vcovDC(model_all_verdict_a,
                          type = "HC3"))[, 2],
  coeftest(
    model_all_verdict_b,
    vcov. = vcovSCC(model_all_verdict_b,
                    type = "HC3", maxlag = 5)
  )[, 2],
  coeftest(
    model_all_guilty,
    vcov. = vcovSCC(model_all_guilty,
                    type = "HC3",  maxlag = 5)
  )[, 2],
  coeftest(model_all_prison,
           vcov. = vcovDC(model_all_prison,
                          type = "HC3"))[, 2],
  coeftest(model_all_suspended,
           vcov. = vcovDC(model_all_suspended,
                          type = "HC3"))[, 2]
)


stargazer(m1,
          se = ses1,
          df = F)



model_all_means <- c(
  mean(
    mutate_if(model_all_verdict_a$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(model_all_verdict_b$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(model_all_guilty$model, is.logical, as.numeric)$guilty
  ),
  mean(
    mutate_if(model_all_prison$model, is.logical, as.numeric)$prison
  ),
  mean(
    mutate_if(model_all_suspended$model, is.logical, as.numeric)$suspended
  )
)
format(round(model_all_means, 3), nsmall = 3) |> as.numeric()


## Article 105 ------

model_article_105_verdict_a <-
  plm(verdict ~ treated  + instance,
      data = panel_article_105, effect = "twoways")


model_article_105_verdict_b <-
  plm(verdict ~ treated  + instance + number_of_letters,
      panel_article_105,
      effect = "twoways")


model_article_105_guilty <-
  plm(guilty ~   treated  + number_of_letters + instance,
      data = panel_article_105,
      effect = "twoways")

model_article_105_prison <-
  plm(prison ~  treated  + number_of_letters + instance,
      data = panel_article_105,
      effect = "twoways")


model_article_105_suspended <-
  plm(suspended ~  treated  + number_of_letters + instance,
      data = panel_article_105,
      effect = "twoways")


m2 <-
  list(
    model_article_105_verdict_a,
    model_article_105_verdict_b,
    model_article_105_guilty,
    model_article_105_prison,
    model_article_105_suspended
  )





ses2 <- list(
  coeftest(
    model_article_105_verdict_a,
    vcov. = vcovDC(model_article_105_verdict_a,
                   type = "HC3")
  )[, 2],
  coeftest(
    model_article_105_verdict_b,
    vcov. = vcovDC(model_article_105_verdict_b,
                   type = "HC3")
  )[, 2],
  coeftest(
    model_article_105_guilty,
    vcov. = vcovDC(model_article_105_guilty,
                   type = "HC3")
  )[, 2],
  coeftest(
    model_article_105_prison,
    vcov. = vcovSCC(model_article_105_prison,
                    type = "HC3", maxlag = 3)
  )[, 2],
  coeftest(
    model_article_105_suspended,
    vcov. = vcovDC(model_article_105_suspended,
                   type = "HC3")
  )[, 2]
)

summary(model_article_105_prison)
stargazer(m2,
          se = ses2,
          df = F)


model_article_105_means <- c(
  mean(
    mutate_if(model_article_105_verdict_a$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(model_article_105_verdict_b$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(model_article_105_guilty$model, is.logical, as.numeric)$guilty
  ),
  mean(
    mutate_if(model_article_105_prison$model, is.logical, as.numeric)$prison
  ),
  mean(
    mutate_if(model_article_105_suspended$model, is.logical, as.numeric)$suspended
  )
)
format(round(model_article_105_means, 3), nsmall = 3) |> as.numeric()




## Article 159 ------


model_article_159_verdict_a <-
  plm(verdict ~ treated  + instance,
      data = panel_article_159, effect = "twoways")


model_article_159_verdict_b <-
  plm(verdict ~ treated  + instance + number_of_letters,
      panel_article_159,
      effect = "twoways")


model_article_159_guilty <-
  plm(guilty ~   treated  + number_of_letters + instance,
      data = panel_article_159,
      effect = "twoways")

model_article_159_prison <-
  plm(prison ~  treated  + number_of_letters + instance,
      data = panel_article_159,
      effect = "twoways")


model_article_159_suspended <-
  plm(suspended ~  treated  + number_of_letters + instance,
      data = panel_article_159,
      effect = "twoways")


m3 <-
  list(
    model_article_159_verdict_a,
    model_article_159_verdict_b,
    model_article_159_guilty,
    model_article_159_prison,
    model_article_159_suspended
  )




ses3 <- list(
  coeftest(
    model_article_159_verdict_a,
    vcov. = vcovDC(model_article_159_verdict_a,
                   type = "HC3")
  )[, 2],
  coeftest(
    model_article_159_verdict_b,
    vcov. = vcovDC(model_article_159_verdict_b,
                   type = "HC3")
  )[, 2],
  coeftest(
    model_article_159_guilty,
    vcov. = vcovDC(model_article_159_guilty,
                   type = "HC3")
  )[, 2],
  coeftest(
    model_article_159_prison,
    vcov. = vcovDC(model_article_159_prison,
                   type = "HC3")
  )[, 2],
  coeftest(
    model_article_159_suspended,
    vcov. = vcovDC(model_article_159_suspended,
                   type = "HC3")
  )[, 2]
)


stargazer(m3,
          se = ses3,
          df = F)



model_article_159_means <- c(
  mean(
    mutate_if(model_article_159_verdict_a$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(model_article_159_verdict_b$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(model_article_159_guilty$model, is.logical, as.numeric)$guilty
  ),
  mean(
    mutate_if(model_article_159_prison$model, is.logical, as.numeric)$prison
  ),
  mean(
    mutate_if(model_article_159_suspended$model, is.logical, as.numeric)$suspended
  )
)

format(round(model_article_159_means, 3), nsmall = 3) |> as.numeric()






## Article 228 ------

model_article_228_verdict_a <-
  plm(verdict ~ treated  + instance,
      data = panel_article_228, effect = "twoways")


model_article_228_verdict_b <-
  plm(verdict ~ treated  + instance + number_of_letters,
      panel_article_228,
      effect = "twoways")


model_article_228_guilty <-
  plm(guilty ~   treated  + number_of_letters + instance,
      data = panel_article_228,
      effect = "twoways")

model_article_228_prison <-
  plm(prison ~  treated  + number_of_letters + instance,
      data = panel_article_228,
      effect = "twoways")


model_article_228_suspended <-
  plm(suspended ~  treated  + number_of_letters + instance,
      data = panel_article_228,
      effect = "twoways")


m4 <-
  list(
    model_article_228_verdict_a,
    model_article_228_verdict_b,
    model_article_228_guilty,
    model_article_228_prison,
    model_article_228_suspended
  )




ses4 <- list(
  coeftest(
    model_article_228_verdict_a,
    vcov. = vcovSCC(
      model_article_228_verdict_a,
      type = "HC3",
      maxlag = 3
    )
  )[, 2],
  coeftest(
    model_article_228_verdict_b,
    vcov. = vcovDC(model_article_228_verdict_b,
                   type = "HC3")
  )[, 2],
  coeftest(
    model_article_228_guilty,
    vcov. = vcovDC(model_article_228_guilty,
                   type = "HC3")
  )[, 2],
  coeftest(
    model_article_228_prison,
    vcov. = vcovDC(model_article_228_prison,
                   type = "HC3")
  )[, 2],
  coeftest(
    model_article_228_suspended,
    vcov. = vcovHC(model_article_228_suspended,
                   type = "HC3")
  )[, 2]
)


stargazer(m4,
          se = ses4,
          df = F)




model_article_228_means <- c(
  mean(
    mutate_if(model_article_228_verdict_a$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(model_article_228_verdict_b$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(model_article_228_guilty$model, is.logical, as.numeric)$guilty
  ),
  mean(
    mutate_if(model_article_228_prison$model, is.logical, as.numeric)$prison
  ),
  mean(
    mutate_if(model_article_228_suspended$model, is.logical, as.numeric)$suspended
  )
)

format(round(model_article_228_means, 3), nsmall = 3) |> as.numeric()


# Diff-In-diff ------
did_panel_all_articles <-
  panel_all_articles |> filter(share_of_new != 1)

## All Articles ------
did_all_verdict_a <-
  plm(verdict ~ share_of_new * post + instance ,
      did_panel_all_articles,
      effect = "twoways")
did_all_verdict_b <-
  plm(
    verdict ~ share_of_new * post + instance + number_of_letters,
    did_panel_all_articles,
    effect = "twoways"
  )

did_all_guilty <-
  plm(
    guilty ~ share_of_new * post + instance + number_of_letters,
    did_panel_all_articles,
    effect = "twoways"
  )
summary(did_all_guilty)

did_all_prison <-
  plm(
    prison ~ share_of_new * post + instance + number_of_letters,
    did_panel_all_articles,
    effect = "twoways"
  )

did_all_suspended <-
  plm(
    suspended ~ share_of_new * post + instance + number_of_letters,
    did_panel_all_articles,
    effect = "twoways"
  )

did1 <-
  list(
    did_all_verdict_a,
    did_all_verdict_b,
    did_all_guilty,
    did_all_prison,
    did_all_suspended
  )


sedid1 <- list(
  coeftest(did_all_verdict_a,
           vcov. = vcovDC(did_all_verdict_a,
                          type = "HC3"))[, 2],
  coeftest(did_all_verdict_b,
           vcov. = vcovDC(did_all_verdict_b,
                          type = "HC3"))[, 2],
  coeftest(did_all_guilty,
           vcov. = vcovDC(did_all_guilty,
                          type = "HC3"))[, 2],
  coeftest(did_all_prison,
           vcov. = vcovDC(did_all_prison,
                          type = "HC3"))[, 2],
  coeftest(did_all_suspended,
           vcov. = vcovDC(did_all_suspended,
                          type = "HC3"))[, 2]
)
summary(did_all_suspended)



stargazer(did1,
          se = sedid1,
          df = F)




did_all_means <- c(
  mean(
    mutate_if(did_all_verdict_a$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(did_all_verdict_b$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(did_all_guilty$model, is.logical, as.numeric)$guilty
  ),
  mean(
    mutate_if(did_all_prison$model, is.logical, as.numeric)$prison
  ),
  mean(
    mutate_if(did_all_suspended$model, is.logical, as.numeric)$suspended
  )
)
format(round(did_all_means, 3), nsmall = 3) |> as.numeric()


## Article 105 ------

did_panel_article_105 <-
  panel_article_105 |> filter(share_of_new != 1)
did_105_verdict_a <-
  plm(verdict ~ share_of_new * post + instance ,
      did_panel_article_105,
      effect = "twoways")
did_105_verdict_b <-
  plm(
    verdict ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_105,
    effect = "twoways"
  )

did_105_guilty <-
  plm(
    guilty ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_105,
    effect = "twoways"
  )

did_105_prison <-
  plm(
    prison ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_105,
    effect = "twoways"
  )

did_105_suspended <-
  plm(
    suspended ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_105,
    effect = "twoways"
  )

did2 <-
  list(
    did_105_verdict_a,
    did_105_verdict_b,
    did_105_guilty,
    did_105_prison,
    did_105_suspended
  )


sedid2 <- list(
  coeftest(did_105_verdict_a,
           vcov. = vcovDC(did_105_verdict_a,
                          type = "HC3"))[, 2],
  coeftest(did_105_verdict_b,
           vcov. = vcovDC(did_105_verdict_b,
                          type = "HC3"))[, 2],
  coeftest(did_105_guilty,
           vcov. = vcovDC(did_105_guilty,
                          type = "HC3"))[, 2],
  coeftest(did_105_prison,
           vcov. = vcovDC(did_105_prison,
                          type = "HC3"))[, 2],
  coeftest(did_105_suspended,
           vcov. = vcovDC(did_105_suspended,
                          type = "HC3"))[, 2]
)




stargazer(did2,
          se = sedid2,
          df = F)





did_105_means <- c(
  mean(
    mutate_if(did_105_verdict_a$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(did_105_verdict_b$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(did_105_guilty$model, is.logical, as.numeric)$guilty
  ),
  mean(
    mutate_if(did_105_prison$model, is.logical, as.numeric)$prison
  ),
  mean(
    mutate_if(did_105_suspended$model, is.logical, as.numeric)$suspended
  )
)
format(round(did_105_means, 3), nsmall = 3) |> as.numeric()


## Article 159 ------


did_panel_article_159 <-
  panel_article_159 |> filter(share_of_new != 1)


did_159_verdict_a <-
  plm(verdict ~ share_of_new * post + instance ,
      did_panel_article_159,
      effect = "twoways")
did_159_verdict_b <-
  plm(
    verdict ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_159,
    effect = "twoways"
  )

did_159_guilty <-
  plm(
    guilty ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_159,
    effect = "twoways"
  )

did_159_prison <-
  plm(
    prison ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_159,
    effect = "twoways"
  )

did_159_suspended <-
  plm(
    suspended ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_159,
    effect = "twoways"
  )

did3 <-
  list(
    did_159_verdict_a,
    did_159_verdict_b,
    did_159_guilty,
    did_159_prison,
    did_159_suspended
  )


sedid3 <- list(
  coeftest(did_159_verdict_a,
           vcov. = vcovDC(did_159_verdict_a,
                          type = "HC3"))[, 2],
  coeftest(did_159_verdict_b,
           vcov. = vcovDC(did_159_verdict_b,
                          type = "HC3"))[, 2],
  coeftest(did_159_guilty,
           vcov. = vcovDC(did_159_guilty,
                          type = "HC3"))[, 2],
  coeftest(did_159_prison,
           vcov. = vcovDC(did_159_prison,
                          type = "HC3"))[, 2],
  coeftest(did_159_suspended,
           vcov. = vcovDC(did_159_suspended,
                          type = "HC3"))[, 2]
)




stargazer(did3,
          se = sedid3,
          df = F)




did_159_means <- c(
  mean(
    mutate_if(did_159_verdict_a$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(did_159_verdict_b$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(did_159_guilty$model, is.logical, as.numeric)$guilty
  ),
  mean(
    mutate_if(did_159_prison$model, is.logical, as.numeric)$prison
  ),
  mean(
    mutate_if(did_159_suspended$model, is.logical, as.numeric)$suspended
  )
)
format(round(did_159_means, 3), nsmall = 3) |> as.numeric()





## Article 228 ------

did_panel_article_228 <-
  panel_article_228 |> filter(share_of_new != 1)



did_228_verdict_a <-
  plm(verdict ~ share_of_new * post + instance ,
      did_panel_article_228,
      effect = "twoways")
did_228_verdict_b <-
  plm(
    verdict ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_228,
    effect = "twoways"
  )

did_228_guilty <-
  plm(
    guilty ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_228,
    effect = "twoways"
  )

did_228_prison <-
  plm(
    prison ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_228,
    effect = "twoways"
  )

did_228_suspended <-
  plm(
    suspended ~ share_of_new * post + instance + number_of_letters,
    did_panel_article_228,
    effect = "twoways"
  )

did4 <-
  list(
    did_228_verdict_a,
    did_228_verdict_b,
    did_228_guilty,
    did_228_prison,
    did_228_suspended
  )


sedid4 <- list(
  coeftest(did_228_verdict_a,
           vcov. = vcovDC(did_228_verdict_a,
                          type = "HC3"))[, 2],
  coeftest(did_228_verdict_b,
           vcov. = vcovDC(did_228_verdict_b,
                          type = "HC3"))[, 2],
  coeftest(did_228_guilty,
           vcov. = vcovDC(did_228_guilty,
                          type = "HC3"))[, 2],
  coeftest(did_228_prison,
           vcov. = vcovDC(did_228_prison,
                          type = "HC3"))[, 2],
  coeftest(did_228_suspended,
           vcov. = vcovDC(did_228_suspended,
                          type = "HC3"))[, 2]
)




stargazer(did4,
          se = sedid4,
          df = F)



did_228_means <- c(
  mean(
    mutate_if(did_228_verdict_a$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(did_228_verdict_b$model, is.logical, as.numeric)$verdict
  ),
  mean(
    mutate_if(did_228_guilty$model, is.logical, as.numeric)$guilty
  ),
  mean(
    mutate_if(did_228_prison$model, is.logical, as.numeric)$prison
  ),
  mean(
    mutate_if(did_228_suspended$model, is.logical, as.numeric)$suspended
  )
)
format(round(did_228_means, 3), nsmall = 3) |> as.numeric()






# Plots -----

## Pre-trends ------------------------------------

### All  ------

library(hrbrthemes)





pretrends_all_prison <- plm(
  prison ~ factor(year) * share_of_new +    instance + number_of_letters,
  data = did_panel_all_articles,
  effect = "twoways"
)

pretrends_all_prison_df <-
  data.frame(
    pretrends_all_prison$coefficients[10:15],
    coefci(
      pretrends_all_prison,
      parm = c(10:15),
      level = 0.95,
      vcov. = vcovDC(pretrends_all_prison,
                     type = "HC3")
    )
  )



plot_pretrends_prison_all <-
  ggplot(pretrends_all_prison_df,
         aes(x = c(2016:2021), y = pretrends_all_prison.coefficients.10.15.)) +
  geom_point() +
  geom_line() +
  geom_line(aes(y = X2.5..), linetype = "longdash") + geom_line(aes(y = X97.5..), linetype = "longdash") +
  labs(
    x = "Year",
    y = "Coefficient on Share of new × Year",
    title = "Panel A.",
    subtitle = "Impact of reform on Prison for All Articles sample",
    caption = ""
  ) +   geom_vline(xintercept = 2019.75 ,
                   linetype = 1,
                   color = "#800000FF") +
  geom_hline(yintercept = 0 ,
             linetype = 1,
             color = "#800000FF") +
  theme_minimal()
plot_pretrends_prison_all

### 105  ------

pretrends_105_verdict <- plm(
  verdict ~ factor(year) * share_of_new +   instance + number_of_letters,
  data = did_panel_article_105,
  effect = "twoways"
)

pretrends_105_verdict_df <-
  data.frame(
    pretrends_105_verdict$coefficients[10:15],
    coefci(
      pretrends_105_verdict,
      parm = c(10:15),
      level = 0.95,
      vcov. = vcovDC(pretrends_105_verdict,
                     type = "HC3")
    )
  )


plot_pretrends_105_verdict <-
  ggplot(pretrends_105_verdict_df,
         aes(x = c(2016:2021), y = pretrends_105_verdict.coefficients.10.15.)) +
  geom_point() +
  geom_line() +
  geom_line(aes(y = X2.5..), linetype = "longdash") +
  geom_line(aes(y = X97.5..), linetype = "longdash") +
  geom_hline(yintercept = 0,
             linetype = 1,
             color = "#800000FF") +
  geom_vline(xintercept = 2019.75 ,
             linetype = 1,
             color = "#800000FF") +  labs(
               x = "Year",
               y = "Share of new × Year",
               title = "Panel B.",
               subtitle = "Impact of reform on Verdict for Homicide sample",
               caption =
                 ""
             ) + theme_minimal()

plot_pretrends_105_verdict



pretrends_105_guilty <- plm(
  guilty ~ factor(year) * share_of_new +   instance + number_of_letters,
  data = did_panel_article_105,
  effect = "twoways"
)

pretrends_105_guilty_df <-
  data.frame(
    pretrends_105_guilty$coefficients[10:15],
    coefci(
      pretrends_105_guilty,
      parm = c(10:15),
      level = 0.95,
      vcov. = vcovDC(pretrends_105_guilty,
                     type = "HC3")
    )
  )

plot_pretrends_105_guilty <-
  ggplot(pretrends_105_guilty_df,
         aes(x = c(2016:2021), y = pretrends_105_guilty.coefficients.10.15.)) +
  geom_point() +
  geom_line() +
  geom_line(aes(y = X2.5..), linetype = "longdash") +
  geom_line(aes(y = X97.5..), linetype = "longdash") +
  geom_hline(yintercept = 0,
             linetype = 1,
             color = "#800000FF") +
  geom_vline(xintercept = 2019.75 ,
             linetype = 1,
             color = "#800000FF") +  labs(
               x = "Year",
               y = "Share of new × Year",
               title = "Panel C.",
               subtitle = "Impact of reform on Guilty for Homicide sample",
               caption =
                 ""
             ) + theme_minimal()

plot_pretrends_105_guilty




pretrends_105_prison <- plm(
  prison ~ factor(year) * share_of_new +   instance + number_of_letters,
  data = did_panel_article_105,
  effect = "twoways"
)

pretrends_105_prison_df <-
  data.frame(
    pretrends_105_prison$coefficients[10:15],
    coefci(
      pretrends_105_prison,
      parm = c(10:15),
      level = 0.95,
      vcov. = vcovDC(pretrends_105_prison,
                     type = "HC3")
    )
  )

plot_pretrends_105_prison <-
  ggplot(pretrends_105_prison_df,
         aes(x = c(2016:2021), y = pretrends_105_prison.coefficients.10.15.)) +
  geom_point() +
  geom_line() +
  geom_line(aes(y = X2.5..), linetype = "longdash") +
  geom_line(aes(y = X97.5..), linetype = "longdash") +
  geom_hline(yintercept = 0,
             linetype = 1,
             color = "#800000FF") +
  geom_vline(xintercept = 2019.75 ,
             linetype = 1,
             color = "#800000FF") +  labs(
               x = "Year",
               y = "Share of new × Year",
               title = "Panel D.",
               subtitle = "Impact of reform on Prison for Homicide sample",
               caption =
                 ""
             ) + theme_minimal()

plot_pretrends_105_prison

### 228  ------



pretrends_228_suspended <- plm(
  suspended ~ factor(year) * share_of_new +   instance + number_of_letters,
  data = did_panel_article_228,
  effect = "twoways"
)

pretrends_228_suspended_df <-
  data.frame(
    pretrends_228_suspended$coefficients[10:15],
    coefci(
      pretrends_228_suspended,
      parm = c(10:15),
      level = 0.95,
      vcov. = vcovDC(pretrends_228_suspended,
                     type = "HC3")
    )
  )

plot_pretrends_228_suspended <-
  ggplot(pretrends_228_suspended_df,
         aes(x = c(2016:2021), y = pretrends_228_suspended.coefficients.10.15.)) +
  geom_point() +
  geom_line() +
  geom_line(aes(y = X2.5..), linetype = "longdash") +
  geom_line(aes(y = X97.5..), linetype = "longdash") +
  geom_hline(yintercept = 0,
             linetype = 1,
             color = "#800000FF") +
  geom_vline(xintercept = 2019.75 ,
             linetype = 1,
             color = "#800000FF") +  labs(
               x = "Year",
               y = "Share of new × Year",
               title = "Panel E.",
               subtitle = "Impact of reform on Suspended for Drugs sample",
               caption =
                 ""
             ) + theme_minimal()

plot_pretrends_228_suspended



### Final ----
library(gridExtra)

grid.arrange(
  plot_pretrends_prison_all,
  plot_pretrends_105_verdict,
  plot_pretrends_105_guilty,
  plot_pretrends_105_prison,
  plot_pretrends_228_suspended,
  ncol = 2,
  nrow = 3
)
