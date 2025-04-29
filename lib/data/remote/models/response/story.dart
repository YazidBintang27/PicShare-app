class Story {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  double? lat; 
  double? lon; 
  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    this.lat, 
    this.lon, 
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      lat: (json['lat'] != null) ? (json['lat'] as num).toDouble() : null,
      lon: (json['lon'] != null) ? (json['lon'] as num).toDouble() : null,
    );
  }
}
