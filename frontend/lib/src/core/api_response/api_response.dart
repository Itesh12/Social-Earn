import 'dart:convert';

enum Status { success, error, loading }

class ApiResponse<T> {
  Status status;
  T? data;
  String? message;
  String token;
  String stackTrace;
  String url;
  Map<String, dynamic> queryParam;
  int? statusCode;

  // Constructor for loading state
  ApiResponse.loading({this.message})
      : status = Status.loading,
        token = "",
        data = null,
        stackTrace = "",
        url = "",
        queryParam = const {};

  // Constructor for success state
  ApiResponse.success(this.data, {this.message, this.statusCode})
      : status = Status.success,
        token = "",
        stackTrace = "",
        url = "",
        queryParam = const {};

  // Constructor for error state
  ApiResponse.error({this.message, this.data, this.statusCode})
      : status = Status.error,
        token = "",
        stackTrace = "",
        url = "",
        queryParam = const {};

  // Factory constructor to create an ApiResponse from JSON
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT, {
    int? statusCode,
  }) {
    try {
      if (!json.containsKey('data') || json['data'] == null) {
        throw Exception('Missing data field in response');
      }

      return ApiResponse.success(
        fromJsonT(json['data']),
        message: json['message'] ?? "Success",
        statusCode: json['statusCode'] ?? statusCode,
      );
    } catch (e, stackTrace) {
      print('Error: $e');
      print('StackTrace: $stackTrace');
      return ApiResponse.error(
        message: 'Data parsing error: ${e.toString()}',
        statusCode: 500,
      );
    }
  }

  // Factory constructor for JSON string parsing
  factory ApiResponse.fromJsonString(
    String jsonString,
    T Function(dynamic) fromJsonT, {
    int? statusCode,
  }) {
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return ApiResponse.fromJson(jsonMap, fromJsonT, statusCode: statusCode);
    } catch (e) {
      return ApiResponse.error(
        message: 'Failed to parse JSON string: $e',
        statusCode: 500,
      );
    }
  }

  // Static method for empty response
  static ApiResponse<T> fromEmptyJson<T>() {
    return ApiResponse.success(null, message: 'Success with no content');
  }

  // Static method for error response
  static ApiResponse<T> fromError<T>(String errorMessage, {int? statusCode}) {
    return ApiResponse.error(message: errorMessage, statusCode: statusCode);
  }

  bool isSuccess() => status == Status.success;

  bool isLoading() => status == Status.loading;

  bool isError() => status == Status.error;

  @override
  String toString() {
    return 'ApiResponse{status: $status, message: $message, data: $data, statusCode: $statusCode}';
  }
}
