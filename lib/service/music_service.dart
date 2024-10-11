import 'package:audioplayers/audioplayers.dart';

class MusicService {
  final likeUnlikeMusic = "audio/like_unlike.mp3";
  final notificationMusic = "audio/notification.mp3";
  final _player = AudioPlayer();

  void play(String source) async {
    // await _player.play(AssetSource(source, mimeType: "mp3"));
  }

  void pause() {
    _player.pause();
  }
}
