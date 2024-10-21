import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/core/api/api_response/api_response.dart';
import 'package:socialearn/src/core/models/user_model.dart';
import 'package:socialearn/src/core/routes/routes.dart';
import 'package:socialearn/src/core/services/auth_service.dart';
import 'package:socialearn/src/core/utils/logger.dart';
import 'package:socialearn/src/screen/auth/login/sr_login.dart';

class RegisterController extends GetxController {
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  RxBool isLoading = false.obs; // RxBool to track loading state
  RxBool isObscureText = true.obs; // RxBool to check obscure text

  void toggleObscureText() {
    isObscureText.value = !isObscureText.value;
  }

  Future<void> registerUser() async {
    Map<String, dynamic> body = {
      "username": usernameTextController.text.trim(),
      "email": emailTextController.text.trim(),
      "password": passwordTextController.text.trim(),
    };

    try {
      isLoading.value = true; // Set loading to true
      ApiResponse<Map<String, dynamic>> res =
          await AuthService().register(data: body);
      isLoading.value = false; // Set loading to false after API call

      if (res.isSuccess() && res.data != null) {
        Map<String, dynamic> userData = res.data!['user'];
        UserModel userModel =
            UserModel.fromJson(userData); // Convert user data to UserModel
        logger.i(userModel.toJson());
        if (userModel.id.isNotEmpty) {
          logger.i("========>${userModel.toJson()}");
          Get.toNamed(Routes.LOGIN);
        }
      } else {
        logger.i('Error occurred while registering user');
      }
    } catch (e) {
      isLoading.value = false; // Set loading to false on error
      logger.f('Error occurred: $e');
    }
  }
}
