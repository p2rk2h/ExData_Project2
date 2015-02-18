# plot the total emissions from motor vehicle sources changed from 1999–2008 in Baltimore City

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

qplt <- qplot( year , Emissions , data = NEImtr24510agrgt , geom = c( 'point' , 'line' ) , xlab = 'Year' , ylab = 'Total Emission, PM2.5' , main = 'Emissions from Vehicule-Related Sources in Baltimore' )
ggsave( qplt , file = 'plot5.png' , width = 6 , height = 5 )

