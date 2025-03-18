s1 <- dget("2025_MLS_scenario1.rdat")
year <- seq(s1$genparms$startyear,s1$genparms$endyear,1)
avg <- s1$totalcatch$average
se <- s1$totalcatch$sdev
pct10 <- s1$totalcatch$pct10
pct25 <- s1$totalcatch$pct25
pct50 <- s1$totalcatch$pct50
pct75 <- s1$totalcatch$pct75
pct90 <- s1$totalcatch$pct90
pct99 <- s1$totalcatch$pct99

df <- data.frame(
  x = year, y = avg, se = se,
  pct10 = pct10, pct25 = pct25, pct50 = pct50, pct75 = pct75, pct90 = pct90
)

p <- ggplot(df, aes(x = year, y = avg)) +
  xlab("Year") +
  ylab("Catch Biomass") +
  ggtitle("Catch Biomass Under Catch Scenario 1") +
  theme_bw() +
  scale_x_continuous(breaks = seq(min(year), max(year), by = 2)) +
  scale_y_continuous(breaks = seq(0, max(pct99, na.rm = TRUE), by = 1000)) +

  
  # Shaded uncertainty region
#  geom_ribbon(aes(ymin = avg - 1.96 * se, ymax = avg + 1.96 * se), fill = "gray70", alpha = 0.5) +
  
  # Main lines
  geom_line(aes(y = avg), linetype = "dashed", linewidth = 1.1, color = "black") +
  geom_line(aes(y = pct50), linetype = "solid", linewidth = 1.2, color = "blue") +
  geom_line(aes(y = pct75), linetype = "dotdash", linewidth = 0.9, color = "blue") +
  geom_line(aes(y = pct25), linetype = "dotdash", linewidth = 0.9, color = "blue") +
  geom_line(aes(y = pct90), linetype = "dotted", linewidth = 0.8, color = "blue") +
  geom_line(aes(y = pct10), linetype = "dotted", linewidth = 0.8, color = "blue")
 

p
