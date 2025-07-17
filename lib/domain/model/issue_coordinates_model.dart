import 'package:masla_bolo_app/domain/entities/issue_coordinates_entity.dart';

class IssueCoordinatesModel {
  int id;
  String title;
  String status;
  IssueLocation location;

  IssueCoordinatesModel({
    required this.id,
    required this.title,
    required this.status,
    required this.location,
  });

  factory IssueCoordinatesModel.fromJson(Map<String, dynamic> json) {
    final coordinates = json['coordinates'] as List<dynamic>;
    double lat = 0.0;
    double long = 0.0;
    if (coordinates.isNotEmpty && coordinates.length == 2) {
      long = coordinates[0];
      lat = coordinates[1];
    }
    return IssueCoordinatesModel(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      location: IssueLocation(
        latitude: lat,
        longitude: long,
      ),
    );
  }

  IssueCoordinatesEntity toDomain() => IssueCoordinatesEntity(
        id: id,
        title: title,
        status: status,
        location: location,
      );
}

class IssueLocation {
  double latitude;
  double longitude;

  IssueLocation({
    required this.latitude,
    required this.longitude,
  });
}
