class StoryAdd {
  bool error;
  String message;

  StoryAdd({
    required this.error,
    required this.message,
  });

  factory StoryAdd.fromJson(Map<String, dynamic> json) {
    return StoryAdd(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
