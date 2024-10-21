import 'package:gainup/core/backend/models/bookmark_model.dart';
import 'package:gainup/core/backend/models/user_model.dart';
import 'package:gainup/core/pref_service/pref_service.dart';
import 'package:gainup/core/routes/routes.dart';
import 'package:gainup/core/utils/logger.dart';
import 'package:get/get.dart';

import '../api/api_response.dart';
import '../api/api_services/api_services.dart';
import '../services/user_service.dart';

AuthRepo authRepo = Get.put(AuthRepo());

class AuthRepo extends GetxController {
  final Rx<UserModel> _user = UserModel.emptyJson().obs;

  UserModel get user => _user.value;

  set user(UserModel userModel) {
    prefs.setUser(userModel);
    Api().setHeader(
      token: userModel.token,
    );
    _user.value = userModel;
    logger.f(_user.value.id);
  }

  navigateUser() async {
    UserModel? userModel = prefs.getUser();
    if (userModel != null) {
      user = userModel;
      if (userModel.id == 0) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.offAllNamed(Routes.DASHBOARD);
      }
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  Future<void> getUserById() async {
    Map<String, dynamic> body = {
      "f_id": prefs.getUser()!.fId,
    };
    try {
      logger.f(prefs.getUser()!.email);
      ApiResponse<UserModel> res = await UserService().getUserById(data: body);
      if (res.isSuccess) {
        logger.i('==========  ==========');
        UserModel model = res.r!;
        model.token = prefs.getUser()!.token;
        user = model;
      } else {
        logger.i('========== ERROR IN GET USER BY ID ==========');
      }
    } catch (e) {
      logger.f('========== $e ==========');
    }
  }

  RxList<BookmarkModel> getAllBookmarksList = <BookmarkModel>[].obs;
}
