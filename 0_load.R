library(bigrquery)
library(DBI)
library(dplyr)

billing <- 'ai-report-270817'
con <- dbConnect(
  bigrquery::bigquery(),
  project = "patents-public-data",
  dataset = 'uspto_oce_ai',
  billing = billing
)

con
dbListTables(con)

landscape <- tbl(con, 'landscape')

landscape %>% 
  filter(predict50_any_ai == 1) %>% 
  select(appl_id, contains('predict')) %>% 
  head(10) %>% 
  collect()
