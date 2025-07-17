import '../model/issue_coordinates_model.dart';

class IssueCoordinatesEntity {
  int id;
  String title;
  String status;
  IssueLocation location;

  IssueCoordinatesEntity({
    required this.id,
    required this.title,
    required this.status,
    required this.location,
  });
}
