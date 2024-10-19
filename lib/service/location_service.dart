import 'package:geolocator/geolocator.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';

class LocationService {
  late Position _position;
  Position get position => _position;
  setPosition(Position newPosition) => _position = newPosition;

  Future<void> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    while (!serviceEnabled) {
      showToast(
          "Location services are disabled, enable your locations to continue");
      await Future.delayed(const Duration(seconds: 2));
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }
    setPosition(await Geolocator.getCurrentPosition());
  }
}
