import 'package:json_annotation/json_annotation.dart';
import 'story.dart';

part 'story_list.g.dart';

@JsonSerializable()
class StoryList {
  final bool error;
  final String message;
  final List<Story> listStory;

  StoryList({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoryList.fromJson(Map<String, dynamic> json) => _$StoryListFromJson(json);
  Map<String, dynamic> toJson() => _$StoryListToJson(this);
}
