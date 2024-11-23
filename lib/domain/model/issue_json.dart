import 'package:masla_bolo_app/domain/entities/location.dart';
import 'package:masla_bolo_app/domain/model/base_model.dart';
import 'package:masla_bolo_app/presentation/home/components/issue/issue_helper.dart';

import '../entities/user_entity.dart';
import '../../helpers/helpers.dart';
import 'user_json.dart';

import '../entities/issue_entity.dart';

enum IssueStatus {
  notApproved,
  approved,
  solving,
  officialSolved,
  solved,
}

class IssueJson implements BaseModel<IssueEntity> {
  int id;
  String title;
  List<String> images;
  String description;
  bool isLiked;
  List<String> categories;
  int likesCount;
  int commentsCount;
  bool isAnonymous;
  IssueStatus status;
  DateTime createdAt;
  DateTime updatedAt;
  UserEntity user;
  Location location;

  IssueJson({
    Location? location,
    required this.id,
    required this.isLiked,
    required this.description,
    required this.images,
    required this.title,
    required this.categories,
    required this.likesCount,
    required this.commentsCount,
    required this.isAnonymous,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  }) : location = location ?? Location.empty();

  factory IssueJson.fromJson(Map<String, dynamic> json) {
    return IssueJson(
      id: json['id'] ?? 0,
      isLiked: json["is_liked"] ?? false,
      description: json['description'] ?? "",
      images: json['images'].isNotEmpty ? getStringList(json["images"]) : [],
      title: json['title'] ?? "",
      categories: json['categories'].isNotEmpty
          ? getStringList(json["categories"])
          : [],
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      isAnonymous: json['is_anonymous'] ?? false,
      status: IssueHelper.mapStatus(json['issue_status'] ?? ""),
      createdAt: DateTime.tryParse(json['created_at'] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? "") ?? DateTime.now(),
      user: json['user'] != null
          ? UserJson.fromData(json['user']).toDomain()
          : UserEntity.empty(),
    );
  }

  factory IssueJson.copyWith(IssueEntity issueEntity) => IssueJson(
        id: issueEntity.id,
        isLiked: issueEntity.isLiked,
        title: issueEntity.title,
        description: issueEntity.description,
        categories: issueEntity.categories,
        images: issueEntity.images,
        location: issueEntity.location,
        likesCount: issueEntity.likesCount,
        commentsCount: issueEntity.commentsCount,
        isAnonymous: issueEntity.isAnonymous,
        status: issueEntity.status,
        createdAt: issueEntity.createdAt,
        updatedAt: issueEntity.updatedAt,
        user: issueEntity.user,
      );

  @override
  IssueEntity toDomain() => IssueEntity(
        isLiked: isLiked,
        id: id,
        fileImages: [],
        description: description,
        images: images,
        title: title,
        location: location,
        categories: categories,
        likesCount: likesCount,
        commentsCount: commentsCount,
        isAnonymous: isAnonymous,
        status: status,
        createdAt: createdAt,
        updatedAt: updatedAt,
        user: user,
      );

  Map<String, dynamic> createIssueToJson() {
    return {
      'title': title,
      "location": location.toJson(),
      'description': description,
      'images': images,
      'categories': categories,
      "is_anonymous": isAnonymous,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'title': title,
      'description': description,
      'images': images,
      'categories': categories,
      "is_anonymous": isAnonymous,
      "user": user.toJson(),
      "likes_count": likesCount,
      "issue_status": IssueHelper.getIssueStatus(status),
      "comments_count": commentsCount,
      "is_liked": isLiked,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
