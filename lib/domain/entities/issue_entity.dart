import '../model/issue_json.dart';
import 'user_entity.dart';

class IssueEntity {
  int id;
  String title;
  bool isLiked;
  List<String> images;
  String description;
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

  IssueEntity({
    required this.id,
    required this.description,
    required this.isLiked,
    required this.images,
    required this.title,
    required this.categories,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.isAnonymous,
    required this.user,
  });

  factory IssueEntity.empty() => IssueEntity(
        id: 0,
        description: '',
        images: [],
        isLiked: false,
        title: '',
        categories: [],
        likesCount: 0,
        commentsCount: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        latitude: 0,
        longitude: 0,
        status: IssueStatus.notApproved,
        isAnonymous: false,
        user: UserEntity.empty(),
      );

  Map<String, dynamic> toIssueJson() {
    return IssueJson.copyWith(this).toJson();
  }
}
