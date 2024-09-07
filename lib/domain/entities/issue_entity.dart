import '../../model/issue_json.dart';
import 'user_entity.dart';

class IssueEntity {
  String id;
  String title;
  String image;
  String description;
  List<UserEntity> members;

  IssueEntity({
    required this.id,
    required this.description,
    required this.image,
    required this.title,
    required this.members,
  });

  factory IssueEntity.empty() => IssueEntity(
        id: '',
        description: '',
        image: '',
        title: '',
        members: [],
      );

  Map<String, dynamic> toIssueJson() {
    return IssueJson.copyWith(this).toJson();
  }
}
