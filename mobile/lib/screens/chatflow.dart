from fastapi import FastAPI
from pydantic import BaseModel
import random

app = FastAPI()

# Define the request model
class QueryRequest(BaseModel):
    query: str

# Define the response model
class QueryResponse(BaseModel):
    response: str
    choices: list = []  # For storing multiple choices, if applicable
    videoUrl: str = ""  # For video links if applicable
    links: list = []  # For any additional links

# Define the ChatFlow logic in a Python dictionary
class ChatFlow:
    conversation_map = {
        "what is the correct sanction for a high tackle?": {
            "response": "What level is this game?",
            "choices": ["Youth", "Amateur/Club", "Professional"],
        },
        "youth": {
            "response": "Did the tackler make direct head contact?",
            "choices": ["Yes", "No"],
        },
        "amateur/club": {
            "response": "Did the tackler make direct head contact?",
            "choices": ["Yes", "No"],
        },
        "professional": {
            "response": "Did the tackler make direct head contact?",
            "choices": ["Yes", "No"],
        },
        "yes": {
            "response":
                "According to World Rugby Law 9.13, a tackle above the shoulders is dangerous play. Since there is direct contact with the head, the minimum sanction is a yellow card and possibly a red card if there is forceful impact.",
            "links": [
                {"text": "Head Contact Process", "action": "switch_tab_sources"},
                {"text": "World Rugby Laws", "url": "https://passport.world.rugby/laws-of-the-game/"}
            ],
        },
        "no": {
            "response":
                "If there was no direct head contact, the sanction may vary depending on other factors, such as the tackler’s intent or the severity of the tackle.",
        },
        "i would like to see a video example": {
            "response": "Here’s a video example:",
            "videoUrl": "https://example.com/video/high-tackle-example",
        },
        "tell me about mitigation factors": {
            "response":
                "You can refer to the 2024 World Rugby Head Contact Process.\nWould you like to see a chart or another video?",
            "choices": ["Chart", "Video"],
        },
        "chart": {
            "response": "Here is the 2024 World Rugby High Tackle Chart:\n[Link to chart]",
        },
        "video": {
            "response": "Here’s a video explaining mitigation factors:",
            "videoUrl": "https://example.com/video/mitigation-factors",
        },
        "what is a red card?": {
            "response": "A red card is issued for serious foul play and results in the player's immediate expulsion from the game.",
            "links": [
                {"text": "Learn more about red cards", "url": "https://example.com/red-card-info"}
            ]
        },
    }

    # Function to get the response based on the input
    def get_response(self, input: str):
        normalized_input = input.lower().strip()  # Normalize the input
        return self.conversation_map.get(normalized_input, None)

# Initialize ChatFlow instance
chatflow = ChatFlow()

@app.post("/query", response_model=QueryResponse)
async def query_backend(request: QueryRequest):
    query = request.query
    response_data = chatflow.get_response(query)
    
    if response_data:
        # Return response data, including choices, video link, and additional links if available
        return QueryResponse(
            response=response_data['response'],
            choices=response_data.get('choices', []),
            videoUrl=response_data.get('videoUrl', ''),
            links=response_data.get('links', [])
        )
    else:
        # If no matching response is found, return a default message
        return QueryResponse(response="Sorry, I couldn't find an answer to that question.")
