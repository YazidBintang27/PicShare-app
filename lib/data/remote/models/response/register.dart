class Register {
  bool error;
  String message;

  Register({
    required this.error,
    required this.message,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
