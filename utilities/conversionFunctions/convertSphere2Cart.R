library(sp)
library(rgdal)
library(tidyverse)
library(argparse)

# Get command line inputs
parser <- ArgumentParser()
parser$add_argument("-f", "--input", help = "Path to input file")
parser$add_argument("-s", "--skip", type = "integer", help = "Number of lines to skip in the header")
parser$add_argument("-o", "--out", help = "Path to save file out")
parser$add_argument("-c", "--columns", help = "List of column names")


args <- parser$parse_args()
columns <- c(stringr::str_split(args$columns, ",")[[1]])
print(is.vector(columns))
print(is.character(columns))
print(typeof(args$columns))
print(args)

# Function to process the file
process_file <- function(file_path, file_out, skip_lines, col_names) {
  # Read the header lines
  read.table(file_path, nrows = skip_lines, header = FALSE, sep = ";") %>% 
    write.table(file_out, row.names =FALSE, sep = "\t", col.names = F, quote = F)

  # Read the remaining data using read_table
  data <- read_table(file_path, skip = skip_lines, col_names = col_names)
  zone <- 17 
  coordinates(data) <- c("Lon", "Lat")

  proj4string(data) <- CRS("+proj=longlat +datum=WGS84")
  data <- spTransform(data, CRS(paste("+proj=utm +zone=",zone," ellps=WGS84",sep=''))) %>% 
    as.data.frame() %>%
    select(2,3,1) %>%
    # if depth is a column, make the minimum depth 0
    mutate_at(vars(one_of("Depth")), ~ .x - min(.x, na.rm=T) + 0.1)
  

  # Save the combined data to a new file
  write.table(data, file = file_out, sep = "\t", row.names = FALSE, col.names = FALSE, append = TRUE, quote = F)
}

# Example usage:
process_file(file_path = args$input,
             skip_lines = as.integer(args$skip),
             file_out =  args$out,
             col_names =  columns)
