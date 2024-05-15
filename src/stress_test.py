import requests
from concurrent.futures import ThreadPoolExecutor

url = 'http://18.199.86.114/run' #This IP can channge depending on which model you are testing
#ersiliaos/eos43at = http://3.75.227.184/
#ersiliaos/eos3b5e = http://18.199.86.114/
#ersiliaos/eos9ei3 = http://35.159.128.242/
#To run this
#pip install requests
#python stress_test.py

headers = {
    'accept': '*/*',
    'Content-Type': 'application/json'
}

smiles_list = [f'{"C" * (i % 4 + 3)}CONC' for i in range(1000)]
#print(smiles_list)

def send_request(smiles):
    payload = [{'input': smiles}]
    response = requests.post(url, json=payload, headers=headers)
    return response.status_code, response.text

def run_test(concurrent_users):
    with ThreadPoolExecutor(max_workers=concurrent_users) as executor:
        futures = [executor.submit(send_request, smiles) for smiles in smiles_list]
        results = [future.result() for future in futures]
    return results

concurrent_users = 30

test_results = run_test(concurrent_users)

for status, response in test_results:
    print(status, response)

