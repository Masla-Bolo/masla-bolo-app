import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';

import '../../domain/stores/user_store.dart';
import '../../service/app_service.dart';

class ProfileState {
  final List<IssueEntity> issues;
  final bool isLoaded;
  final UserEntity user;
  ProfileState({
    required this.user,
    required this.issues,
    this.isLoaded = false,
  });

  factory ProfileState.empty() => ProfileState(
        issues: [],
        user: getIt<UserStore>().appUser,
      );

  copyWith({List<IssueEntity>? issues, bool? isLoaded, UserEntity? user}) =>
      ProfileState(
        issues: issues ?? this.issues,
        isLoaded: isLoaded ?? this.isLoaded,
        user: user ?? this.user,
      );
}
