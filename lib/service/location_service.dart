import 'package:geolocator/geolocator.dart';
import 'package:masla_bolo_app/helpers/helpers.dart';

class LocationService {
  Future<void> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      requestPermission();
    } else {
      await getLocation();
    }
  }

  Future<Position> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showToast(
          "Location services are disabled, enable your locations to continue");
      return Future.error("Location services are disabled!");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      showToast(
          "Location services are disabled, enable your locations to continue");
      return Future.error("Location services are disabled!");
    }

    return await Geolocator.getCurrentPosition();
  }
}
