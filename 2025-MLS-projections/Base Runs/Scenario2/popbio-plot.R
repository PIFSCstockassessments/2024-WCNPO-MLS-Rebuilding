# file = popbio-plot.R
# R script to create population biomass plot
# for projection output *.rdat file

# Load required library
library(ggplot2)

# Define file paths
input_file <- "2025_MLS_scenario2.rdat"
output_file <- "popbio_plot.png"

# Read input data
s1 <- dget(input_file)

# Extract data
year <- seq(s1$genparms$startyear, s1$genparms$endyear, 1)
avg <- s1$jan1bio$average
se <- s1$jan1bio$sdev
pct10 <- s1$jan1bio$pct10
pct25 <- s1$jan1bio$pct25
pct50 <- s1$jan1bio$pct50
pct75 <- s1$jan1bio$pct75
pct90 <- s1$jan1bio$pct90
pct99 <- s1$jan1bio$pct99
avg_popbio <- 12649

# Create data frame
df <- data.frame(
  x = year, y = avg, se = se,
  pct10 = pct10, pct25 = pct25, pct50 = pct50, pct75 = pct75, pct90 = pct90,
  avg_popbio = avg_popbio
)

# Create plot
jan1bio_plot <- ggplot(df, aes(x = x, y = y)) +
  xlab("Year") +
  ylab("Population Biomass (mt)") +
  ggtitle("Population Biomass Under Scenario 2") +
  theme_bw() +
  scale_x_continuous(breaks = seq(min(year), max(year), by = 2)) +
  scale_y_continuous(limits = c(0, 20000), breaks = seq(0, 20000, by = 2000)) +
  
  # Shaded uncertainty region
  geom_ribbon(aes(ymin = y - 1.28 * se, ymax = y + 1.28 * se), fill = "gray70", alpha = 0.5) +
  
  # Main lines
  geom_line(aes(y = y), linetype = "dashed", linewidth = 1.1, color = "black") +
  geom_line(aes(y = pct50), linetype = "solid", linewidth = 1.2, color = "blue") +
  geom_line(aes(y = pct75), linetype = "dotdash", linewidth = 0.9, color = "blue") +
  geom_line(aes(y = pct25), linetype = "dotdash", linewidth = 0.9, color = "blue") +
  geom_line(aes(y = pct90), linetype = "dotted", linewidth = 0.8, color = "blue") +
  geom_line(aes(y = pct10), linetype = "dotted", linewidth = 0.8, color = "blue") +
  geom_line(aes(y = avg_popbio), linetype = "solid", linewidth = 1.2, color = "darkgreen") +
  
  # Corrected annotation using annotate()
  annotate("text", x = max(year) - 7, y = avg_popbio * 1.05, 
           label = "Average Population Biomass 2001-2020", color = "darkgreen", fontface = "italic", size = 3, hjust = 0)

# Save plot as PNG
ggsave(output_file, plot = jan1bio_plot, width = 8, height = 6, dpi = 300)

jan1bio_plot

cat("Plot saved to:", output_file, "\n")

