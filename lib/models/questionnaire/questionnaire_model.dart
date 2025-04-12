class QuestionnaireRequest {
  final String email;
  final int feeling;
  final String mood;
  final List<String> emotion;

  QuestionnaireRequest({
    required this.email,
    required this.feeling,
    required this.mood,
    required this.emotion,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "feeling": feeling,
      "emotion": emotion,
      "mood": mood,
    };
  }
}

class QuestionnaireResponse {
  final int status;
  final String message;

  QuestionnaireResponse({
    required this.status,
    required this.message,
  });

  factory QuestionnaireResponse.fromJson(Map<String, dynamic> json) {
    return QuestionnaireResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}