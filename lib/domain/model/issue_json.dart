import 'package:masla_bolo_app/domain/entities/location.dart';

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

class IssueJson {
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
      id: json['id'],
      isLiked: json["is_liked"],
      description: json['description'],
      images: json['images'].isNotEmpty ? getStringList(json["images"]) : [],
      title: json['title'],
      categories: json['categories'].isNotEmpty
          ? getStringList(json["categories"])
          : [],
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      isAnonymous: json['is_anonymous'],
      status: mapStatus(json['issue_status']),
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
      user: UserJson.fromData(json['user']).toDomain(),
    );
  }

  static IssueStatus mapStatus(String jsonStatus) {
    switch (jsonStatus) {
      case 'not_approved':
        return IssueStatus.notApproved;
      case 'approved':
        return IssueStatus.approved;
      case 'solving':
        return IssueStatus.solving;
      case 'official_solved':
        return IssueStatus.officialSolved;
      case 'solved':
        return IssueStatus.solved;
      default:
        return IssueStatus.notApproved;
    }
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

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      "location": location.toJson(),
      'description': description,
      'images': images,
      'categories': categories,
      "is_anonymous": isAnonymous,
    };
  }
}
