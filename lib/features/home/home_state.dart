import 'package:masla_bolo_app/domain/entities/issue_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';

class HomeState {
  UserEntity? user;
  int serverIndex;
  List<IssueEntity> servers;
  IssueEntity currentServer;
  double panelOffsetX;
  double bottomBarOffset;
  HomeState({
    this.user,
    required this.servers,
    required this.currentServer,
    this.serverIndex = 0,
    this.bottomBarOffset = 0,
    this.panelOffsetX = 0,
  });

  copyWith({
    UserEntity? user,
    List<IssueEntity>? servers,
    IssueEntity? currentServer,
    double? panelOffsetX,
    double? bottomBarOffset,
    int? serverIndex,
  }) =>
      HomeState(
        servers: servers ?? this.servers,
        serverIndex: serverIndex ?? this.serverIndex,
        user: user ?? this.user,
        currentServer: currentServer ?? this.currentServer,
        panelOffsetX: panelOffsetX ?? this.panelOffsetX,
        bottomBarOffset: bottomBarOffset ?? this.bottomBarOffset,
      );

  factory HomeState.empty() => HomeState(
        user: UserEntity(email: '', id: '', name: ''),
        servers: [],
        currentServer: IssueEntity.empty(),
      );
}
