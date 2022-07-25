import sys
import csv
import boto3
from tqdm import tqdm
from rdkit import Chem
import json

DBNAME = "dynamodb"
TABLENAME = "Compounds"
KEYNAME = "Key"
VALUENAME = "Smiles"

input_file = sys.argv[1]

with open(input_file, "r") as f:
    smiles_list = []
    reader = csv.reader(f)
    for r in reader:
        smiles_list += [r[0]]

ik2smi = {}
for smi in tqdm(smiles_list):
    mol = Chem.MolFromSmiles(smi)
    if mol is None:
        continue
    inchi = Chem.rdinchi.MolToInchi(mol)[0]
    if inchi is None:
        continue
    inchikey = Chem.rdinchi.InchiToInchiKey(inchi)
    ik2smi[inchikey] = smi


client = boto3.client(DBNAME)

for k,v in tqdm(ik2smi.items()):
    item = {
        KEYNAME: {"S":k},
        VALUENAME: {"S":v} 
    }
    print(item)
    client.put_item(
        TableName=TABLENAME,
        Item = item
    )
