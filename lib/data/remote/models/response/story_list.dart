import 'package:picshare_app/data/remote/models/response/story.dart';

class StoryList {
  bool error;
  String message;
  List<Story> listStory;

  StoryList({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoryList.fromJson(Map<String, dynamic> json) {
    return StoryList(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
      listStory: (json['listStory'] as List<dynamic>)
          .map((storyJson) => Story.fromJson(storyJson))
          .toList(),
    );
  }
}
