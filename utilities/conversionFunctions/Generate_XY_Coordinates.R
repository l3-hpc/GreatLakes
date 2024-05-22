library(sp)
library(rgdal)
library(tidyverse)
library(argparse)

# Get command line inputs
parser <- ArgumentParser()
parser$add_argument("-f", "--file", help = "Path to input file", type= "character")
parser$add_argument("-o", "--out", help = "Path to save file out", type = "character")

args <- parser$parse_args()
# Preserve the metadata in the head
header <- read_table(args$file, n_max = 1)
write.table(header, args$out, sep = " ", row.names=F, col.names= T, quote = F)

lonlat <- read_table(args$file, skip = 2, col_names =F) %>%
  rename(ID = X1, Lon = X2, Lat = X3, Depth = X4)

# Grab bottom half
bottom <- lonlat %>%
  filter(is.na(Depth))

top <- lonlat %>%
  drop_na(Depth)
coordinates(bottom) <- c("Lon", "Lat")

zone <- 17 

proj4string(bottom) <- CRS("+proj=longlat +datum=WGS84")
bottom <- spTransform(bottom, CRS(paste("+proj=utm +zone=",zone," ellps=WGS84",sep=''))) %>%
  as.data.frame()

dplyr::bind_rows(top, bottom) %>%
  write.table(x = ., file = args$out, sep = "   \t",
   row.names = FALSE, append = TRUE, col.names=FALSE, quote = FALSE,
   na= ""
   )

