# file = fmort-plot.R
# R script to create fishing mortality plot
# for projection output *.rdat file

# Load required library
library(ggplot2)

# Define file paths
input_file <- "2025_MLS_scenario2.rdat"
output_file <- "fmort_plot.png"

# Read input data
s1 <- dget(input_file)

# Extract data and apply fmort conversion to nominal scale
fmort_conversion <- 0.63
year <- seq(s1$genparms$startyear, s1$genparms$endyear, 1)
avg <- s1$fmult$average*fmort_conversion
se <- s1$fmult$sdev*fmort_conversion
pct10 <- s1$fmult$pct10*fmort_conversion
pct25 <- s1$fmult$pct25*fmort_conversion
pct50 <- s1$fmult$pct50*fmort_conversion
pct75 <- s1$fmult$pct75*fmort_conversion
pct90 <- s1$fmult$pct90*fmort_conversion
pct99 <- s1$fmult$pct99*fmort_conversion
fmort_ofl <- s1$threshold$fmort*fmort_conversion

# Create data frame
df <- data.frame(
  x = year, y = avg, se = se,
  pct10 = pct10, pct25 = pct25, pct50 = pct50, pct75 = pct75, pct90 = pct90,
  pct99 = pct99, fmort_ofl = fmort_ofl
)

# Create plot
fmort_plot <- ggplot(df, aes(x = x, y = y)) +
  xlab("Year") +
  ylab("Fishing Mortality") +
  ggtitle("Fishing Mortality Under Scenario 2") +
  theme_bw() +
  scale_x_continuous(breaks = seq(min(year), max(year), by = 2)) +
  scale_y_continuous(limits = c(-0.02, 1.2), breaks = seq(0, 1.2, by = 0.2)) +
  
  # Shaded uncertainty region
  geom_ribbon(aes(ymin = y - 1.28 * se, ymax = y + 1.28 * se), fill = "gray70", alpha = 0.5) +
  
  # Main lines
  geom_line(aes(y = y), linetype = "dashed", linewidth = 1.1, color = "black") +
  geom_line(aes(y = pct50), linetype = "solid", linewidth = 1.2, color = "blue") +
  geom_line(aes(y = pct75), linetype = "dotdash", linewidth = 0.9, color = "blue") +
  geom_line(aes(y = pct25), linetype = "dotdash", linewidth = 0.9, color = "blue") +
  geom_line(aes(y = pct90), linetype = "dotted", linewidth = 0.8, color = "blue") +
  geom_line(aes(y = pct10), linetype = "dotted", linewidth = 0.8, color = "blue") +
  geom_line(aes(y = fmort_ofl), linetype = "solid", linewidth = 1.2, color = "red") +
  
  # Corrected annotation using annotate()
  annotate("text", x = max(year) - 5, y = fmort_ofl * 1.05, 
           label = "F(0.2*SSB(F=0))", color = "red", fontface = "italic", size = 3, hjust = 0)

# Save plot as PNG
ggsave(output_file, plot = fmort_plot, width = 8, height = 6, dpi = 300)

fmort_plot

cat("Plot saved to:", output_file, "\n")

