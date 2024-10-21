import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialearn/src/core/api/api_response/api_response.dart';
import 'package:socialearn/src/core/models/community_model.dart'; // Import the Community model
import 'package:socialearn/src/core/pref_service/pref_service.dart';
import 'package:socialearn/src/core/routes/routes.dart';
import 'package:socialearn/src/core/services/community_service.dart';
import 'package:socialearn/src/core/utils/logger.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  // Change the list type to CommunityModel instead of Map<String, dynamic>
  RxList<CommunityModel> getAllCommunitiesList = <CommunityModel>[].obs;

  Future<void> signout() async {
    await prefs.clear();
    Get.toNamed(Routes.LOGIN);
  }

  @override
  void onInit() {
    super.onInit();
    getAllCommunities();
  }

  // Fetch all communities and map the response to the CommunityModel
  Future<void> getAllCommunities() async {
    try {
      isLoading.value = true; // Set loading to true
      ApiResponse<List<CommunityModel>> res =
          await CommunityService().getAllCommunities();
      isLoading.value = false; // Set loading to false after API call

      if (res.isSuccess() && res.data != null) {
        // Log the entire response data
        logger.i('Full Response: ${res.data!}');

        // Extract community data from the response
        List<CommunityModel> getAllCommunitiesData =
            res.data!; // Correctly assign data
        logger.i("Communities Data: ${getAllCommunitiesData.toList()}");

        if (getAllCommunitiesData.isNotEmpty) {
          // Directly assign the list to getAllCommunitiesList
          getAllCommunitiesList.value = getAllCommunitiesData;
          logger.i("Communities List: ${getAllCommunitiesList.toList()}");
        } else {
          logger.i('No communities found in the response.');
        }
      } else {
        logger.i('Error occurred while fetching the communities');
      }
    } catch (e) {
      isLoading.value = false; // Set loading to false on error
      logger.f('Error occurred: $e');
    }
  }

  Future<void> subscribeCommunity({communityId}) async {
    Map<String, dynamic> body = {
      "user": prefs.getUser()!.id,
    };

    try {
      isLoading.value = true; // Set loading to true
      ApiResponse<Map<String, dynamic>> res = await CommunityService()
          .subscribeCommunity(data: body, communityId: communityId);
      isLoading.value = false; // Set loading to false after API call

      logger.i("-------${res.data!}");

      if (res.isSuccess() && res.data != null) {
        // Log the entire response data
        logger.i(res.data!);

        await getAllCommunities();

        // Extract user data from the response
        Map<String, dynamic> communityData = res.data!['community'];
        CommunityModel communityModel = CommunityModel.fromJson(
            communityData); // Convert user data to UserModel

        if (communityModel.id.isNotEmpty) {
          logger.i("========>${communityModel.toJson()}");
          // Get.toNamed(Routes.HOME);
        }
      } else {
        logger.i('Error occurred while registering user');
      }
    } catch (e) {
      isLoading.value = false; // Set loading to false on error
      logger.f('Error occurred: $e');
    }
  }

  Future<void> unsubscribeCommunity({communityId}) async {
    Map<String, dynamic> body = {
      "user": prefs.getUser()!.id,
    };

    try {
      isLoading.value = true; // Set loading to true
      ApiResponse<Map<String, dynamic>> res = await CommunityService()
          .unsubscribeCommunity(data: body, communityId: communityId);
      isLoading.value = false; // Set loading to false after API call

      logger.i("-------${res.data!}");

      if (res.isSuccess() && res.data != null) {
        // Log the entire response data
        logger.i(res.data!);

        await getAllCommunities();

        // // Extract user data from the response
        // Map<String, dynamic> communityData = res.data!['community'];
        // CommunityModel communityModel = CommunityModel.fromJson(
        //     communityData); // Convert user data to UserModel
        //
        // if (communityModel.id.isNotEmpty) {
        //   logger.i("========>${communityModel.toJson()}");
        //   // Get.toNamed(Routes.HOME);
        // }
      } else {
        logger.i('Error occurred while registering user');
      }
    } catch (e) {
      isLoading.value = false; // Set loading to false on error
      logger.f('Error occurred: $e');
    }
  }
}
