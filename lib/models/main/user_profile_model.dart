class UserProfileResponse {
  final int status;
  final String message;
  final UserData data;

  UserProfileResponse(
      {required this.status, required this.message, required this.data});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      status: json['status'],
      message: json['message'],
      data: UserData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class UserData {
  final String name;
  final String email;
  final String phoneNum;

  UserData({required this.name, required this.email, required this.phoneNum});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      email: json['email'],
      phoneNum: json['phoneNum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNum': phoneNum,
    };
  }
}
