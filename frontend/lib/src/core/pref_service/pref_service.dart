import 'package:get_storage/get_storage.dart';
import 'package:socialearn/src/core/models/user_model.dart';
import 'package:socialearn/src/core/utils/logger.dart';

final PrefService prefs = PrefService();

class PrefService {
  static final PrefService instance = PrefService();
  final GetStorage storage = GetStorage();

  dynamic getValue({required String key}) {
    return storage.read(key);
  }

  Future<void> setValue({required String key, dynamic value}) async {
    await storage.write(key, value);
  }

  Future<void> setUser(UserModel userModel) async {
    await setValue(key: 'user', value: userModel.toJson());
    logger.i(storage.read('user').toString());
  }

  UserModel? getUser() {
    var r = getValue(key: 'user');
    logger.e("===========$r");
    if (r != null) {
      UserModel userModel = UserModel.fromJson(r);
      logger.e("===========${userModel.toJson}");
      if (userModel.id.isNotEmpty) {
        logger.f(userModel.toJson());
        return userModel;
      }
    }
    return null;
  }

  Future<void> setToken(String token) async {
    logger.i("token:- $token");
    await setValue(key: 'token', value: token); // Store the token
  }

  String? getToken() {
    return getValue(key: 'token'); // Retrieve the token
  }

  Future<void> removeValue(String key) async {
    await storage.remove(key);
  }

  Future<void> clear() async {
    await storage.erase(); // Clear all data if needed
  }
}
