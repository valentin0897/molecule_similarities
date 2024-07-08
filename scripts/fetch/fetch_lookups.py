import logging
import json

import asyncio
import aiohttp
import requests

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s %(levelname)s:%(message)s',
    handlers=[
        logging.FileHandler("fetch_lookups.log"),
        logging.StreamHandler()
    ]
)


LOOKUP_JSON_URL = 'https://www.ebi.ac.uk/chembl/api/data/chembl_id_lookup.json'
CHEMBL_DOMAIN = 'https://www.ebi.ac.uk'
BATCH_SIZE = 1000
MAX_CONCURRENT_REQUESTS = 10


def generate_urls(base_url, limit, total_count, start_offset):
    offset = start_offset

    while offset <= total_count:
        yield f"{base_url}?limit={limit}&offset={offset}"
        offset += limit


async def save_lookups():
    async with aiohttp.ClientSession() as session:
        data = requests.get(LOOKUP_JSON_URL, params={'limit': 1})
        data_json = data.json()
        total_count = data_json['page_meta']['total_count']

        urls = generate_urls(LOOKUP_JSON_URL, BATCH_SIZE, total_count, 0)

        semaphore = asyncio.Semaphore(MAX_CONCURRENT_REQUESTS)
        tasks = [fetch_json_batch(session, url, semaphore) for url in urls]
        responses = await asyncio.gather(*tasks)

        responses = [response for response
                     in responses if response is not None]

        lookups = [item for sublist
                   in responses for item in sublist['chembl_id_lookups']]

        filename = "lookups.json"
        with open(filename, "a") as f:
            f.write(json.dumps(lookups))

        logging.info(f"Appended {len(lookups)} records to {filename}")


async def fetch_json_batch(session, batch_link, semaphore):
    logging.debug(f"Fetching data from {batch_link}.")
    async with semaphore:
        try:
            async with session.get(batch_link) as response:
                return await response.json()
        except Exception as e:
            logging.error(f'Error fetching data from {batch_link}: {e}')
            return None


async def main():
    await save_lookups()

if __name__ == '__main__':
    logging.info("Ingestion started...")
    asyncio.run(main())
