library(ncdf4)

nc <- nc_open(filename = "2013_leem_fine_forcing.nc", write = FALSE)

xc <- ncvar_get(nc, varid = "xc")
yc <- ncvar_get(nc, varid = "yc")

latc <- ncvar_get(nc, varid = "latc")
lonc <- ncvar_get(nc, varid = "lonc")

nele <- length(xc)
arrele <- seq(1:nele)

df <- data.frame(element = arrele,
                 XC = xc,
                 YC = yc,
                 Latitude = latc,
                 Longitude = lonc)

write.table(df, file = "Elements_X_Y_Lat_Lon.dat", sep = "   \t", row.names = FALSE)

nc_close(nc)
