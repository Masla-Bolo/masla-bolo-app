import '../../domain/entities/issue_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/model/paginate.dart';

class ProfileState {
  UserEntity user;
  ProfileState({
    required this.user,
  });

  factory ProfileState.empty() => ProfileState(
        user: UserEntity.empty(),
      );

  copyWith({
    UserEntity? user,
  }) =>
      ProfileState(
        user: user ?? this.user,
      );
}

class MyIssuesState {
  final bool isLoaded;
  final Paginate<IssueEntity> issues;
  final bool isScrolled;

  MyIssuesState({
    required this.issues,
    this.isLoaded = false,
    this.isScrolled = false,
  });

  factory MyIssuesState.empty() => MyIssuesState(issues: Paginate.empty());

  MyIssuesState copyWith({
    Paginate<IssueEntity>? issues,
    bool? isLoaded,
    bool? isScrolled,
  }) =>
      MyIssuesState(
        issues: issues ?? this.issues,
        isLoaded: isLoaded ?? this.isLoaded,
        isScrolled: isScrolled ?? this.isScrolled,
      );
}
