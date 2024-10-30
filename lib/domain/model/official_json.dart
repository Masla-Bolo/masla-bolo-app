import 'package:masla_bolo_app/helpers/helpers.dart';

import '../entities/issue_entity.dart';
import '../entities/official_entity.dart';
import '../entities/user_entity.dart';
import 'issue_json.dart';
import 'user_json.dart';

class OfficialJson {
  UserEntity? user;
  List<IssueEntity>? assignedIssue;
  String? countryCode;
  double? latitude;
  double? longitude;
  double? areaRange;

  OfficialJson({
    this.countryCode,
    this.assignedIssue,
    this.user,
    this.latitude,
    this.longitude,
    this.areaRange,
  });

  factory OfficialJson.copyWith(OfficialEntity entity) => OfficialJson(
        user: entity.user,
        assignedIssue: entity.assignedIssue,
        countryCode: entity.countryCode,
        latitude: entity.latitude,
        longitude: entity.longitude,
        areaRange: entity.areaRange,
      );

  factory OfficialJson.fromJson(Map<String, dynamic> json) => OfficialJson(
        assignedIssue: parseList(json['assigned_issues'], IssueJson.fromJson)
            .map(
              (issue) => issue.toDomain(),
            )
            .cast<IssueEntity>()
            .toList(),
        user: UserJson.fromData(json['user']).toDomain(),
        countryCode: json['country_code'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        areaRange: json['areaRange'],
      );

  OfficialEntity toDomain() => OfficialEntity(
        user: user,
        assignedIssue: assignedIssue,
        countryCode: countryCode,
        latitude: latitude,
        longitude: longitude,
        areaRange: areaRange,
      );

  Map<String, dynamic> toJson() {
    return {
      'user': user?.id,
      "latitude": latitude,
      "longitude": longitude,
      "area_range": areaRange,
    };
  }
}
