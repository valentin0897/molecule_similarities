#!/bin/bash

psql -h $DB_HOST -d $DB_NAME -U $DB_USER -W -c "SET search_path TO $DB_SCHEMA; \copy compound_properties FROM 'compound_properties.csv' CSV HEADER"