class ChatbotRequest {
  final String userInput;

  ChatbotRequest({
    required this.userInput,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_input": userInput,
    };
  }
}

class ChatbotResponse {
  final int status;
  final String message;
  final String response;

  ChatbotResponse({
    required this.status,
    required this.message,
    required this.response,
  });

  factory ChatbotResponse.fromJson(Map<String, dynamic> json) {
    return ChatbotResponse(
      status: json['status'],
      message: json['message'],
      response: json['response'],
    );
  }
}
