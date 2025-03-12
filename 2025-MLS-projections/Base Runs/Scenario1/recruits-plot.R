# file = recruits-plot.R
# R script to create recruitment plot
# for projection output *.rdat file

# Load required library
library(ggplot2)

# Define file paths
input_file <- "2025_MLS_scenario1.rdat"
output_file <- "recruits_plot.png"

# Read input data
s1 <- dget(input_file)

# Extract data and change units to thousands of age-1 fish
year <- seq(s1$genparms$startyear, s1$genparms$endyear, 1)
avg <- s1$recruits$average/1000.0
se <- s1$recruits$sdev/1000.0
pct10 <- s1$recruits$pct10/1000.0
pct25 <- s1$recruits$pct25/1000.0
pct50 <- s1$recruits$pct50/1000.0
pct75 <- s1$recruits$pct75/1000.0
pct90 <- s1$recruits$pct90/1000.0
pct99 <- s1$recruits$pct99/1000.0
avg_recruits <- 279.6

# Create data frame
df <- data.frame(
  x = year, y = avg, se = se,
  pct10 = pct10, pct25 = pct25, pct50 = pct50, pct75 = pct75, pct90 = pct90,
  avg_recruits = avg_recruits
)

# Create plot
recruits_plot <- ggplot(df, aes(x = x, y = y)) +
  xlab("Year") +
  ylab("Recruitment (000s age-1 fish") +
  ggtitle("Recruitment Under Scenario 1") +
  theme_bw() +
  scale_x_continuous(breaks = seq(min(year), max(year), by = 2)) +
  scale_y_continuous(limits = c(0, 500), breaks = seq(0, 500, by = 100)) +
  
  # Shaded uncertainty region
  geom_ribbon(aes(ymin = y - 1.28 * se, ymax = y + 1.28 * se), fill = "gray70", alpha = 0.5) +
  
  # Main lines
  geom_line(aes(y = y), linetype = "dashed", linewidth = 1.1, color = "black") +
  geom_line(aes(y = pct50), linetype = "solid", linewidth = 1.2, color = "blue") +
  geom_line(aes(y = pct75), linetype = "dotdash", linewidth = 0.9, color = "blue") +
  geom_line(aes(y = pct25), linetype = "dotdash", linewidth = 0.9, color = "blue") +
  geom_line(aes(y = pct90), linetype = "dotted", linewidth = 0.8, color = "blue") +
  geom_line(aes(y = pct10), linetype = "dotted", linewidth = 0.8, color = "blue") +
  geom_line(aes(y = avg_recruits), linetype = "dashed", linewidth = 1.2, color = "darkgreen") +
  
  # Corrected annotation using annotate()
  annotate("text", x = max(year) - 9, y = avg_recruits * 1.05, 
           label = "Average Recruitment, 1977-2020", color = "darkgreen", fontface = "italic", size = 3, hjust = 0)

# Save plot as PNG
ggsave(output_file, plot = recruits_plot, width = 8, height = 6, dpi = 300)

recruits_plot

cat("Plot saved to:", output_file, "\n")

