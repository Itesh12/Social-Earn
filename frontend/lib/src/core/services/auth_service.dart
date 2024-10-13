import 'package:socialearn/src/core/api_response/api_response.dart';
import 'package:socialearn/src/core/api_services/api_services.dart';
import 'package:socialearn/src/core/models/user_model.dart';
import 'package:socialearn/src/core/routes/api_routes.dart';

class AuthService {
  Future<ApiResponse<UserModel>> register({
    required Map<String, dynamic> data,
  }) async {
    return Api().post(
      data: data,
      isFormData: true,
      path: ApiRoutes.register,
      createApiRes: (response) {
        // Correct usage of the static method ApiResponse.fromJson
        return ApiResponse<UserModel>.fromJson(
          response.data,
          (data) => UserModel.fromJson(data), // Parse UserModel from JSON
        );
      },
    );
  }

  Future<ApiResponse<UserModel>> login({
    required Map<String, dynamic> data,
  }) async {
    return Api().post(
      data: data,
      isFormData: true,
      path: ApiRoutes.login,
      createApiRes: (response) {
        // Correct usage of the static method ApiResponse.fromJson
        return ApiResponse<UserModel>.fromJson(
          response.data,
          (data) => UserModel.fromJson(data), // Parse UserModel from JSON
        );
      },
    );
  }
}
