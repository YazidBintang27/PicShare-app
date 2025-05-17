// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryDetail _$StoryDetailFromJson(Map<String, dynamic> json) => StoryDetail(
      error: json['error'] as bool,
      message: json['message'] as String,
      story: Story.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoryDetailToJson(StoryDetail instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
