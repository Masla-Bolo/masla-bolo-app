import 'package:masla_bolo_app/domain/entities/user_entity.dart';

enum UserRole { user, official }

class UserJson {
  String? username;
  String? password;
  String? email;
  String? role;
  int? id;

  UserJson({
    this.id,
    this.password,
    this.role,
    this.username,
    this.email,
  });

  factory UserJson.fromData(Map<String, dynamic> json) => UserJson(
        email: json["email"],
        username: json["username"],
        id: json['id'],
        role: json["role"],
      );

  UserEntity toDomain() => UserEntity(
        username: username,
        email: email,
        id: id,
      );

  static mapDataToRole(String data) {
    switch (data) {
      case 'user':
        return UserRole.user;
      case 'official':
        return UserRole.official;
      default:
        return UserRole.user;
    }
  }

  factory UserJson.copyWith(UserEntity userEntity) => UserJson(
        username: userEntity.username,
        email: userEntity.email,
        role: userEntity.role,
        id: userEntity.id,
        password: userEntity.password,
      );

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      "role": role,
      "password": password,
    };
  }
}
