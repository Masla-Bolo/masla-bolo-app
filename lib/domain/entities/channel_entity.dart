import '../../model/channel_json.dart';

class ChannelEntity {
  String id;
  String title;
  String description;
  ChannelType channelType;

  ChannelEntity({
    required this.id,
    required this.channelType,
    required this.description,
    required this.title,
  });

  factory ChannelEntity.empty() => ChannelEntity(
        id: '',
        title: '',
        description: '',
        channelType: ChannelType.text,
      );

  Map<String, dynamic> toChannelJson() {
    return ChannelJson.copyWith(this).toJson();
  }
}
