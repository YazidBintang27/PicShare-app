import 'dart:io';

class AddStoryRequest {
  final String description;
  final File photo;
  final double? lat;
  final double? lon;

  AddStoryRequest({
    required this.description,
    required this.photo,
    this.lat,
    this.lon,
  });
}