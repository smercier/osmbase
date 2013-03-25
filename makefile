# Need unzip, ogr2ogr, shptree, imposm
#-------------------
#Connection PG

HOST = localhost
PORT = 5432
DBNAME = osm
USER = osm
PGPWD = osm

#imposm
DOWNLOAD = 'http://download.geofabrik.de/australia-oceania/new-caledonia-latest.osm.bz2'
REGION = new-caledonia-latest.osm.bz2
IMPOSM_PGCON = postgis://$(USER):$(PGPWD)@$(HOST):$(PORT)/$(DBNAME)
SHPTREE = shptree


all: ./data/TM_WORLD_BORDERS-0.3.shp ./data/processed_p.shp ./data/shoreline_300.shp osmbase.map
imposm: imposm_write

osmbase.map: osmbase_sample.map
	cp osmbase_sample.map osmbase.map
	sed -i "s/host=host dbname=dbname user=user password=password port=port/host=$(HOST) dbname=$(DBNAME) user=$(USER) password=$(PGPWD) port=$(PORT)/g" osmbase.map
	touch osmbase.map

./data/processed_p.shp: processed_p.tar.bz2
	tar xmjf processed_p.tar.bz2 -C ./data
	shptree ./data/processed_p.shp
	touch ./data/processed_p.shp

./data/shoreline_300.shp: shoreline_300.tar.bz2
	tar xmjf shoreline_300.tar.bz2 -C ./data
	shptree ./data/shoreline_300.shp
	touch ./data/shoreline_300.shp

./data/TM_WORLD_BORDERS-0.3.shp: TM_WORLD_BORDERS-0.3.zip
	mkdir data
	unzip -o TM_WORLD_BORDERS-0.3.zip -d ./data
	shptree ./data/TM_WORLD_BORDERS-0.3.shp
	touch ./data/TM_WORLD_BORDERS-0.3.shp

processed_p.tar.bz2:
	wget http://tile.openstreetmap.org/processed_p.tar.bz2

shoreline_300.tar.bz2:
	wget http://tile.openstreetmap.org/shoreline_300.tar.bz2

TM_WORLD_BORDERS-0.3.zip:
	wget http://thematicmapping.org/downloads/TM_WORLD_BORDERS-0.3.zip

# Charger BD IMPOSM     
imposm_write: $(REGION) imposm_relations.cache
	imposm --overwrite-cache  --read --write --optimize -m imposm-mapping.py --connection=$(IMPOSM_PGCON) $(REGION)
	imposm --deploy-production-tables --connection=$(IMPOSM_PGCON)
	touch imposm_write
        
imposm_relations.cache: $(REGION)
	imposm --read $(REGION) --overwrite-cache
	touch $@

$(REGION):
	wget $(DOWNLOAD)
	touch $@
