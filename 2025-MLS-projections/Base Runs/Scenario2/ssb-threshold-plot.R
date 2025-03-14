# file = ssb-threshold-plot.R
# R script to create annual probability
# of stock being rebuilt plot
# for projection output *.rdat file

# Load required library
library(ggplot2)

# Define file paths
input_file <- "2025_MLS_scenario2.rdat"
output_file <- "ssb_threshprob.png"

# Read input data
s1 <- dget(input_file)

# Extract data
year <- seq(s1$genparms$startyear,s1$genparms$endyear,1)
avg <- s1$threshprob$ssb
threshprob <- 0.6

# Create data frame
df <- data.frame(
  x = year, y = avg, threshprob = threshprob
)

# Create plot
ssb_threshprob <- ggplot(df, aes(x = year, y = avg)) +
  xlab("Year") +
  ylab("Pr(Spawning Biomass > Target)") +
  ggtitle("Annual Rebuilding Probabilities Under Scenario 2") +
  theme_bw() +
  scale_x_continuous(breaks = seq(min(year), max(year), by = 2)) +
  scale_y_continuous(limits = c(-0.01, 1.01), breaks = seq(0, 1, by = 0.1)) +
  
   # Main line
  geom_line(aes(y = avg), linetype = "solid", linewidth = 1.2, color = "blue") +
  geom_line(aes(y = threshprob), linetype = "dashed", linewidth = 1.2, color = "darkgreen") +
  
  # Corrected annotation using annotate()
  annotate("text", x = max(year) - 11, y = threshprob * 1.05, 
           label = "Target Probability", color = "darkgreen", fontface = "italic", size = 3, hjust = 0)


# Save plot as PNG
ggsave(output_file, plot = ssb_threshprob, width = 8, height = 6, dpi = 300)

ssb_threshprob

cat("Plot saved to:", output_file, "\n")
