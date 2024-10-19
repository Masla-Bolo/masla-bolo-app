import 'package:geolocator/geolocator.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';

class LocationService {
  late Position _position;
  Position get position => _position;
  setPosition(Position newPosition) => _position = newPosition;

  Future<Position> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    while (!serviceEnabled) {
      showToast(
          "Location services are disabled, enable your locations to continue",
          params: ToastParam(
            duration: serviceEnabled
                ? null
                : const Duration(hours: 1000000000000000000),
          ));
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    }
    final position = await Geolocator.getCurrentPosition();
    setPosition(position);
    return position;
  }
}
