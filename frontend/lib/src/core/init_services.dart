import 'package:gainup/core/backend/repo/auth_repo.dart';
import 'package:permission_handler/permission_handler.dart';

class InitService {
  static final InitService _instance = InitService._();
  factory InitService() => _instance;
  InitService._();

  init() async {
    authRepo.navigateUser();
    await authRepo.getUserById();
  }

  permissions() async {
    PermissionStatus notificationStatus =
        await Permission.notification.request();

    PermissionStatus storageStatus = await Permission.storage.request();

    if (storageStatus.isGranted) {
    } else if (storageStatus.isLimited) {
      await Permission.storage.request();
    } else if (storageStatus.isDenied) {
      await Permission.storage.request();
    }

    if (notificationStatus.isGranted) {
    } else if (notificationStatus.isLimited) {
      await Permission.notification.request();
    } else if (notificationStatus.isDenied) {
      await Permission.notification.request();
    }
  }
}
