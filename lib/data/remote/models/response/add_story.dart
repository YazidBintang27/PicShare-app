class AddStory {
  bool error;
  String message;

  AddStory({
    required this.error,
    required this.message,
  });

  factory AddStory.fromJson(Map<String, dynamic> json) {
    return AddStory(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
