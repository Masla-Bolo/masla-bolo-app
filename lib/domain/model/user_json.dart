import '../entities/user_entity.dart';

enum UserRole { user, official }

class UserJson {
  String? username;
  String? password;
  String? email;
  String? image;
  bool? emailVerified;
  String? role;
  int? id;

  UserJson({
    this.image,
    this.emailVerified,
    this.id,
    this.password,
    this.role,
    this.username,
    this.email,
  });

  factory UserJson.fromData(Map<String, dynamic> json) => UserJson(
        email: json["email"],
        image: json["profile_image"],
        username: json["username"],
        id: json['id'],
        emailVerified: json["email_verified"],
        role: json["role"],
      );

  UserEntity toDomain() => UserEntity(
        username: username,
        email: email,
        id: id,
        image: image,
        role: role,
        emailVerified: emailVerified,
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
        image: userEntity.image,
      );

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      "profile_image": image,
      "id": id,
      "role": role,
      "password": password,
    };
  }
}
