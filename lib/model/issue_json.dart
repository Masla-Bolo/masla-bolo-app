import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/model/user_json.dart';

import '../domain/entities/issue_entity.dart';

class IssueJson {
  String id;
  String title;
  String image;
  String description;
  List<UserEntity> members;

  IssueJson({
    required this.id,
    required this.description,
    required this.image,
    required this.title,
    required this.members,
  });

  factory IssueJson.fromJson(Map<String, dynamic> json) {
    return IssueJson(
      id: json['id'],
      description: json['description'],
      image: json['image'],
      title: json['title'],
      members: parseList(json['members'], UserJson.fromData)
          .map((json) => json.toDomain())
          .toList(),
    );
  }

  factory IssueJson.copyWith(IssueEntity serverEntity) => IssueJson(
        id: serverEntity.id,
        title: serverEntity.title,
        description: serverEntity.description,
        members: serverEntity.members,
        image: serverEntity.image,
      );

  IssueEntity toDomain() => IssueEntity(
        id: id,
        description: description,
        image: image,
        title: title,
        members: members,
      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'members': members.map((e) => e.id).toList(),
    };
  }
}
