class Login {
  bool error;
  String message;
  LoginResult loginResult;

  Login({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
      loginResult: LoginResult.fromJson(json['loginResult']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'loginResult': loginResult.toJson(),
    };
  }
}

class LoginResult {
  String userId;
  String name;
  String token;

  LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'token': token,
    };
  }
}
