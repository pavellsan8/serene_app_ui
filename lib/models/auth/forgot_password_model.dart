class EmailOtpRequest {
  final String email;

  EmailOtpRequest({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class EmailOtpResponse {
  final int status;
  final String message;
  final int otpCode;

  EmailOtpResponse({
    required this.status,
    required this.message,
    required this.otpCode,
  });

  factory EmailOtpResponse.fromJson(Map<String, dynamic> json) {
    return EmailOtpResponse(
      status: json['status'],
      message: json['message'],
      otpCode: json['otp_code'],
    );
  }
}

class ResetPasswordRequest {
  final String email;
  final String password;

  ResetPasswordRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class ResetPasswordResponse {
  final int status;
  final String message;

  ResetPasswordResponse({
    required this.status,
    required this.message,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
