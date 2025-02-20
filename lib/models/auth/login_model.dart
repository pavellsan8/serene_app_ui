class LoginModel {
  String email;
  String password;
  bool rememberMe;

  LoginModel({required this.email, required this.password, this.rememberMe = false});
}