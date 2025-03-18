# Define file paths
input_file <- "2025_MLS_scenario3.rdat"
replacement_file <- "fleet_names.txt"
output_file <- "2025_MLS_scenario3.rdat"

# Read the input file
inp_lines <- readLines(input_file)

# Read the replacement content
replacement_lines <- readLines(replacement_file)

# Define the line range to replace
start_index <- 45
end_index <- 53

# Replace the specified lines
new_lines <- c(inp_lines[1:(start_index - 1)], 
               replacement_lines, 
               inp_lines[(end_index + 1):length(inp_lines)])

# Write the modified content back to a new file
writeLines(new_lines, output_file)

cat("Replacement completed. Modified file saved as:", output_file, "\n")
