class ChatFlow {
  // Maps user inputs to responses and follow-ups
  final Map<String, Map<String, dynamic>> conversationMap = {
    // Step 1: User asks a question
    "What is the correct sanction for a high tackle?": {
      "response": "What level is this game?",
      "choices": ["Youth (u18)", "Amateur/Club", "Professional"],
    },
    // Step 2: User selects level
    "Youth (u18)": {
      "response": "Did the tackler make direct head contact?",
      "choices": ["Yes", "No"],
    },
    // Step 3: User answers about head contact
    "Yes": {
      "response":
          "According to World Rugby Law 9.13, a tackle above the shoulders is dangerous play. Since there is direct contact with the head, the minimum sanction is a yellow card and possibly a red card if there is forceful impact.",
      "links": [
        {"text": "Head Contact Process", "url": "https://head-contact.example"},
        {"text": "World Rugby Laws", "url": "https://laws.example"}
      ],
    },
    "No": {
      "response": "If there was no direct head contact, the sanction may vary depending on other factors, such as the tackler’s intent or the severity of the tackle.",
    },
    // Step 4: User requests a video example
    "I would like to see a video example": {
      "response": "Here’s a video example:",
      "videoUrl": "https://example.com/video/high-tackle-example",
    },
    // Step 5: User asks about mitigation factors
    "Tell me about mitigation factors": {
      "response":
          "You can refer to the 2024 World Rugby Head Contact Process.\nWould you like to see a chart or another video?",
      "choices": ["Chart", "Video"],
    },
    // Step 6: User chooses a resource
    "Chart": {
      "response":
          "Here is the 2024 World Rugby High Tackle Chart:\n[Link to chart]",
    },
    "Video": {
      "response": "Here’s a video explaining mitigation factors:",
      "videoUrl": "https://example.com/video/mitigation-factors",
    },
  };

  // Method to retrieve the response for a given input
  Map<String, dynamic>? getResponse(String input) {
    return conversationMap[input];
  }
}