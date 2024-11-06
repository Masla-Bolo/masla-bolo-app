import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masla_bolo_app/presentation/profile/components/user_profile/user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileState.empty());
}
