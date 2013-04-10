# Quick QA-VM setup
# update encoding french canada and install ppa
sudo localedef -i en_CA -f UTF-8 en_CA
sudo update-locale
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable

#optional for osm2pgsql
sudo add-apt-repository ppa:kakrueger/openstreetmap 

# install mapserver suite and tools (Postgresql/PostGIS, Mapserver Suite, Python Virtualenv, vim, zip)
sudo apt-get update
sudo apt-get -y install postgresql-9.1 postgresql-server-dev-9.1 \
      postgresql-contrib-9.1 postgresql-9.1-postgis \
      gdal-bin binutils libgeos-3.2.2 libgeos-c1 \
      libgeos-dev libgdal1-dev libxml2 libxml2-dev \
      libxml2-dev checkinstall proj libpq-dev git vim screen \
      build-essential python-dev protobuf-compiler zip unzip\
      libprotobuf-dev libtokyocabinet-dev python-psycopg2 \
      python-virtualenv python-pip \
      cgi-mapserver mapserver-bin libmapcache mapcache-cgi \
      mapcache-tools libapache2-mod-mapcache tinyows osm2pgsql

# mapserver tricks
sudo mkdir /tmp/ms_tmp
sudo chown www-data:www-data /tmp/ms_tmp
