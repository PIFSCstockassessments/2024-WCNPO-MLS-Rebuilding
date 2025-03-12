# file = ssb-plot.R
# R script to create spawning biomass plot
# for projection output *.rdat file

# Load required library
library(ggplot2)

# Define file paths
input_file <- "2025_MLS_scenario1.rdat"
output_file <- "ssb_plot.png"

# Read input data
s1 <- dget(input_file)

# Extract data
year <- seq(s1$genparms$startyear, s1$genparms$endyear, 1)
avg <- s1$ssb$average
se <- s1$ssb$sdev
pct10 <- s1$ssb$pct10
pct25 <- s1$ssb$pct25
pct50 <- s1$ssb$pct50
pct75 <- s1$ssb$pct75
pct90 <- s1$ssb$pct90
pct99 <- s1$ssb$pct99
ssb_target <- s1$threshold$ssb

# Create data frame
df <- data.frame(
  x = year, y = avg, se = se,
  pct10 = pct10, pct25 = pct25, pct50 = pct50, pct75 = pct75, pct90 = pct90,
  ssb_target = ssb_target
)

# Create plot
ssb_plot <- ggplot(df, aes(x = x, y = y)) +
  xlab("Year") +
  ylab("Female Spawning Biomass (mt)") +
  ggtitle("Spawning Biomass Under Scenario 1") +
  theme_bw() +
  scale_x_continuous(breaks = seq(min(year), max(year), by = 2)) +
  scale_y_continuous(limits = c(0, 9000), breaks = seq(0, 9000, by = 1000)) +
  
  # Shaded uncertainty region
  geom_ribbon(aes(ymin = y - 1.28 * se, ymax = y + 1.28 * se), fill = "gray70", alpha = 0.5) +
  
  # Main lines
  geom_line(aes(y = y), linetype = "dashed", linewidth = 1.1, color = "black") +
  geom_line(aes(y = pct50), linetype = "solid", linewidth = 1.2, color = "blue") +
  geom_line(aes(y = pct75), linetype = "dotdash", linewidth = 0.9, color = "blue") +
  geom_line(aes(y = pct25), linetype = "dotdash", linewidth = 0.9, color = "blue") +
  geom_line(aes(y = pct90), linetype = "dotted", linewidth = 0.8, color = "blue") +
  geom_line(aes(y = pct10), linetype = "dotted", linewidth = 0.8, color = "blue") +
  geom_line(aes(y = ssb_target), linetype = "solid", linewidth = 1.2, color = "darkgreen") +
  
  # Corrected annotation using annotate()
  annotate("text", x = max(year) - 7, y = ssb_target[1] * 1.05, 
           label = "Rebuilding Target", color = "darkgreen", fontface = "italic", size = 3, hjust = 0)

# Save plot as PNG
ggsave(output_file, plot = ssb_plot, width = 8, height = 6, dpi = 300)

ssb_plot

cat("Plot saved to:", output_file, "\n")

