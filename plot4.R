# plot the total emissions from coal combustion-related sources changed from 1999–2008 in US

library( ggplot2 )

source( 'pj2zp.R' )

zpFl <- 'NEI_data.zip'
zpDir <- 'NEI_data'
NEIfl <- 'summarySCC_PM25.rds'
SCCfl <- 'Source_Classification_Code.rds'

zpDir <- pj2zp( zpFl , zpDir = zpDir )	# download zip file and unzip to zpDir

NEI <- readRDS( paste( zpDir , NEIfl , sep = '/' ) )	# read NEI
SCC <- readRDS( paste( zpDir , SCCfl , sep = '/' ) )	# read SCC

SCCcoal <- SCC[ grep( 'coal' , SCC$Short.Name , ignore.case = TRUE ) , ]
SCCid <- as.character( SCCcoal$SCC )
NEIcoal <- NEI[ NEI$SCC %in% SCCid , ]
NEIcoalAgrgt <- aggregate( Emissions ~ year , data = NEIcoal , sum )

qplt <- qplot( year , Emissions , data = NEIcoalAgrgt , geom = c( 'point' , 'line' ) , xlab = 'Year' , ylab = 'Total Emission, PM2.5' , main = 'US Total Emissions from Coal-Related Sources' )
ggsave( qplt , file = 'plot4.png' , width = 7 , height = 5 )

