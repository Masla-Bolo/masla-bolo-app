import '../../../../../../domain/entities/issue_entity.dart';
import '../../../../../../domain/model/paginate.dart';

class LikeIssueState {
  final Paginate<IssueEntity> issuesPagination;
  final bool isLoaded;
  final bool isScrolled;
  Map<String, dynamic> queryParams;
  LikeIssueState({
    this.isScrolled = false,
    required this.queryParams,
    required this.issuesPagination,
    this.isLoaded = false,
  });

  factory LikeIssueState.empty() => LikeIssueState(
        issuesPagination: Paginate.empty(),
        queryParams: {},
      );

  LikeIssueState copyWith({
    Paginate<IssueEntity>? issuesPagination,
    bool? isLoaded,
    bool? isScrolled,
  }) {
    return LikeIssueState(
        isScrolled: isScrolled ?? this.isScrolled,
        queryParams: {},
        issuesPagination: issuesPagination ?? this.issuesPagination,
        isLoaded: isLoaded ?? this.isLoaded);
  }
}
