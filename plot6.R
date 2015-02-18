# plot and compare the emissions from motor vehicle sources in Baltimore City with those in Los Angeles County, California (fips == "06037")

library( ggplot2 )

source( 'pj2zp.R' )

zpFl <- 'NEI_data.zip'
zpDir <- 'NEI_data'
NEIfl <- 'summarySCC_PM25.rds'
SCCfl <- 'Source_Classification_Code.rds'

zpDir <- pj2zp( zpFl , zpDir = zpDir )	# download zip file and unzip to zpDir

NEI <- readRDS( paste( zpDir , NEIfl , sep = '/' ) )	# read NEI
SCC <- readRDS( paste( zpDir , SCCfl , sep = '/' ) )	# read SCC

SCCmtr <- SCC[ grep( 'motor' , SCC$Short.Name , ignore.case = TRUE ) , ]
SCCid <- as.character( SCCmtr$SCC )
NEImtr <- NEI[ NEI$SCC %in% SCCid , ]
NEImtr24510 <- NEImtr[ which( NEImtr$fips == '24510' ) , ]
NEImtr24510agrgt <- aggregate( Emissions ~ year , data = NEImtr24510 , sum )
NEImtr24510agrgt$group <- rep( 'Baltimore City' , length( NEImtr24510agrgt[ , 1 ] ) )
NEImtr06037 <- NEImtr[ which( NEImtr$fips == '06037' ) , ]
NEImtr06037agrgt <- aggregate( Emissions ~ year , data = NEImtr06037 , sum )
NEImtr06037agrgt$group <- rep( 'Los Angeles County' , length( NEImtr06037agrgt[ , 1 ] ) )

NEImtrZpAgrgt <- rbind( NEImtr24510agrgt , NEImtr06037agrgt )
NEImtrZpAgrgt$group <- as.factor( NEImtrZpAgrgt$group )

qplt <- qplot( year , Emissions , data = NEImtrZpAgrgt , group = group , color = group , geom = c( 'point' , 'line' ) , xlab = 'Year' , ylab = 'Total Emission, PM2.5' , main = 'Emissions from Vehicule-Related Sources in Baltimore and Los Angeles' )
ggsave( qplt , file = 'plot6.png' , width = 8 , height = 5 )

