# plot total emissions from PM2.5 in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

source( 'pj2zp.R' )

zpFl <- 'NEI_data.zip'
zpDir <- 'NEI_data'
NEIfl <- 'summarySCC_PM25.rds'
# SCCfl <- 'Source_Classification_Code.rds'

zpDir <- pj2zp( zpFl , zpDir = zpDir )	# download zip file and unzip to zpDir

NEI <- readRDS( paste( zpDir , NEIfl , sep = '/' ) )	# read NEI
# SCC <- readRDS( paste( zpDir , SCCfl , sep = '/' ) )	# read SCC

NEI24510 <- NEI[ which( NEI$fips == '24510' ) , ]
NEI24510agrgt <- aggregate( Emissions ~ year , data = NEI24510 , sum )

png( 'plot2.png' )
plot( NEI24510agrgt , type = 'o' , xlab = 'Year' , ylab = 'Total Emission, PM2.5' , main = 'Total Emissions for Baltimore' )
dev.off( )
