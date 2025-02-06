from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# Define the request model
class QueryRequest(BaseModel):
    query: str

# Define the response model
class QueryResponse(BaseModel):
    response: str

@app.post("/query", response_model=QueryResponse)
async def query_backend(request: QueryRequest):
    query = request.query
    # Here, integrate your ChatFlow logic or other query response logic.
    response_text = "This is a response from Sofia!"  # Simulated response
    return QueryResponse(response=response_text)
