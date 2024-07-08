# molecule_similarities

## Prerequisites
To run this project, you need to set up the following environment variables:

```sh
export DB_NAME='your_database_name'
export DB_USER='your_database_user'
export DB_PASSWORD='your_database_password'
export DB_HOST='your_database_host'
export DB_PORT='your_database_port'
export AWS_ACCESS_KEY_ID='your_aws_access_key_id'
export AWS_SECRET_ACCESS_KEY='your_aws_secret_access_key'
export AWS_REGION='your_aws_region'
```


## Installation
To install the required dependencies, run:

```sh
pip install -r requirements.txt
```

## Fetch Data

To fetch the molecules data run this scripts:

```sh
python fetch_lookups.py
python fetch_molecules.py
```

## Data Ingestion into PostgreSQL

Run bash scripts from `scripts/ingestion` folder

## Calculate Morgan Fingerprints

To calculate morgan fingerprints run script from `scripts/morgan_fingerprint`

## Calculate Tanimoto Similarities

To calculate morgan fingerprints run script from `scripts/tanimoto`