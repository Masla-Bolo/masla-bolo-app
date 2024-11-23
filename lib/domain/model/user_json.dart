import 'package:masla_bolo_app/domain/model/base_model.dart';

import '../entities/location.dart';
import '../entities/user_entity.dart';

enum UserRole { user, official }

class UserJson implements BaseModel<UserEntity> {
  String? username;
  String? password;
  String? email;
  String? image;
  bool? verified;
  String? role;
  int? id;
  bool? isSocial;
  Location location;

  UserJson({
    required this.location,
    this.verified = false,
    this.isSocial,
    this.image,
    this.id,
    this.password,
    this.role,
    this.username,
    this.email,
  });

  factory UserJson.fromData(Map<String, dynamic> json) {
    return UserJson(
      email: json["email"],
      image: json["profile_image"],
      isSocial: json["is_social"],
      username: json["username"],
      id: json['id'],
      verified: json["verified"],
      role: json["role"],
      location: Location.empty(),
    );
  }

  @override
  UserEntity toDomain() {
    return UserEntity(
      username: username,
      email: email,
      id: id,
      isSocial: isSocial,
      image: image,
      role: role,
      location: location,
      verified: verified ?? false,
    );
  }

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
        isSocial: userEntity.isSocial,
        location: userEntity.location,
      );

  Map<String, dynamic> toJson() {
    return {
      "is_social": isSocial,
      'username': username,
      'email': email,
      "profile_image": image,
      "id": id,
      "role": role,
      "password": password,
      "latitude": location.latitude,
      "longitude": location.longitude,
    };
  }
}
