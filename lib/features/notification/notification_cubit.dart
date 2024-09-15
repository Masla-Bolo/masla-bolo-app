import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/features/notification/notification_navigator.dart';

import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationNavigator navigator;
  NotificationCubit(this.navigator) : super(NotificationState.empty());

  void pop() {
    navigator.pop();
  }
}
