import '../entities/user_entity.dart';

enum UserRole { user, official }

class UserJson {
  String? username;
  String? password;
  String? email;
  String? image;
  bool? verified;
  String? role;
  int? id;
  bool? isSocial;
  double? latitude;
  double? longitude;

  UserJson({
    this.latitude,
    this.longitude,
    this.isSocial,
    this.image,
    this.verified,
    this.id,
    this.password,
    this.role,
    this.username,
    this.email,
  });

  factory UserJson.fromData(Map<String, dynamic> json) => UserJson(
        email: json["email"],
        image: json["profile_image"],
        isSocial: json["is_social"],
        username: json["username"],
        id: json['id'],
        verified: json["verified"],
        role: json["role"],
      );

  UserEntity toDomain() => UserEntity(
        username: username,
        email: email,
        id: id,
        isSocial: isSocial,
        image: image,
        role: role,
        verified: verified ?? false,
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
        latitude: userEntity.latitude,
        longitude: userEntity.longitude,
        isSocial: userEntity.isSocial,
      );

  Map<String, dynamic> toJson() {
    return {
      "is_social": isSocial,
      'username': username,
      'email': email,
      "profile_image": image,
      "id": id,
      "latitude": latitude,
      "longitude": longitude,
      "role": role,
      "password": password,
    };
  }
}
