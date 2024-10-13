import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/core/api_response/api_response.dart';
import 'package:socialearn/src/core/services/auth_service.dart';
import 'package:socialearn/src/core/utils/logger.dart';

class RegisterController extends GetxController {
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  Future<void> registerUser() async {
    Map<String, dynamic> body = {
      "username": usernameTextController.text.trim().toString(),
      "email": emailTextController.text.trim().toString(),
      "password": passwordTextController.text.trim().toString(),
    };
    try {
      // isLoading.value = true;
      ApiResponse res = await AuthService().register(data: body);
      if (res.isSuccess()) {
        // isLoading.value = false;
        logger.i("========>${res.data}");
      } else {
        logger.i('Error occurred while register of user');
        // isLoading.value = false;
      }
    } catch (e) {
      logger.f('Error occurred: $e');
      // isLoading.value = false;
    }
  }
}
