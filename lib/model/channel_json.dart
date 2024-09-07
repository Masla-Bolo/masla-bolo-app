import '../domain/entities/channel_entity.dart';

enum ChannelType { text, voice }

class ChannelJson {
  String id;
  String title;
  String description;
  ChannelType channelType;

  ChannelJson({
    required this.id,
    required this.channelType,
    required this.description,
    required this.title,
  });

  factory ChannelJson.fromJson(Map<String, dynamic> json) {
    return ChannelJson(
      id: json['id'],
      channelType: json['channelType'],
      description: json['description'],
      title: json['title'],
    );
  }

  factory ChannelJson.copyWith(ChannelEntity channelEntity) => ChannelJson(
        id: channelEntity.id,
        title: channelEntity.title,
        description: channelEntity.description,
        channelType: channelEntity.channelType,
      );

  ChannelEntity toDomain() => ChannelEntity(
        id: id,
        channelType: channelType,
        description: description,
        title: title,
      );

  ChannelType mapChannelType(String channelType) {
    switch (channelType) {
      case 'text':
        return ChannelType.text;
      case 'voice':
        return ChannelType.voice;
      default:
        return ChannelType.text;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'channelType': channelType == ChannelType.text ? 'text' : 'voice',
      'description': description,
      'title': title,
    };
  }
}
