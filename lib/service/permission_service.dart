import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.notification,
      Permission.location,
    ].request();

    if (permissions[Permission.location]!.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.location.status.isPermanentlyDenied == true &&
                await Permission.location.status.isGranted == false) {
              permissionServiceCall();
            }
          }
        },
      );
    } else {
      if (permissions[Permission.location]!.isDenied) {
        permissionServiceCall();
      }
    }

    return permissions;
  }

  Future<void> permissionServiceCall() async {
    await permissionServices().then(
      (permissions) {
        if (permissions[Permission.location]!.isGranted) {}
      },
    );
  }
}
