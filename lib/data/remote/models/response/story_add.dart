import 'package:json_annotation/json_annotation.dart';

part 'story_add.g.dart';

@JsonSerializable()
class StoryAdd {
  final bool error;
  final String message;

  StoryAdd({
    required this.error,
    required this.message,
  });

  factory StoryAdd.fromJson(Map<String, dynamic> json) => _$StoryAddFromJson(json);
  Map<String, dynamic> toJson() => _$StoryAddToJson(this);
}
