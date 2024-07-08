#!/bin/bash

psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "SET search_path TO $DB_SCHEMA; \copy chembl_id_lookup FROM 'lookups.csv' CSV HEADER"
