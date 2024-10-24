import '../entities/user_entity.dart';
import '../../helpers/helpers.dart';
import 'user_json.dart';

import '../entities/issue_entity.dart';

enum IssueStatus {
  notApproved,
  approved,
  solving,
  officialSolved,
  completed,
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
  double latitude;
  double longitude;
  IssueStatus status;
  DateTime createdAt;
  DateTime updatedAt;
  UserEntity user;

  IssueJson({
    required this.id,
    required this.isLiked,
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
      latitude: double.tryParse(json['latitude']) ?? 0,
      longitude: double.tryParse(json['longitude']) ?? 0,
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
      case 'completed':
        return IssueStatus.completed;
      default:
        return IssueStatus.notApproved;
    }
  }

  factory IssueJson.copyWith(IssueEntity serverEntity) => IssueJson(
        id: serverEntity.id,
        isLiked: serverEntity.isLiked,
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
        isLiked: isLiked,
        id: id,
        fileImages: [],
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
      'images': images,
      'categories': categories,
      "is_anonymous": isAnonymous,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
