library(tidyverse)
library(ggplot2)

ACNC.df <- read.csv("datadotgov_ais19 (1).csv")

ACNC.lite.df <- ACNC.df %>%
  select(total.full.time.equivalent.staff, total.full.time.equivalent.staff, total.comprehensive.income, 
         net.surplus.deficit, employee.expenses, revenue.from.government, basic.religious.charity, 
         research, staff...volunteers, staff...full.time, staff...part.time, 
         revenue.from.goods.and.services, sports, environmental.activities, total.revenue)

ACNC.lite.df %>%
  filter(total.full.time.equivalent.staff < 20000) %>% #removing two outliers where data is obviously wrong
ggplot(aes(x = total.full.time.equivalent.staff, 
           y = revenue.from.goods.and.services,
           color = research)) +
  geom_point() +
  geom_smooth(method=loess, se= FALSE)+
  labs(title = "Total staff and self-generated income in Australian NFPs", 
       subtitle = "Prepared by Campbell McNolty", x = "Total FTE staff", 
       y = "Revenue from Goods and Services (AUD)", caption = "Data: ACNC 2019 Annual Information Statement Data", 
       color = "Research Organisations")+
  scale_y_continuous(name = "Revenue from Goods and Services (AUD)", 
                     breaks = c(500000000, 1000000000, 1500000000), labels = c("500m", "1,000m", "1,500m")) +
  scale_color_hue(labels = c("Non-Research", "Research"))
