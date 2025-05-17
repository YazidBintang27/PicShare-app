import 'package:json_annotation/json_annotation.dart';

part 'add_story.g.dart';

@JsonSerializable()
class AddStory {
  final bool error;
  final String message;

  AddStory({
    required this.error,
    required this.message,
  });

  factory AddStory.fromJson(Map<String, dynamic> json) => _$AddStoryFromJson(json);
  Map<String, dynamic> toJson() => _$AddStoryToJson(this);
}
