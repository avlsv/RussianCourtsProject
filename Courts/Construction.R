






# libraries -------------------------------------------------------------------


library(stats)      # Simple statistical functions
library(tidyverse)  # Data managing
library(jsonlite)
library(callr)
library(stringr)
options(max.print = 1000)
library(sparklyr)
library(dbplyr)

#require(remotes)
#install_version("dbplyr", version = "2.3.0", repos = "http://cran.us.r-project.org")


setwd("/Volumes/HD/results")
#spark_install(version = 3.4)

#sc <- spark_connect(master = "local")

# Set memory allocation for whole local Spark instance
Sys.setenv("SPARK_MEM" = "13g")

# Set driver and executor memory allocations
config <- spark_config()
config$spark.driver.memory <- "4G"
config$spark.executor.memory <- "1G"
config$`sparklyr.shell.driver-memory` <- "4G"
config$`sparklyr.shell.executor-memory` <- "4G"
config$`spark.yarn.executor.memoryOverhead` <- "1g"

sc <- spark_connect(master = "local", config = config)




# Regions Reading -----


## Adygea ----

Adygea_sp <- spark_read_json(sc, "Adygea", "Adygea/Adygea.json")

## Altai_Krai ----

Altai_Krai_sp <-
  spark_read_json(sc, "Altai_Krai", "Altai Krai/Altai Krai.json")

## Altai_Republic ----

Altai_Republic_sp <-
  spark_read_json(sc, "Altai_Republic", "Altai Republic/Altai Republic.json")


## Amur_Oblast ----

Amur_Oblast_sp <-
  spark_read_json(sc, "Amur_Oblast", "Amur Oblast/Amur Oblast.json")


## Arkhangelsk_Oblast ----

Arkhangelsk_Oblast_sp <-
  spark_read_json(sc,
                  "Arkhangelsk_Oblast",
                  "Arkhangelsk Oblast/Arkhangelsk Oblast.json")

## Astrakhan Oblast ----

Astrakhan_Oblast_sp <-
  spark_read_json(sc,
                  "Astrakhan_Oblast",
                  "Astrakhan Oblast/Astrakhan Oblast.json")


## Bashkortostan ----

Bashkortostan_sp <-
  spark_read_json(sc, "Bashkortostan", "Bashkortostan/Bashkortostan.json")


## Belgorod Oblast ----

Belgorod_Oblast_sp <-
  spark_read_json(sc, "Belgorod_Oblast", "Belgorod Oblast/Belgorod Oblast.json")


## Bryansk Oblast ----

Bryansk_Oblast_sp <-
  spark_read_json(sc, "Bryansk_Oblast", "Bryansk Oblast/Bryansk Oblast.json")


## Buryatia ----

Buryatia_sp <-
  spark_read_json(sc, "Buryatia", "Buryatia/Buryatia.json")

## Chelyabinsk_Oblast ----

Chelyabinsk_Oblast_sp <-
  spark_read_json(sc,
                  "Chelyabinsk_Oblast",
                  "Chelyabinsk Oblast/Chelyabinsk Oblast.json")


## Chukotka ----

Chukotka_sp <-
  spark_read_json(sc,
                  "Chukotka",
                  "Chukotka Autonomous Okrug/Chukotka Autonomous Okrug.json")

## Chuvashia ----

Chuvashia_sp <-
  spark_read_json(sc, "Chuvashia", "Chuvashia/Chuvashia.json")

## Dagestan ----

Dagestan_sp <-
  spark_read_json(sc, "Dagestan", "Dagestan/Dagestan.json")

## Ingushetia ----

Ingushetia_sp <-
  spark_read_json(sc, "Ingushetia", "Ingushetia/Ingushetia.json")


## Jewish_Autonomous_Oblast ----

Jewish_Autonomous_Oblast_sp <-
  spark_read_json(
    sc,
    "Jewish_Autonomous_Oblast",
    "Jewish Autonomous Oblast/Jewish Autonomous Oblast.json"
  )

## Kabardino_Balkaria ----

Kabardino_Balkaria_sp <-
  spark_read_json(sc,
                  "Kabardino_Balkaria",
                  "Kabardino-Balkaria/Kabardino-Balkaria.json")

## Kaliningrad oblast ----
Kaliningrad_Oblast_sp <-
  spark_read_json(sc,
                  "Kaliningrad_Oblast",
                  "Kaliningrad Oblast/Kaliningrad Oblast.json")


## Kalmykia ----

Kalmykia_sp <-
  spark_read_json(sc, "Kalmykia", "Kalmykia/Kalmykia.json")

## Kaluga Oblast ----

Kaluga_Oblast_sp <-
  spark_read_json(sc, "Kaluga_Oblast", "Kaluga Oblast/Kaluga Oblast.json")

## Kamchatka_Krai ----

Kamchatka_Krai_sp <-
  spark_read_json(sc, "Kamchatka_Krai", "Kamchatka Krai/Kamchatka Krai.json")

## Karachay_Cherkessia ----

Karachay_Cherkessia_sp <-
  spark_read_json(sc,
                  "Karachay_Cherkessia",
                  "Karachay-Cherkessia/Karachay-Cherkessia.json")

## Karelia ----

Karelia_sp <- spark_read_json(sc, "Karelia", "Karelia/Karelia.json")


## Kemerovo Oblast -----

Kemerovo_Oblast_sp <- spark_read_json(sc, "Kemerovo_Oblast", "Kemerovo Oblast/Kemerovo Oblast.json")


## Khabarovsk_Krai ----

Khabarovsk_Krai_sp <-
  spark_read_json(sc, "Khabarovsk_Krai", "Khabarovsk Krai/Khabarovsk Krai.json")



## Khakassia ----

Khakassia_sp <-
  spark_read_json(sc, "Khakassia", "Khakassia/Khakassia.json")

## Khanty_Mansi ----

Khanty_Mansi_sp <-
  spark_read_json(
    sc,
    "Khanty_Mansi",
    "Khanty-Mansi Autonomous Okrug - Yugra/Khanty-Mansi Autonomous Okrug - Yugra.json"
  )

## Kirov Oblast ----

Kirov_Oblast_sp <- spark_read_json(sc, "Kirov_Oblast", "Kirov Oblast/Kirov Oblast.json")


## Komi_Republic ----

Komi_Republic_sp <-
  spark_read_json(sc, "Komi_Republic", "Komi Republic/Komi Republic.json")

## Kostroma Oblast ----

Kostroma_Oblast_sp <- spark_read_json(sc, "Kostroma_Oblast", "Kostroma Oblast/Kostroma Oblast.json")


## Krasnodar_Krai ----

Krasnodar_Krai_sp <-
  spark_read_json(sc, "Krasnodar_Krai", "Krasnodar Krai/Krasnodar Krai.json")

## Krasnoyarsk_Krai ----

Krasnoyarsk_Krai_sp <-
  spark_read_json(sc,
                  "Krasnoyarsk_Krai",
                  "Krasnoyarsk Krai/Krasnoyarsk Krai.json")

## Kurgan Oblast -----

Kurgan_Oblast_sp <- spark_read_json(sc, "Kurgan_Oblast", "Kurgan Oblast/Kurgan Oblast.json")


## Kursk Oblast -----

Kursk_Oblast_sp <- spark_read_json(sc, "Kursk_Oblast", "Kursk Oblast/Kursk Oblast.json")


## Leningrad Oblast -----

Leningrad_Oblast_sp <- spark_read_json(sc, "Leningrad_Oblast", "Leningrad Oblast/Leningrad Oblast.json")


## Lipetsk Oblast -----

Lipetsk_Oblast_sp <- spark_read_json(sc, "Lipetsk_Oblast", "Lipetsk Oblast/Lipetsk Oblast.json")


## Magadan Oblast -----

Magadan_Oblast_sp <- spark_read_json(sc, "Magadan_Oblast", "Magadan Oblast/Magadan Oblast.json")



## Mari_El ----


Mari_El_sp <- spark_read_json(sc, "Mari_El", "Mari El/Mari El.json")

## Mordovia ----

Mordovia_sp <-
  spark_read_json(sc, "Mordovia", "Mordovia/Mordovia.json")

## Moscow ----

Moscow_sp <- spark_read_json(sc, "Moscow", "Moscow/Moscow.json")

## Moscow_Oblast ----

Moscow_Oblast_sp <-
  spark_read_json(sc, "Moscow_Oblast", "Moscow Oblast/Moscow Oblast.json")

## Nenets_Autonomous_Okrug ----

Nenets_Autonomous_Okrug_sp <-
  spark_read_json(
    sc,
    "Nenets_Autonomous_Okrug",
    "Nenets Autonomous Okrug/Nenets Autonomous Okrug.json"
  )

## North_Ossetia ----

North_Ossetia_sp <-
  spark_read_json(sc,
                  "North_Ossetia",
                  "North Ossetia–Alania/North Ossetia–Alania.json")

## Perm_Krai ----

Perm_Krai_sp <-
  spark_read_json(sc, "Perm_Krai", "Perm Krai/Perm Krai.json")

## Primorsky_Krai ----

Primorsky_Krai_sp <-
  spark_read_json(sc, "Primorsky_Krai", "Primorsky Krai/Primorsky Krai.json")

## Saint_Petersburg ----

Saint_Petersburg_sp <-
  spark_read_json(sc,
                  "Saint_Petersburg",
                  "Saint Petersburg/Saint Petersburg.json")

## (Sakha) Yakutia ----

Yakutia_sp <-
  spark_read_json(sc, "Yakutia", "Sakha (Yakutia)/Sakha (Yakutia).json")


## Sakhalin Oblast -----

Sakhalin_Oblast_sp <-
  spark_read_json(sc, "Sakhalin_Oblast", "Sakhalin Oblast/Sakhalin Oblast.json")



## Samara Oblast -----

Samara_Oblast_sp <-
  spark_read_json(sc, "Samara_Oblast", "Samara Oblast/Samara Oblast.json")


## Saratov Oblast -----

Saratov_Oblast_sp <-
  spark_read_json(sc, "Saratov_Oblast", "Saratov Oblast/Saratov Oblast.json")

## Smolensk Oblast -----

Smolensk_Oblast_sp <-
  spark_read_json(sc, "Smolensk_Oblast", "Smolensk Oblast/Smolensk Oblast.json")


## Stavropol_Krai ----

Stavropol_Krai_sp <-
  spark_read_json(sc, "Stavropol_Krai", "Stavropol Krai/Stavropol Krai.json")


## Sverdlovsk Oblast-----

Sverdlovsk_Oblast_sp <-
  spark_read_json(sc,
                  "Sverdlovsk_Oblast",
                  "Sverdlovsk Oblast/Sverdlovsk Oblast.json")


## Tambov Oblast-----

Tambov_Oblast_sp <-
  spark_read_json(sc, "Tambov_Oblast", "Tambov Oblast/Tambov Oblast.json")

## Tatarstan ----

Tatarstan_sp <-
  spark_read_json(sc, "Tatarstan", "Tatarstan/Tatarstan.json")


## Tomsk Oblast ----

Tomsk_Oblast_sp <-
  spark_read_json(sc, "Tomsk_Oblast", "Tomsk Oblast/Tomsk Oblast.json")

## Tula Oblast ----

Tula_Oblast_sp <-
  spark_read_json(sc, "Tula_Oblast", "Tula Oblast/Tula Oblast.json")



## Tuva ----

Tuva_sp <- spark_read_json(sc, "Tuva", "Tuva/Tuva.json")

## Tyumen Oblast ----

Tyumen_Oblast_sp <-
  spark_read_json(sc, "Tyumen_Oblast", "Tyumen Oblast/Tyumen Oblast.json")



## Udmurtia ----

Udmurtia_sp <-
  spark_read_json(sc, "Udmurtia", "Udmurtia/Udmurtia.json")

## Ulyanovsk_Oblast ----

Ulyanovsk_Oblast_sp <-
  spark_read_json(sc,
                  "Ulyanovsk_Oblast",
                  "Ulyanovsk Oblast/Ulyanovsk Oblast.json")

## Vladimir Oblast ----

Vladimir_Oblast_sp <-
  spark_read_json(sc,
                  "Vladimir_Oblast",
                  "Vladimir Oblast/Vladimir Oblast.json")
## Volgograd Oblast -----

Volgograd_Oblast_sp <-
  spark_read_json(sc,
                  "Volgograd_Oblast",
                  "Volgograd Oblast/Volgograd Oblast.json")

## Vologda Oblast ------
Vologda_Oblast_sp <-  spark_read_json(sc,
                                      "Vologda_Oblast",
                                      "Vologda Oblast/Vologda Oblast.json")

## Yamalo_Nenets ----

Yamalo_Nenets_sp <-
  spark_read_json(
    sc,
    "Yamalo_Nenets",
    "Yamalo-Nenets Autonomous Okrug/Yamalo-Nenets Autonomous Okrug.json"
  )

## Yaroslavl_Oblast----

Yaroslavl_Oblast_sp <-
  spark_read_json(sc,
                  "Yaroslavl_Oblast",
                  "Yaroslavl Oblast/Yaroslavl Oblast.json")

## Zabaykalsky_Krai ----

Zabaykalsky_Krai_sp <-
  spark_read_json(sc,
                  "Zabaykalsky_Krai",
                  "Zabaykalsky Krai/Zabaykalsky Krai.json")




## Federation Creation -----
federation_sp <-
  sdf_bind_rows(
    Adygea_sp,
    Altai_Krai_sp,
    Altai_Republic_sp,
    Amur_Oblast_sp,
    Arkhangelsk_Oblast_sp,
    Astrakhan_Oblast_sp,
    Bashkortostan_sp,
    Belgorod_Oblast_sp,
    Buryatia_sp,
    Chelyabinsk_Oblast_sp,
    Chukotka_sp,
    Chuvashia_sp,
    Dagestan_sp,
    Ingushetia_sp,
    Jewish_Autonomous_Oblast_sp,
    Kabardino_Balkaria_sp,
    Kalmykia_sp,
    Kamchatka_Krai_sp,
    Karachay_Cherkessia_sp,
    Karelia_sp,
    Khabarovsk_Krai_sp,
    Khakassia_sp,
    Khanty_Mansi_sp,
    Komi_Republic_sp,
    Krasnodar_Krai_sp,
    Krasnoyarsk_Krai_sp,
    Mari_El_sp,
    Mordovia_sp,
    Moscow_sp,
    Moscow_Oblast_sp,
    Nenets_Autonomous_Okrug_sp,
    North_Ossetia_sp,
    Perm_Krai_sp,
    Primorsky_Krai_sp,
    Saint_Petersburg_sp,
    Yakutia_sp,
    Sakhalin_Oblast_sp,
    Samara_Oblast_sp,
    Saratov_Oblast_sp,
    Smolensk_Oblast_sp,
    Stavropol_Krai_sp,
    Sverdlovsk_Oblast_sp,
    Tambov_Oblast_sp,
    Tatarstan_sp,
    Tomsk_Oblast_sp,
    Tula_Oblast_sp,
    Tuva_sp,
    Tyumen_Oblast_sp,
    Udmurtia_sp,
    Ulyanovsk_Oblast_sp,
    Vladimir_Oblast_sp,
    Volgograd_Oblast_sp,
    Vologda_Oblast_sp,
    Yamalo_Nenets_sp,
    Yaroslavl_Oblast_sp,
    Zabaykalsky_Krai_sp
  )





#spark_write_table(maindatabase, "maindatabase")


# Main Code ------

## Variables Creation ------

federation <-  sdf_register(federation_sp, "1federation")

maindatabase <-
  federation |> filter(decision == "Вынесен ПРИГОВОР" |
                         decision == "Уголовное дело ПРЕКРАЩЕНО")



treatment_added <-
  maindatabase |>  group_by(judge)  |>
  mutate(
    career_start = min(to_date(endDate, "dd.MM.yyyy"), na.rm = T) ,
    treated = min(to_date(endDate, "dd.MM.yyyy"), na.rm = T) >= "2019-09-01"
  ) |> ungroup()



#sdf_register(maindatabase, "1maindatabase")



variables_added <- treatment_added |>
  filter(
    to_date(endDate, "dd.MM.yyyy") < "2022-01-01" &
      to_date(endDate, "dd.MM.yyyy") > "2015-01-01"
  ) |> mutate(
    post = to_date(endDate, "dd.mm.yyyy") > "2019-09-01",
    verdict = (decision == "Вынесен ПРИГОВОР"),
    guilty = (decision == "Вынесен ПРИГОВОР") &
      (grepl("(?i)виновным" , text) | grepl("(?i)виновной" , text)),
    prison = (decision == "Вынесен ПРИГОВОР") &
      (grepl("(?i)виновным" , text) |
         grepl("(?i)виновной" , text)) &
      (
        grepl("(?i)лишения (?i)свободы" , text) |
          grepl("(?i)лишение (?i)свободы" , text)
      ) &
      !((grepl("(?i)условным" , text)) |
          grepl("(?i)условный" , text) |
          grepl("(?i)условное" , text)
      ),
    suspended = (decision == "Вынесен ПРИГОВОР")  &
      (grepl("(?i)виновным" , text) |
         grepl("(?i)виновной" , text)) &
      (
        grepl("(?i)лишения (?i)свободы" , text) |
          grepl("(?i)лишение (?i)свободы" , text)
      )
    &
      ((grepl(
        "(?i)условным" , text
      )) | grepl("(?i)условный" , text)),
    number_of_letters = nchar(text) / 1000
  )


treatment_added_1 <- variables_added |> group_by(name) |>
  mutate(share_of_new = mean(as.numeric(treated))) |> ungroup()

final <- sdf_register(treatment_added_1, "final")
#sdf_ncol(final)

## Summary Statistics -----
# 
# 
summary_stat_1 <-
  federation_sp |> filter(
    to_date(endDate, "dd.MM.yyyy") < "2022-01-01" &
      to_date(endDate, "dd.MM.yyyy") > "2015-01-01"
  )  |> group_by(decision) |> summarize(n = n()) |> mutate(share =  n / sum(n) * 100) |> arrange(-n) |> collect()

summary_stat_2 <-
  final |> select(guilty,prison, suspended) |> summarize(
    n = sum(as.numeric(!is.na(guilty))),
    n_guilty = sum(as.numeric(guilty), na.rm = T),
    n_prison = sum(as.numeric(prison), na.rm = T),
    n_suspended = sum(as.numeric(suspended), na.rm = T)
  ) |> collect()
#   


## Dataset Creation -----
setwd(
  "~/Library/CloudStorage/GoogleDrive-avlasov@nes.ru/My Drive/Техать тут!/MAE Development/Courts"
)
set.seed(20)


### all_articles ------
all_articles <-
  final  |> select(!text) |> sample_n(30000) |> collect()

write.csv(all_articles, "all_articles.csv")

### article_105 ------

article_105 <-
  final |> select(!text) |> filter(grepl("105" , names)) |> sample_n(30000) |> collect()
write.csv(article_105, "article_105.csv")


### article_159 ------

article_159 <-
  final |> select(!text) |> filter(grepl("159" , names))  |> sample_n(30000) |> collect()

write.csv(article_159, "article_159.csv")



### article_228 ------

article_228 <-
  final  |> select(!text) |> filter(grepl("228" , names)) |> sample_n(30000) |> collect()
write.csv(article_228, "article_228.csv")

