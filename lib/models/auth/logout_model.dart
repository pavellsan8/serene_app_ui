class LogoutResponse {
  final int status;
  final String message;

  LogoutResponse({
    required this.status,
    required this.message,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
