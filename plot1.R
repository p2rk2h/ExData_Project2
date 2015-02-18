# plot the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008

source( 'pj2zp.R' )

zpFl <- 'NEI_data.zip'
zpDir <- 'NEI_data'
NEIfl <- 'summarySCC_PM25.rds'
# SCCfl <- 'Source_Classification_Code.rds'

zpDir <- pj2zp( zpFl , zpDir = zpDir )	# download zip file and unzip to zpDir

NEI <- readRDS( paste( zpDir , NEIfl , sep = '/' ) )	# read NEI
# SCC <- readRDS( paste( zpDir , SCCfl , sep = '/' ) )	# read SCC

NEIagrgt <- aggregate( Emissions ~ year , data = NEI , sum )

png( 'plot1.png' )
plot( NEIagrgt , type = 'o' , xlab = 'Year' , ylab = 'Total Emission, PM2.5' , main = 'US Total Emissions' )
dev.off( )
