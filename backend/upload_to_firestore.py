import firebase_admin
from firebase_admin import credentials, firestore
import csv

# Initialize Firebase Admin SDK
cred = credentials.Certificate("referee-iq-firebase-adminsdk-fbsvc-470a31e75a.json")
firebase_admin.initialize_app(cred)

# Initialize Firestore
db = firestore.client()

# Open your CSV file
with open('queries_data.csv', mode='r') as file:
    reader = csv.DictReader(file)  # This will read the CSV into a dictionary format
    
    # Loop through each row in the CSV
    for row in reader:
        # Add each row to Firestore as a document in the 'queries' collection
        doc_ref = db.collection("queries").add({
            "query": row['Question'],
            "response": row['Response/Answer'],
            "law_reference": row['Law Reference'],
            "source_link": row['Source Link']
        })

print("Data uploaded successfully!")
