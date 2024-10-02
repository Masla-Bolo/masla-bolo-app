import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/domain/model/user_json.dart';

import '../entities/issue_entity.dart';

class IssueJson {
  int id;
  String title;
  List<String> images;
  String description;
  List<String> categories;
  int likesCount;
  int commentsCount;
  bool isAnonymous;
  double latitude;
  double longitude;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  UserEntity user;

  IssueJson({
    required this.id,
    required this.description,
    required this.images,
    required this.title,
    required this.categories,
    required this.likesCount,
    required this.commentsCount,
    required this.isAnonymous,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory IssueJson.fromJson(Map<String, dynamic> json) {
    return IssueJson(
      id: json['id'],
      description: json['description'],
      images: json['images'].isNotEmpty ? getStringList(json["images"]) : [],
      title: json['title'],
      categories: json['categories'].isNotEmpty
          ? getStringList(json["categories"])
          : [],
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      isAnonymous: json['is_anonymous'],
      latitude: double.tryParse(json['latitude']) ?? 0,
      longitude: double.tryParse(json['longitude']) ?? 0,
      status: json['issue_status'],
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
      user: UserJson.fromData(json['user']).toDomain(),
    );
  }

  factory IssueJson.copyWith(IssueEntity serverEntity) => IssueJson(
        id: serverEntity.id,
        title: serverEntity.title,
        description: serverEntity.description,
        categories: serverEntity.categories,
        images: serverEntity.images,
        likesCount: serverEntity.likesCount,
        commentsCount: serverEntity.commentsCount,
        isAnonymous: serverEntity.isAnonymous,
        latitude: serverEntity.latitude,
        longitude: serverEntity.longitude,
        status: serverEntity.status,
        createdAt: serverEntity.createdAt,
        updatedAt: serverEntity.updatedAt,
        user: serverEntity.user,
      );

  IssueEntity toDomain() => IssueEntity(
        id: id,
        description: description,
        images: images,
        title: title,
        categories: categories,
        likesCount: likesCount,
        commentsCount: commentsCount,
        isAnonymous: isAnonymous,
        latitude: latitude,
        longitude: longitude,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
        user: user,
      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'images': [
        "http://pakistanhouse.net/wp-content/uploads/2022/07/a-flooded-flooded-road-in-karachi-1657258177-8149.jpg"
      ],
      'categories': categories,
      "is_anonymous": isAnonymous,
      "latitude": 40.712776,
      "longitude": -74.005974,
    };
  }
}
