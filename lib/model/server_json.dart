import 'package:masla_bolo_app/domain/entities/channel_entity.dart';
import 'package:masla_bolo_app/domain/entities/user_entity.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';
import 'package:masla_bolo_app/model/user_json.dart';

import '../domain/entities/server_entity.dart';
import 'channel_json.dart';

class ServerJson {
  String id;
  String title;
  String image;
  String description;
  List<UserEntity> members;
  List<ChannelEntity> channels;

  ServerJson({
    required this.id,
    required this.description,
    required this.image,
    required this.title,
    required this.members,
    required this.channels,
  });

  factory ServerJson.fromJson(Map<String, dynamic> json) {
    return ServerJson(
      id: json['id'],
      description: json['description'],
      image: json['image'],
      title: json['title'],
      members: parseList(json['members'], UserJson.fromData)
          .map((json) => json.toDomain())
          .toList(),
      channels: parseList(json['channels'], ChannelJson.fromJson)
          .map((json) => json.toDomain())
          .toList(),
    );
  }

  factory ServerJson.copyWith(ServerEntity serverEntity) => ServerJson(
        id: serverEntity.id,
        title: serverEntity.title,
        description: serverEntity.description,
        members: serverEntity.members,
        image: serverEntity.image,
        channels: serverEntity.channels,
      );

  ServerEntity toDomain() => ServerEntity(
        id: id,
        description: description,
        image: image,
        title: title,
        members: members,
        channels: channels,
      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'members': members.map((e) => e.id).toList(),
      'channels': channels.map((e) => e.id).toList(),
    };
  }
}
