# plot the four types of sources by (point, nonpoint, onroad, nonroad) variable in emissions from 1999–2008 for Baltimore City

library( ggplot2 )

source( 'pj2zp.R' )

zpFl <- 'NEI_data.zip'
zpDir <- 'NEI_data'
NEIfl <- 'summarySCC_PM25.rds'
SCCfl <- 'Source_Classification_Code.rds'

zpDir <- pj2zp( zpFl , zpDir = zpDir )	# download zip file and unzip to zpDir

NEI <- readRDS( paste( zpDir , NEIfl , sep = '/' ) )	# read NEI
SCC <- readRDS( paste( zpDir , SCCfl , sep = '/' ) )	# read SCC

NEI24510 <- NEI[ which( NEI$fips == '24510' ) , ]
NEI24510typAgrgt <- aggregate( Emissions ~ year + type , data = NEI24510 , sum )

qplt <- qplot( year , Emissions , data = NEI24510typAgrgt , color = type , geom = c( 'point' , 'line' ) , xlab = 'Year' , ylab = 'Total Emission, PM2.5' , main = 'Total Emissions by Pollutant Type for Baltimore' )
ggsave( qplt , file = 'plot3.png' , width = 6 , height = 5 )

