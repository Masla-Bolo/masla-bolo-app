import 'package:masla_bolo_app/domain/entities/issue_entity.dart';

class LikeIssueState {
  final List<IssueEntity> issues;
  final bool isLoaded;
  LikeIssueState({
    required this.issues,
    this.isLoaded = false,
  });

  factory LikeIssueState.empty() => LikeIssueState(issues: []);

  LikeIssueState copyWith({
    List<IssueEntity>? issues,
    bool? isLoaded,
  }) {
    return LikeIssueState(
        issues: issues ?? this.issues, isLoaded: isLoaded ?? this.isLoaded);
  }
}
