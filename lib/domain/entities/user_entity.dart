import 'package:masla_bolo_app/domain/entities/location.dart';

import '../model/user_json.dart';

class UserEntity {
  String? email;
  String? username;
  String? password;
  String? image;
  int? id;
  bool? isSocial;
  bool? verified;
  String? role;
  Location location;
  UserEntity({
    this.isSocial,
    this.image,
    Location? location,
    this.verified,
    this.email,
    this.role = "user",
    this.password,
    this.username,
    this.id,
  }) : location = location ?? Location.empty();

  UserEntity copyWith({
    String? email,
    String? username,
    String? password,
    String? image,
    int? id,
    bool? isSocial,
    Location? location,
    bool? verified,
    String? role,
  }) =>
      UserEntity(
        location: location ?? this.location,
        isSocial: isSocial ?? this.isSocial,
        image: image ?? this.image,
        id: id ?? this.id,
        verified: verified ?? this.verified,
        email: email ?? this.email,
        role: role ?? this.role,
        password: password ?? this.password,
        username: username ?? this.username,
      );

  factory UserEntity.empty() => UserEntity(
        email: '',
        username: '',
        verified: false,
        role: "user",
        id: null,
        password: "",
        image: "",
      );

  Map<String, dynamic> toJson() {
    return UserJson.copyWith(this).toJson();
  }
}
