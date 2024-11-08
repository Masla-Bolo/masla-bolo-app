class Location {
  double latitude;
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.empty() => Location(
        latitude: 0,
        longitude: 0,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  copyWith({double? latitude, double? longitude}) => Location(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
