// Login request body
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}

// Login response body
class LoginResponse {
  final int status;
  final String message;
  final LoginData? data;

  LoginResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

// Login data from body 
class LoginData {
  final String email;
  final String accessToken;
  final String refreshToken;
  final bool submitQuestionnaire;

  LoginData({
    required this.email,
    required this.accessToken,
    required this.refreshToken,
    this.submitQuestionnaire = false,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      email: json['email'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      submitQuestionnaire: json['submit_questionnaire'] ?? false,
    );
  }
}
