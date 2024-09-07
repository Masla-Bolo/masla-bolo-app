import '../../model/server_json.dart';
import 'channel_entity.dart';
import 'user_entity.dart';

class ServerEntity {
  String id;
  String title;
  String image;
  String description;
  List<UserEntity> members;
  List<ChannelEntity> channels;

  ServerEntity({
    required this.id,
    required this.description,
    required this.image,
    required this.title,
    required this.members,
    required this.channels,
  });

  factory ServerEntity.empty() => ServerEntity(
        id: '',
        description: '',
        image: '',
        title: '',
        members: [],
        channels: [],
      );

  Map<String, dynamic> toServerJson() {
    return ServerJson.copyWith(this).toJson();
  }
}
