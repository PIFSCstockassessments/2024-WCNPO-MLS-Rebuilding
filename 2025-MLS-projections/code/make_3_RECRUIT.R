# file = make_3_RECRUIT.R
# R script to insert 3-recruitment model ensemble
# from [RECRUIT] section in recruit_file
# to replace the 1-model [RECRUIT] section in input_file
# and write the result to output_file

# Define file paths
input_file <- "2025_MLS_scenario3.inp"
recruit_file <- "3-RECRUIT.txt"
output_file <- "2025_MLS_scenario3.inp"

# Read the input file
inp_lines <- readLines(input_file)

# Read the recruit section file
recruit_lines <- readLines(recruit_file)

# Find the indices for the [RECRUIT] section
start_index <- which(grepl("^\\[RECRUIT\\]", inp_lines))
end_index <- which(grepl("^\\[", inp_lines[(start_index + 1):length(inp_lines)])) + start_index - 1

# If another section is found, use it as the end index; otherwise, go to the end of the file
if (length(end_index) == 0) {
  end_index <- length(inp_lines)
} else {
  end_index <- min(end_index)
}

# Replace the section
new_lines <- c(inp_lines[1:(start_index - 1)], recruit_lines, inp_lines[(end_index + 1):length(inp_lines)])

# Write the modified content back to a new file
writeLines(new_lines, output_file)

cat("Replacement completed. Modified file saved as:", output_file, "\n")
