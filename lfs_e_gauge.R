library(echarts4r)
library(echarts4r.assets)
library(readxl)
library(dplyr)
library(tidyr)
library(data.table)

# Import Data
lfs_2014_2021 <- read_xls("lfs_2014_2021.xls")
lfs_2014_2021$year <- as.factor(lfs_2014_2021$year)

# Data Wrangling
lfs_economic_activity <- lfs_2014_2021 %>% 
  select(year, month, agriculture_n:services_rate) %>% 
  filter(year %in% c(2021), month == "8") %>% 
  mutate(month = case_when(month == "8" ~ "August")) %>% 
  setnames(old = c("agriculture_n", "industry_n", "services_n", "constraction_n"),
           new = c("Agriculture", "Industry", "Services", "Constraction"))

# Plot gauge
lfs_economic_activity %>% 
  e_charts() %>%
  e_title(text = "Economic Activity Distribution in Turkey",
          subtext = "LFS, August 2021",
          left = "center") %>% 
  e_gauge(lfs_economic_activity$agriculture_rate[1], name = "Agriculture",
          center = c(150, 170), radius = "130",
          detail  = list(formatter = "{value}%")) %>% 
  e_gauge(lfs_economic_activity$industry_rate[1], name = "Industry",
          center = c(430, 170), radius = "130",
          detail  = list(formatter = "{value}%")) %>% 
  e_gauge(lfs_economic_activity$constraction_rate[1], name = "Constraction",
          center = c(150, 400), radius = "130",
          detail  = list(formatter = "{value}%")) %>% 
  e_gauge(lfs_economic_activity$services_rate[1], name = "Services",
          center = c(430, 400), radius = "130",
          detail  = list(formatter = "{value}%")) %>% 
  e_color(background = "yellow") %>% 
  e_theme("westeros")



