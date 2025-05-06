# fmort-hist-year.R
# Plots histogram of the fishing mortality distribution by year

# Load required package
library(ggplot2)

# === Constants ===
FMSY_REF <- 0.63
OVERFISHING_THRESHOLD <- 0.53
YEAR_RANGE <- 2021:2034
DEFAULT_CAP <- 1.0
AUX_FILE_PREFIX <- "2025_MLS_scenario"

# === Helper Functions ===
get_file_path <- function(scenario_num) {
  paste0(AUX_FILE_PREFIX, scenario_num, "-auxiliary.xx9")
}

is_valid_numeric_line <- function(line) {
  nums <- strsplit(trimws(line), "\\s+")[[1]]
  length(nums) == 14 && all(suppressWarnings(!is.na(as.numeric(nums))))
}

# === Prompt for Scenario Number ===
repeat {
  scenario_input <- readline(prompt = "Enter a positive integer scenario number: ")
  if (grepl("^[1-9][0-9]*$", scenario_input)) break
  cat("Invalid input. Please enter a positive integer (e.g., 1, 2, 3...).\n")
}

# === Prompt for Custom Fishing Mortality Cap ===
custom_cap_prompt <- readline(prompt = "Would you like to enter a custom maximum fishing mortality cap? [y/n]: ")
custom_cap_prompt <- tolower(trimws(custom_cap_prompt))
use_custom_cap <- custom_cap_prompt == "" || custom_cap_prompt == "y"

if (use_custom_cap) {
  fmort_cap_input <- readline(prompt = paste0("Enter a maximum fishing mortality cap (default = ", DEFAULT_CAP, "): "))
  fmort_cap <- suppressWarnings(as.numeric(fmort_cap_input))
  if (is.na(fmort_cap) || fmort_cap <= 0) fmort_cap <- DEFAULT_CAP
} else {
  fmort_cap <- DEFAULT_CAP
}

# === Load File ===
file_path <- get_file_path(scenario_input)
if (!file.exists(file_path)) stop(paste("Error: File not found:", file_path))

lines <- readLines(file_path)
valid_lines <- lines[sapply(lines, is_valid_numeric_line)]
fmort <- do.call(rbind, lapply(valid_lines, function(line) as.numeric(strsplit(trimws(line), "\\s+")[[1]])))
fmort <- fmort * FMSY_REF
colnames(fmort) <- as.character(YEAR_RANGE)

# === Compute X-axis Maximum ===
x_995 <- quantile(fmort, 0.995)
x_max <- min(fmort_cap, ceiling(x_995 / 1000) * 1000)

# === Prompt for Year ===
repeat {
  user_input <- readline(prompt = "Enter a year from 2021 to 2034: ")
  if (user_input %in% colnames(fmort)) break
  cat("Invalid input. Please enter a valid year from 2021 to 2034.\n")
}

# === Calculate Statistics ===
year_values <- fmort[, user_input]
median_val <- median(year_values)
ci_80 <- quantile(year_values, probs = c(0.10, 0.90))
p_overfishing <- round(mean(year_values > OVERFISHING_THRESHOLD), 2)

# === Plot ===
plot_df <- data.frame(Fishing_Mortality = year_values)

p <- ggplot(plot_df, aes(x = Fishing_Mortality)) +
  geom_histogram(aes(y = ..density..), bins = 30, fill = "skyblue", color = "black") +
  geom_density(color = "red", size = 1) +
  geom_vline(xintercept = median_val, linetype = "dashed", color = "black", size = 1) +
  geom_vline(xintercept = OVERFISHING_THRESHOLD, linetype = "solid", color = "darkblue", size = 1) +
  scale_x_continuous(
    limits = c(0, x_max),
    breaks = seq(0, x_max, by = 0.2)
  ) +
  labs(
    x = "Fishing Mortality",
    y = "Density",
    title = paste("Fishing Mortality Distribution in", user_input),
    subtitle = sprintf(
      "P(Overfishing) ≈ %.2f, Median ≈ %.2f",
      p_overfishing, median_val
    )
  ) +
  theme_minimal(base_size = 22) +
  theme(
    plot.title = element_text(size = 24, face = "bold"),
    plot.subtitle = element_text(size = 20),
    axis.title = element_text(size = 20),
    axis.text = element_text(size = 18)
  )

print(p)

# === Save Plot ===
output_file <- paste0("fmort-hist-", scenario_input, "-", user_input, ".png")
ggsave(output_file, plot = p, width = 8, height = 6, dpi = 300)
cat("Figure saved to", normalizePath(output_file), "\n")
