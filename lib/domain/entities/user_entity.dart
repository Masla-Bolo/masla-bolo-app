import '../model/user_json.dart';

class UserEntity {
  String? email;
  String? username;
  String? password;
  String? image;
  int? id;
  bool? isSocial;
  bool verified;
  String? role;
  double? latitude;
  double? longitude;
  UserEntity({
    this.isSocial,
    this.image,
    this.latitude,
    this.longitude,
    this.verified = false,
    this.email,
    this.role,
    this.password,
    this.username,
    this.id,
  });

  UserEntity copyWith({
    String? email,
    String? username,
    String? password,
    String? image,
    int? id,
    bool? isSocial,
    double? latitude,
    double? longitude,
    bool? emailVerified,
    String? role,
  }) =>
      UserEntity(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        isSocial: isSocial ?? this.isSocial,
        image: image ?? this.image,
        id: id ?? this.id,
        verified: emailVerified ?? verified,
        email: email ?? this.email,
        role: role ?? this.role,
        password: password ?? this.password,
        username: username ?? this.username,
      );

  factory UserEntity.empty() => UserEntity(
        email: '',
        username: '',
        latitude: 0,
        longitude: 0,
        id: null,
        password: "",
        image: "",
      );

  Map<String, dynamic> toUserJson() {
    return UserJson.copyWith(this).toJson();
  }
}
