import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/core/api/api_response/api_response.dart';
import 'package:socialearn/src/core/models/user_model.dart';
import 'package:socialearn/src/core/pref_service/pref_service.dart';
import 'package:socialearn/src/core/routes/routes.dart';
import 'package:socialearn/src/core/services/auth_service.dart';
import 'package:socialearn/src/core/utils/logger.dart';
import 'package:socialearn/src/screen/home/sr_home.dart';

class LoginController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  RxBool isLoading = false.obs; // RxBool to track loading state
  RxBool isObscureText = true.obs; // RxBool to check obscure text

  void toggleObscureText() {
    isObscureText.value = !isObscureText.value;
  }

  Future<void> loginUser() async {
    Map<String, dynamic> body = {
      "email": emailTextController.text.trim(),
      "password": passwordTextController.text.trim(),
    };

    try {
      isLoading.value = true; // Set loading to true
      ApiResponse<Map<String, dynamic>> res =
          await AuthService().login(data: body);
      isLoading.value = false; // Set loading to false after API call

      if (res.isSuccess() && res.data != null) {
        String token = res.token; // Extract token from response
        await PrefService.instance.setToken(token); // Save token

        // Log the entire response data
        logger.i(res.data!);

        // Extract user data from the response
        Map<String, dynamic> userData = res.data!['user'];
        UserModel userModel =
            UserModel.fromJson(userData); // Convert user data to UserModel
        await PrefService.instance.setUser(userModel); // Save user info

        if (userModel.id.isNotEmpty) {
          logger.i("========>${userModel.toJson()}");
          Get.toNamed(Routes.HOME);
        }
      } else {
        logger.i('Error occurred while logging in the user');
      }
    } catch (e) {
      isLoading.value = false; // Set loading to false on error
      logger.f('Error occurred: $e');
    }
  }
}
