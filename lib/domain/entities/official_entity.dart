import '../model/official_json.dart';
import 'issue_entity.dart';
import 'user_entity.dart';

class OfficialEntity {
  UserEntity? user;
  List<IssueEntity>? assignedIssue;
  String? countryCode;
  double? latitude;
  double? longitude;
  double? areaRange;

  OfficialEntity({
    this.user,
    this.assignedIssue,
    this.areaRange,
    this.countryCode,
    this.latitude,
    this.longitude,
  });

  factory OfficialEntity.empty() => OfficialEntity(
        user: UserEntity.empty(),
        assignedIssue: [],
        areaRange: 0,
        countryCode: '',
        latitude: 0,
        longitude: 0,
      );

  Map<String, dynamic> toOfficialJson() {
    return OfficialJson.copyWith(this).toJson();
  }
}
