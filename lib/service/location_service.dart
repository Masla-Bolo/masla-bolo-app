import 'package:geolocator/geolocator.dart';

class LocationService {
  late Position _position;
  Position get position => _position;
  setPosition(Position newPosition) => _position = newPosition;

  Future<bool> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    final position = await Geolocator.getCurrentPosition();
    setPosition(position);
    return true;
  }
}
