import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/core/init_services.dart';
import 'package:socialearn/src/core/repo/auth_repo.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(); // This will make the animation continuously repeat
    super.onInit();
    Timer(const Duration(seconds: 2), () async {
      await InitService().init();
      // await authRepo.navigateUser();
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
