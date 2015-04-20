apt-get remove -y libgdal-dev libgdal1h
service postgresql stop

# from here:
# http://scigeo.org/articles/howto-install-latest-geospatial-software-on-linux.html#gdal
# basic dependencies (enough to build GDAL) 

sudo apt-get -y --ignore-missing install subversion g++ libsqlite3-dev libxml2-dev python-dev python-numpy swig libexpat1-dev libcurl4-gnutls-dev
# more dependencies (recommended)
sudo apt-get -y --ignore-missing install libkml-dev libgif-dev libgif4 libjasper-dev libpng12-dev libfreexl1
# optional dependencies (for maximum features)
sudo apt-get -y --ignore-missing install autotools-dev libdap-dev libdap11 libdapclient3 libdapserver7  libltdl-dev libmysqlclient-dev libmysqlclient18 libodbc1 libogdi3.2 libpq-dev libpq5 libsqlite3-dev libtool libxerces-c2-dev libxerces-c28 mysql-common odbcinst odbcinst1debian2 unixodbc unixodbc-dev uuid-dev

	#suggested based on above line:
  # libtool-doc autoconf automaken gfortran fortran95-compiler gcj-jdk
  # libxerces-c2-doc

# get the latest development version
mkdir /opt/source
cd /opt/source
svn checkout https://svn.osgeo.org/gdal/trunk/gdal gdal-trunk
cd gdal-trunk
mkdir build
# see configure options
./configure --prefix=/usr/local

#from: https://github.com/geo-data/gdal-docker/blob/master/install-gdal.sh
rm -f /usr/lib/libgdal.so*

make install

#from https://github.com/geo-data/gdal-docker/blob/master/install-gdal.sh
ldconfig

#checks
gdal-config --version
# check supported formats
gdal-config --formats
# see if ogr is enabled
gdal-config --ogr-enabled
# supported raster formats (check for tif, jpeg, png, hdf4/5, netcdf etc)
gdalinfo --formats
# supported vector formats (check for shapefile, kml, etc)
ogrinfo --formats