import 'package:masla_bolo_app/domain/entities/issue_coordinates_entity.dart';

class IssueMapState {
  final List<IssueCoordinatesEntity> issues;
  final bool isLoading;
  IssueMapState({
    required this.issues,
    this.isLoading = false,
  });

  factory IssueMapState.initial() => IssueMapState(issues: []);

  IssueMapState copyWith({
    List<IssueCoordinatesEntity>? issues,
    bool? isLoading,
  }) {
    return IssueMapState(
      issues: issues ?? this.issues,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
