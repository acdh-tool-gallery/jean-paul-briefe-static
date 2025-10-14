import glob

from acdh_cfts_pyutils import TYPESENSE_CLIENT as client
from acdh_tei_pyutils.tei import TeiReader
from tqdm import tqdm
from typesense.api_call import ObjectNotFound

files = glob.glob("./data/editions/*/*.xml")


try:
    client.collections["JP-Briefe"].delete()
except ObjectNotFound:
    pass

current_schema = {
    "name": "JP-Briefe",
    "fields": [
        {"name": "id", "type": "string"},
        {"name": "rec_id", "type": "string"},
        {"name": "title", "type": "string"},
        {"name": "full_text", "type": "string"},
        {
            "name": "year",
            "type": "int32",
            "optional": True,
            "facet": True,
        },
        {"name": "persons", "type": "string[]", "facet": True, "optional": True},
        {"name": "places", "type": "string[]", "facet": True, "optional": True},
        {"name": "orgs", "type": "string[]", "facet": True, "optional": True},
    ],
}

client.collections.create(current_schema)


records = []
cfts_records = []
for x in tqdm(files, total=len(files)):
    doc = TeiReader(x)


make_index = client.collections["JP-Briefe"].documents.import_(records)
print(make_index)
print("done with indexing JP-Briefe")
