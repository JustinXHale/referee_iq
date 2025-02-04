class ChatFlow {
  // Maps normalized user inputs to responses and follow-ups
  final Map<String, Map<String, dynamic>> conversationMap = {
    // Step 1: User asks a question about a high tackle
    "what is the correct sanction for a high tackle?": {
      "response": "What level is this game?",
      "choices": ["Youth", "Amateur/Club", "Professional"],
    },
    // Step 2: User selects level
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
// Step 3: User answers about head contact
"Yes": {
  "response":
      "According to World Rugby Law 9.13, a tackle above the shoulders is dangerous play. Since there is direct contact with the head, the minimum sanction is a yellow card and possibly a red card if there is forceful impact.",
  "links": [
    {"text": "Head Contact Process", "action": "switch_tab_sources"},  // Switch to Sources tab
    {"text": "World Rugby Laws", "url": "https://passport.world.rugby/laws-of-the-game/"}
  ],
},

    "no": {
      "response":
          "If there was no direct head contact, the sanction may vary depending on other factors, such as the tackler’s intent or the severity of the tackle.",
    },
    // Step 4: User requests a video example
    "i would like to see a video example": {
      "response": "Here’s a video example:",
      "videoUrl": "https://example.com/video/high-tackle-example",
    },
    // Step 5: User asks about mitigation factors
    "tell me about mitigation factors": {
      "response":
          "You can refer to the 2024 World Rugby Head Contact Process.\nWould you like to see a chart or another video?",
      "choices": ["Chart", "Video"],
    },
    // Step 6: User chooses a resource
    "chart": {
      "response":
          "Here is the 2024 World Rugby High Tackle Chart:\n[Link to chart]",
    },
    "video": {
      "response": "Here’s a video explaining mitigation factors:",
      "videoUrl": "https://example.com/video/mitigation-factors",
    },
  };

  // Method to retrieve the response for a given input
  Map<String, dynamic>? getResponse(String input) {
    // Normalize input to lowercase and trim whitespace
    String normalizedInput = input.toLowerCase().trim();
    return conversationMap[normalizedInput];
  }
}
