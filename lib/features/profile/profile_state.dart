import 'package:masla_bolo_app/domain/entities/issue_entity.dart';

class ProfileState {
  final List<IssueEntity> issues;
  final bool isLoaded;
  ProfileState({
    required this.issues,
    this.isLoaded = false,
  });

  factory ProfileState.empty() => ProfileState(
        issues: [],
      );

  copyWith({List<IssueEntity>? issues, bool? isLoaded}) => ProfileState(
        issues: issues ?? this.issues,
        isLoaded: isLoaded ?? this.isLoaded,
      );
}
