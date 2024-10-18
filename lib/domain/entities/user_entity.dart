import '../model/user_json.dart';

class UserEntity {
  String? email;
  String? username;
  String? password;
  int? id;
  bool? emailVerified;
  String? role;

  UserEntity({
    this.emailVerified,
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
