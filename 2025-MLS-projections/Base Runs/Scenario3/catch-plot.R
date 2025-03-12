# file = catch-plot.R
# R script to create spawning biomass plot
# for projection output *.rdat file

# Load required library
library(ggplot2)

# Define file paths
input_file <- "2025_MLS_scenario3.rdat"
output_file <- "catch_plot.png"

# Read input data
s1 <- dget(input_file)

# Extract data
year <- seq(s1$genparms$startyear,s1$genparms$endyear,1)
avg <- s1$totalcatch$average
avg_catch <- 3258

# Create data frame
df <- data.frame(
  x = year, y = avg
)

# Create plot
catch_plot <- ggplot(df, aes(x = year, y = avg)) +
  xlab("Year") +
  ylab("Catch Biomass (mt)") +
  ggtitle("Catch Biomass Under Scenario 3") +
  theme_bw() +
  scale_x_continuous(breaks = seq(min(year), max(year), by = 2)) +
  scale_y_continuous(limits = c(0, 4000), breaks = seq(0, 4000, by = 500)) +
  
   # Main line
  geom_line(aes(y = avg), linetype = "solid", linewidth = 1.2, color = "blue") +
  geom_line(aes(y = avg_catch), linetype = "dashed", linewidth = 1.2, color = "darkgreen") +
  
  # Corrected annotation using annotate()
  annotate("text", x = max(year) - 9, y = avg_catch * 1.05, 
           label = "Average Catch Biomass, 2001-2020", color = "darkgreen", fontface = "italic", size = 3, hjust = 0)


# Save plot as PNG
ggsave(output_file, plot = catch_plot, width = 8, height = 6, dpi = 300)

catch_plot

cat("Plot saved to:", output_file, "\n")
