import 'package:picshare_app/data/remote/models/response/story.dart';

class StoryDetail {
  bool error;
  String message;
  Story story;

  StoryDetail({
    required this.error,
    required this.message,
    required this.story,
  });

  factory StoryDetail.fromJson(Map<String, dynamic> json) {
    return StoryDetail(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
      story: Story.fromJson(json['story']),
    );
  }
}
