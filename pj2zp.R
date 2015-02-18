# check zipFile exists; else download and unzip to zipDir
# returns the zipDir relative to relativePath (def = cwd)

pj2zp <- function( zpFl , rltvPth = '.' , zpUrl = 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip' , zpDir = '.' ) {
	zpFl = paste( rltvPth , zpFl , sep = '/' )
	zpDir <- paste( rltvPth , zpDir , sep = '/' )
	if ( ! file.exists( zpFl ) ) { 
		download.file( zpUrl , zpFl )
		unzip( zpFl , exdir = zpDir )
	}
	zpDir
}
