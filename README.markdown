osmbase
-------
Simple QA projet to build quickly a mapserver mapping project with Open Street Map.  This osm mapfile is build with Basemaps for Mapserver.

required 
--------

* Mapserver
* Postgresql/Postgis 2.x
* shptree
* unzip
* imposm

database
--------
You can build your own or use this script for a default osm database:

    sh createdb.sh "'my_password'"

instructions
------------
Doawload data and import in database

    make
    make imposm 
