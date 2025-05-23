class QuestionnaireRequest {
  final String email;
  // final int feeling;
  // final String mood;
  final List<int> emotion;

  QuestionnaireRequest({
    required this.email,
    // required this.feeling,
    // required this.mood,
    required this.emotion,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      // "feeling": feeling,
      // "mood": mood,
      "emotion": emotion,
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
