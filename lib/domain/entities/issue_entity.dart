import 'package:image_picker/image_picker.dart';
import 'package:masla_bolo_app/domain/entities/location.dart';

import '../model/issue_json.dart';
import 'user_entity.dart';

class IssueEntity {
  int id;
  String title;
  bool isLiked;
  List<String> images;
  List<XFile> fileImages;
  String description;
  List<String> categories;
  int likesCount;
  int commentsCount;
  bool isAnonymous;
  IssueStatus status;
  DateTime createdAt;
  DateTime updatedAt;
  UserEntity user;
  Location location;
  bool seeMore; // for issuePost seemore-seeLess
  int currentIndex; // for issuePost pageView

  IssueEntity({
    this.seeMore = false,
    this.currentIndex = 0,
    required this.id,
    required this.location,
    required this.description,
    required this.fileImages,
    required this.isLiked,
    required this.images,
    required this.title,
    required this.categories,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.isAnonymous,
    required this.user,
  });

  factory IssueEntity.empty() => IssueEntity(
        id: 0,
        description: '',
        fileImages: [],
        images: [],
        isLiked: false,
        title: '',
        location: Location.empty(),
        categories: [],
        likesCount: 0,
        commentsCount: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: IssueStatus.notApproved,
        isAnonymous: false,
        user: UserEntity.empty(),
      );

  Map<String, dynamic> toJson() {
    return IssueJson.copyWith(this).toJson();
  }

  Map<String, dynamic> createIssueToJson() {
    return IssueJson.copyWith(this).createIssueToJson();
  }
}
