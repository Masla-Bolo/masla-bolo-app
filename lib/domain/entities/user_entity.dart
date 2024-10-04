import 'package:masla_bolo_app/domain/model/user_json.dart';

class UserEntity {
  String? email;
  String? username;
  String? password;
  int? id;
  String? role;

  UserEntity({
    this.email,
    this.role,
    this.password,
    this.username,
    this.id,
  });

  factory UserEntity.empty() => UserEntity(
        email: '',
        username: '',
        id: null,
        password: "",
      );

  Map<String, dynamic> toUserJson() {
    return UserJson.copyWith(this).toJson();
  }
}
