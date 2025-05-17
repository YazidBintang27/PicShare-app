import 'package:json_annotation/json_annotation.dart';
import 'story.dart';

part 'story_detail.g.dart';

@JsonSerializable()
class StoryDetail {
  final bool error;
  final String message;
  final Story story;

  StoryDetail({
    required this.error,
    required this.message,
    required this.story,
  });

  factory StoryDetail.fromJson(Map<String, dynamic> json) => _$StoryDetailFromJson(json);
  Map<String, dynamic> toJson() => _$StoryDetailToJson(this);
}
