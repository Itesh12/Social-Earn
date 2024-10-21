import 'package:get/get.dart';
import 'package:socialearn/src/core/models/user_model.dart';
import 'package:socialearn/src/core/pref_service/pref_service.dart';
import 'package:socialearn/src/core/routes/routes.dart';
import 'package:socialearn/src/core/utils/logger.dart';

AuthRepo authRepo = Get.put(AuthRepo());

class AuthRepo extends GetxController {
  final Rx<UserModel> _user = UserModel.emptyJson().obs;

  UserModel get user => _user.value;

  set user(UserModel userModel) {
    prefs.setUser(userModel);
    _user.value = userModel;
    logger.f(_user.value.id);
  }

  navigateUser() async {
    UserModel? userModel = prefs.getUser(); // Get the user from preferences
    if (userModel != null && userModel.id.isNotEmpty) {
      user = userModel; // Assign the user model if not null and has a valid ID
      Get.offAllNamed(
          Routes.HOME); // Navigate to the home screen if user ID is present
    } else {
      Get.offAllNamed(Routes
          .LOGIN); // Navigate to login if no user is found or the ID is empty
    }
  }

// Future<void> getUserById() async {
  //   Map<String, dynamic> body = {
  //     "f_id": prefs.getUser()!.fId,
  //   };
  //   try {
  //     logger.f(prefs.getUser()!.email);
  //     ApiResponse<UserModel> res = await UserService().getUserById(data: body);
  //     if (res.isSuccess) {
  //       logger.i('==========  ==========');
  //       UserModel model = res.r!;
  //       model.token = prefs.getUser()!.token;
  //       user = model;
  //     } else {
  //       logger.i('========== ERROR IN GET USER BY ID ==========');
  //     }
  //   } catch (e) {
  //     logger.f('========== $e ==========');
  //   }
  // }
}
