import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/core/api/api_response/api_response.dart';
import 'package:socialearn/src/core/models/community_model.dart';
import 'package:socialearn/src/core/pref_service/pref_service.dart';
import 'package:socialearn/src/core/routes/routes.dart';
import 'package:socialearn/src/core/services/community_service.dart';
import 'package:socialearn/src/core/utils/logger.dart';

class CommunityController extends GetxController {
  RxBool isLoading = false.obs; // RxBool to track loading state

  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();

  Future<void> createCommunity() async {
    Map<String, dynamic> body = {
      "name": nameTextController.text.trim(),
      "description": descriptionTextController.text.trim(),
    };

    try {
      isLoading.value = true; // Set loading to true
      ApiResponse<Map<String, dynamic>> res =
          await CommunityService().createCommunity(data: body);
      isLoading.value = false; // Set loading to false after API call

      logger.i("Request Body: ${body}");
      logger.i("Response Data: ${res.data}");

      if (res.isSuccess() && res.data != null) {
        logger.i(res.data);

        if (res.data!['community'] != null) {
          Map<String, dynamic> communityData = res.data!['community'];
          CommunityModel communityModel =
              CommunityModel.fromJson(communityData);

          if (communityModel.id.isNotEmpty) {
            logger.i("Community Created: ${communityModel.toJson()}");
            // Navigate to another page if needed
            // Get.toNamed(Routes.HOME);
          }
        } else {
          logger.i('Community data not found in the response.');
        }
      } else {
        logger.i('Error occurred while creating the community: ${res.message}');
      }
    } catch (e) {
      isLoading.value = false; // Set loading to false on error
      logger.e('Error occurred: $e');
    }
  }
}
