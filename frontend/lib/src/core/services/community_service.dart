import 'package:socialearn/src/core/api/api_response/api_response.dart';
import 'package:socialearn/src/core/api/api_services/api_services.dart';
import 'package:socialearn/src/core/models/community_model.dart';
import 'package:socialearn/src/core/models/user_model.dart';
import 'package:socialearn/src/core/api/api_routes/api_routes.dart';
import 'package:socialearn/src/core/utils/logger.dart';

class CommunityService {
  Future<ApiResponse<Map<String, dynamic>>> createCommunity({
    required Map<String, dynamic> data,
  }) async {
    return Api().post(
      data: data,
      path: ApiRoutes.createCommunity,
      createApiRes: (response) {
        // Correct usage of the static method ApiResponse.fromJson
        return ApiResponse<Map<String, dynamic>>.fromJson(
          response.data,
          (data) => data, // Parse UserModel from JSON
        );
      },
    );
  }

  Future<ApiResponse<List<CommunityModel>>> getAllCommunities() async {
    return Api().get(
      path: ApiRoutes.getAllCommunities,
      createApiRes: (response) {
        return ApiResponse<List<CommunityModel>>.fromJson(
          response.data,
          (data) => (data['documents'] as List)
              .map((community) => CommunityModel.fromJson(community))
              .toList(), // Parse the list of CommunityModels
        );
      },
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> subscribeCommunity({
    required Map<String, dynamic> data,
    required String communityId,
  }) async {
    return Api().put(
      data: data,
      path: ApiRoutes.subscribeCommunities(communityId),
      createApiRes: (response) {
        // Correct usage of the static method ApiResponse.fromJson
        return ApiResponse<Map<String, dynamic>>.fromJson(
          response.data,
          (data) => data, // Parse UserModel from JSON
        );
      },
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> unsubscribeCommunity({
    required Map<String, dynamic> data,
    required String communityId,
  }) async {
    return Api().put(
      data: data,
      path: ApiRoutes.unsubscribeCommunities(communityId),
      createApiRes: (response) {
        // Correct usage of the static method ApiResponse.fromJson
        return ApiResponse<Map<String, dynamic>>.fromJson(
          response.data,
          (data) => data, // Parse UserModel from JSON
        );
      },
    );
  }
}
