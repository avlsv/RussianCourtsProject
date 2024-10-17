# This file uploads the data into Spark Environment
# 


setwd("/Users/vlasov/Desktop/macOS-x64.sudrfscraper/results")

library(sparklyr)
library(arrow)

#sc <- spark_connect(master = "local")

# Adygea ----

Adygea_sp <- spark_read_json(sc, "Adygea", "Adygea/Adygea.json")

# Altai_Krai ----

Altai_Krai_sp <-
  spark_read_json(sc, "Altai_Krai", "Altai Krai/Altai Krai.json")

# Altai_Republic ----

Altai_Republic_sp <-
  spark_read_json(sc, "Altai_Republic", "Altai Republic/Altai Republic.json")

# Bashkortostan ----

Bashkortostan_sp <-
  spark_read_json(sc, "Bashkortostan", "Bashkortostan/Bashkortostan.json")

# Buryatia ----

Buryatia_sp <-
  spark_read_json(sc, "Buryatia", "Buryatia/Buryatia.json")

# Chelyabinsk_Oblast ----

Chelyabinsk_Oblast_sp <-
  spark_read_json(sc,
                  "Chelyabinsk_Oblast",
                  "Chelyabinsk Oblast/Chelyabinsk Oblast.json")

# Chuvashia ----

Chuvashia_sp <-
  spark_read_json(sc, "Chuvashia", "Chuvashia/Chuvashia.json")

# Chukotka ----

Chukotka_sp <-
  spark_read_json(sc,
                  "Chukotka",
                  "Chukotka Autonomous Okrug/Chukotka Autonomous Okrug.json")

# Dagestan ----

Dagestan_sp <-
  spark_read_json(sc, "Dagestan", "Dagestan/Dagestan.json")

# Ingushetia ----

Ingushetia_sp <-
  spark_read_json(sc, "Ingushetia", "Ingushetia/Ingushetia.json")


# Jewish_Autonomous_Oblast ----

Jewish_Autonomous_Oblast_sp <-
  spark_read_json(
    sc,
    "Jewish_Autonomous_Oblast",
    "Jewish Autonomous Oblast/Jewish Autonomous Oblast.json"
  )

# Kabardino_Balkaria ----

Kabardino_Balkaria_sp <-
  spark_read_json(sc,
                  "Kabardino_Balkaria",
                  "Kabardino-Balkaria/Kabardino-Balkaria.json")

# Kalmykia ----

Kalmykia_sp <-
  spark_read_json(sc, "Kalmykia", "Kalmykia/Kalmykia.json")

# Kamchatka_Krai ----

Kamchatka_Krai_sp <-
  spark_read_json(sc, "Kamchatka_Krai", "Kamchatka Krai/Kamchatka Krai.json")

# Karachay_Cherkessia ----

Karachay_Cherkessia_sp <-
  spark_read_json(sc,
                  "Karachay_Cherkessia",
                  "Karachay-Cherkessia/Karachay-Cherkessia.json")

# Karachay_Cherkessia ----

Karelia_sp <- spark_read_json(sc, "Karelia", "Karelia/Karelia.json")

# Khabarovsk_Krai ----

Khabarovsk_Krai_sp <-
  spark_read_json(sc, "Khabarovsk_Krai", "Khabarovsk Krai/Khabarovsk Krai.json")

# Khakassia ----

Khakassia_sp <-
  spark_read_json(sc, "Khakassia", "Khakassia/Khakassia.json")

#Khanty_Mansi ----

Khanty_Mansi_sp <-
  spark_read_json(
    sc,
    "Khanty_Mansi",
    "Khanty-Mansi Autonomous Okrug - Yugra/Khanty-Mansi Autonomous Okrug - Yugra.json"
  )

#Komi_Republic ----

Komi_Republic_sp <-
  spark_read_json(sc, "Komi_Republic", "Komi Republic/Komi Republic.json")

#Krasnodar_Krai ----


Krasnodar_Krai_sp <-
  spark_read_json(sc, "Krasnodar_Krai", "Krasnodar Krai/Krasnodar Krai.json")

#Krasnoyarsk_Krai ----

Krasnoyarsk_Krai_sp <-
  spark_read_json(sc,
                  "Krasnoyarsk_Krai",
                  "Krasnoyarsk Krai/Krasnoyarsk Krai.json")

#Mari_El ----

Mari_El_sp <- spark_read_json(sc, "Mari_El", "Mari El/Mari El.json")

#Mordovia ----

Mordovia_sp <-
  spark_read_json(sc, "Mordovia", "Mordovia/Mordovia.json")

#Moscow ----

Moscow_sp <- spark_read_json(sc, "Moscow", "Moscow/Moscow.json")

#Moscow_Oblast ----

Moscow_Oblast_sp <-
  spark_read_json(sc, "Moscow_Oblast", "Moscow Oblast/Moscow Oblast.json")

#Nenets_Autonomous_Okrug ----

Nenets_Autonomous_Okrug_sp <-
  spark_read_json(
    sc,
    "Nenets_Autonomous_Okrug",
    "Nenets Autonomous Okrug/Nenets Autonomous Okrug.json"
  )

#North_Ossetia ----

North_Ossetia_sp <-
  spark_read_json(sc,
                  "North_Ossetia",
                  "North Ossetia–Alania/North Ossetia–Alania.json")

#Perm_Krai ----

Perm_Krai_sp <-
  spark_read_json(sc, "Perm_Krai", "Perm Krai/Perm Krai.json")

#Primorsky_Krai ----

Primorsky_Krai_sp <-
  spark_read_json(sc, "Primorsky_Krai", "Primorsky Krai/Primorsky Krai.json")

#Saint_Petersburg ----

Saint_Petersburg_sp <-
  spark_read_json(sc,
                  "Saint_Petersburg",
                  "Saint Petersburg/Saint Petersburg.json")

#Yakutia ----

Yakutia_sp <-
  spark_read_json(sc, "Yakutia", "Sakha (Yakutia)/Sakha (Yakutia).json")

# Stavropol_Krai ----

Stavropol_Krai_sp <-
  spark_read_json(sc, "Stavropol_Krai", "Stavropol Krai/Stavropol Krai.json")

# Tatarstan ----

Tatarstan_sp <-
  spark_read_json(sc, "Tatarstan", "Tatarstan/Tatarstan.json")

# Tuva ----

Tuva_sp <- spark_read_json(sc, "Tuva", "Tuva/Tuva.json")

# Udmurtia ----

Udmurtia_sp <-
  spark_read_json(sc, "Udmurtia", "Udmurtia/Udmurtia.json")

# Ulyanovsk_Oblast ----

Ulyanovsk_Oblast_sp <-
  spark_read_json(sc,
                  "Ulyanovsk_Oblast",
                  "Ulyanovsk Oblast/Ulyanovsk Oblast.json")

# Yamalo_Nenets ----

Yamalo_Nenets_sp <-
  spark_read_json(
    sc,
    "Yamalo_Nenets",
    "Yamalo-Nenets Autonomous Okrug/Yamalo-Nenets Autonomous Okrug.json"
  )

# Yaroslavl_Oblast----

Yaroslavl_Oblast_sp <-
  spark_read_json(sc,
                  "Yaroslavl_Oblast",
                  "Yaroslavl Oblast/Yaroslavl Oblast.json")

# Zabaykalsky_Krai ----

Zabaykalsky_Krai_sp <-
  spark_read_json(sc,
                  "Zabaykalsky_Krai",
                  "Zabaykalsky Krai/Zabaykalsky Krai.json")




#tbl(sc, "North_Ossetia")

# Federation ---
federation_sp <-
  sdf_bind_rows(
    Adygea_sp,
    Altai_Krai_sp,
    Altai_Republic_sp,
    Bashkortostan_sp,
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
    Stavropol_Krai_sp,
    Tatarstan_sp,
    Tuva_sp,
    Udmurtia_sp,
    Ulyanovsk_Oblast_sp,
    Yamalo_Nenets_sp,
    Yaroslavl_Oblast_sp,
    Zabaykalsky_Krai_sp
  )

federation <-  federation_sp |> filter(to_date(endDate, "dd.mm.yyyy") < "2022-01-01")

save(list=ls(), 
     file = file.path("cachedData.Rda"))
