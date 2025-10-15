import glob
import os

from acdh_cfts_pyutils import TYPESENSE_CLIENT as client
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import check_for_hash, extract_fulltext
from tqdm import tqdm
from typesense.api_call import ObjectNotFound

files = glob.glob("./data/editions/*.xml")
tag_blacklist = [
    "{http://www.tei-c.org/ns/1.0}abbr",
    "{http://www.tei-c.org/ns/1.0}del",
]


try:
    client.collections["jpbriefe"].delete()
except ObjectNotFound:
    pass

current_schema = {
    "name": "jpbriefe",
    "enable_nested_fields": True,
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
        {"name": "sender", "type": "object[]", "facet": True, "optional": True},
        {"name": "receiver", "type": "object[]", "facet": True, "optional": True},
        {"name": "persons", "type": "object[]", "facet": True, "optional": True},
        {"name": "places", "type": "object[]", "facet": True, "optional": True},
        {"name": "bibls", "type": "object[]", "facet": True, "optional": True},
    ],
}

client.collections.create(current_schema)


records = []
cfts_records = []
for x in tqdm(files, total=len(files)):
    doc = TeiReader(x)
    try:
        body = doc.any_xpath(".//tei:body")[0]
    except IndexError:
        continue
    record = {}
    record["id"] = os.path.split(x)[-1].replace(".xml", "")
    record["rec_id"] = os.path.split(x)[-1].replace(".xml", "")
    record["title"] = doc.any_xpath(".//tei:title[@n='digital']")[0].text
    record["full_text"] = extract_fulltext(body, tag_blacklist=tag_blacklist)
    record["sender"] = []
    for y in doc.any_xpath('.//tei:correspAction[@type="sent"]/tei:persName'):
        item = {}
        item["id"] = check_for_hash(y.attrib["key"])
        item["label"] = y.text
        record["sender"].append(item)

    records.append(record)


make_index = client.collections["jpbriefe"].documents.import_(records)
print(make_index)
print("done with indexing jpbriefe")
