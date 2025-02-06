import firebase_admin
from firebase_admin import credentials, firestore
from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from dotenv import load_dotenv  # Import dotenv to load environment variables
import os  # For reading environment variables

# Load environment variables from .env file
load_dotenv()

# Get the Firebase credentials path from the environment variable
firebase_credentials_path = os.getenv("FIREBASE_CREDENTIALS_PATH")

# Initialize Firebase Admin SDK using credentials from the environment variable
if firebase_credentials_path:
    cred = credentials.Certificate(firebase_credentials_path)
    firebase_admin.initialize_app(cred)
else:
    raise ValueError("FIREBASE_CREDENTIALS_PATH environment variable not set")

# Initialize Firestore
db = firestore.client()

# Initialize FastAPI app
app = FastAPI()

# Add CORS middleware to allow cross-origin requests from Flutter app
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins (for testing purposes) or specify your Flutter app URL here
    allow_credentials=True,
    allow_methods=["*"],  # Allow all HTTP methods (GET, POST, etc.)
    allow_headers=["*"],  # Allow all headers
)

# Define the request model
class QueryRequest(BaseModel):
    query: str

# Define the response model
class QueryResponse(BaseModel):
    response: str
    law_reference: str | None = None  # Make this optional, in case it's not available
    source_link: str | None = None    # Same here

@app.post("/query", response_model=QueryResponse)
async def query_backend(request: QueryRequest):
    query = request.query
    # Query Firestore to find the response for the given question
    query_ref = db.collection('queries').where('query', '==', query).limit(1).get()
    
    if query_ref:
        # Assuming we found the data, retrieve the response, law reference, and source link
        data = query_ref[0].to_dict()
        response_text = data.get('response', "This is a response from Sofia!")
        law_reference = data.get('law_reference', None)  # Retrieve law reference
        source_link = data.get('source_link', None)      # Retrieve source link
        
        # You can now return these values in the response
        return QueryResponse(response=response_text, law_reference=law_reference, source_link=source_link)
    else:
        # If no matching question is found in Firestore, return the default response
        response_text = "This is a response from Sofia!"
        return QueryResponse(response=response_text, law_reference=None, source_link=None)
