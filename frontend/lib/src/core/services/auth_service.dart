import 'package:socialearn/src/core/api/api_response/api_response.dart';
import 'package:socialearn/src/core/api/api_services/api_services.dart';
import 'package:socialearn/src/core/models/user_model.dart';
import 'package:socialearn/src/core/api/api_routes/api_routes.dart';

class AuthService {
  Future<ApiResponse<Map<String, dynamic>>> register({
    required Map<String, dynamic> data,
  }) async {
    return Api().post(
      data: data,
      includeToken: false,
      path: ApiRoutes.register,
      createApiRes: (response) {
        // Correct usage of the static method ApiResponse.fromJson
        return ApiResponse<Map<String, dynamic>>.fromJson(
          response.data,
          (data) => data, // Parse UserModel from JSON
        );
      },
    );
  }

  Future<ApiResponse<Map<String, dynamic>>> login({
    required Map<String, dynamic> data,
  }) async {
    return Api().post(
      data: data,
      // isFormData: true,
      path: ApiRoutes.login,
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
