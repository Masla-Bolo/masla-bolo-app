import '../model/user_json.dart';

class UserEntity {
  String? email;
  String? username;
  String? password;
  String? image;
  int? id;
  bool? isSocial;
  bool? emailVerified;
  String? role;

  UserEntity({
    this.isSocial,
    this.image,
    this.emailVerified,
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
    bool? emailVerified,
    String? role,
  }) =>
      UserEntity(
        isSocial: isSocial ?? this.isSocial,
        image: image ?? this.image,
        id: id ?? this.id,
        emailVerified: emailVerified ?? this.emailVerified,
        email: email ?? this.email,
        role: role ?? this.role,
        password: password ?? this.password,
        username: username ?? this.username,
      );

  factory UserEntity.empty() => UserEntity(
        email: '',
        username: '',
        id: null,
        password: "",
        image: "",
      );

  Map<String, dynamic> toUserJson() {
    return UserJson.copyWith(this).toJson();
  }
}
