import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:socialearn/src/core/api/api_response/api_response.dart';
import 'package:socialearn/src/core/api/api_routes/api_routes.dart';
import 'package:socialearn/src/core/pref_service/pref_service.dart';
import 'package:socialearn/src/core/utils/logger.dart';

class Api {
  static final Api _instance = Api._();

  factory Api() => _instance;
  String token = "";

  Api._();

  /// Set the header, including token and additional headers if needed.
  setHeader({
    Map<String, String>? headers,
    bool includeToken = true, // New parameter
  }) {
    // Retrieve token directly from the preference service
    token = PrefService.instance.getToken() ??
        ''; // Assuming you have a method to get the token

    if (kIsWeb) {
      _dio.options.headers.clear();
      if (includeToken && token.isNotEmpty) {
        _dio.options.queryParameters['token'] = token;
      }
      _dio.options.queryParameters.addAll(headers ?? {});
      logger.i('${_dio.options.queryParameters}');
    } else {
      if (includeToken && token.isNotEmpty) {
        _dio.options.headers['Authorization'] =
            'Bearer $token'; // Include Bearer token if true
      }
      _dio.options.headers.addAll(headers ?? {});
    }
  }

  static final Dio dio = Dio();
  static final Dio _dio = createDio();

  /// Create Dio instance with interceptors
  static Dio createDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
      baseUrl: ApiRoutes.baseUrl,
      connectTimeout: const Duration(seconds: 10), // Set timeout duration
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );
    dio.interceptors.add(ApiInterceptor()); // Add API Interceptor
    return dio;
  }

  /// POST Method with support for JSON and FormData
  Future<ApiResponse<T>> post<T>({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required ApiResponse<T> Function(Response) createApiRes,
    bool isFormData = false, // Option to send FormData
    bool includeToken = true, // New parameter for token inclusion
  }) async {
    try {
      setHeader(headers: headers, includeToken: includeToken); // Set headers
      DateTime time1 = DateTime.now();
      Response response = await _dio.post(
        path,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
      );
      DateTime time2 = DateTime.now();
      logger.i(time2.difference(time1)); // Logging time taken for request
      ApiResponse<T> apiResponse = createApiRes(response);
      logger.f("Header: ${_dio.options.headers}");
      logger.f("Query Params: ${_dio.options.queryParameters}");
      return apiResponse;
    } catch (e, t) {
      logger.e('$e');
      logger.t('$t');
      return ApiResponse.fromError(e.toString());
    }
  }

  /// GET Method
  Future<ApiResponse<T>> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required ApiResponse<T> Function(Response) createApiRes,
    bool includeToken = true, // New parameter for token inclusion
  }) async {
    try {
      setHeader(headers: headers, includeToken: includeToken); // Set headers
      Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      ApiResponse<T> apiResponse = createApiRes(response);
      return apiResponse;
    } catch (e) {
      log('$e');
      return ApiResponse.fromError(e.toString());
    }
  }

  /// Put Method
  Future<ApiResponse<T>> put<T>({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    required ApiResponse<T> Function(Response) createApiRes,
    bool isFormData = false, // Option to send FormData
    bool includeToken = true, // New parameter for token inclusion
  }) async {
    try {
      setHeader(headers: headers, includeToken: includeToken); // Set headers
      DateTime time1 = DateTime.now();
      Response response = await _dio.post(
        path,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(data ?? {}) : data,
      );
      DateTime time2 = DateTime.now();
      logger.i(time2.difference(time1)); // Logging time taken for request
      ApiResponse<T> apiResponse = createApiRes(response);
      logger.f("Header: ${_dio.options.headers}");
      logger.f("Query Params: ${_dio.options.queryParameters}");
      return apiResponse;
    } catch (e, t) {
      logger.e('$e');
      logger.t('$t');
      return ApiResponse.fromError(e.toString());
    }
  }
}

/// Helper function for adding a single image as `MultipartFile`
Future<MultipartFile> addImage({
  required File image,
  required String imageName,
}) async {
  return MultipartFile.fromFile(
    image.path,
    filename: imageName,
  );
}

/// Helper function for adding multiple images as `MultipartFile`
Future<List<MultipartFile>> addImages({
  required List<File> images,
}) async {
  List<MultipartFile> imageFiles = [];
  for (var image in images) {
    MultipartFile imageFile = await MultipartFile.fromFile(image.path);
    imageFiles.add(imageFile);
  }
  return imageFiles;
}

/// API Interceptor to handle requests, responses, and errors
class ApiInterceptor extends Interceptor {
  /// Intercepts requests
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      logger.i(
          "Sending ${options.method} request to ${options.path} with headers: ${options.headers}");
      return handler.next(options);
    } catch (e) {
      logger.e("Error in request: $e");
    }
  }

  /// Intercepts responses
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("${response.requestOptions.method} URL: ${response.requestOptions.path}, Body: ${response.requestOptions.data}, Query Params: ${response.requestOptions.queryParameters}\nResponse: ${jsonEncode(response.data)}");
    handler.next(response);
  }

  /// Intercepts errors and categorizes them
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeOutException(err.requestOptions);
      case DioExceptionType.sendTimeout:
        throw SendTimeOutException(err.requestOptions);
      case DioExceptionType.receiveTimeout:
        throw ReceiveTimeOutException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
          default:
            throw NoInternetConnectionException(err.requestOptions);
        }
      case DioExceptionType.cancel:
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
      default:
        throw NoInternetConnectionException(err.requestOptions);
    }
    handler.next(err);
  }
}

/// Exception classes for different error categories
class ConnectionTimeOutException extends DioError {
  ConnectionTimeOutException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Connection timed out, please try again.';
}

class SendTimeOutException extends DioError {
  SendTimeOutException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Send timed out, please try again.';
}

class ReceiveTimeOutException extends DioError {
  ReceiveTimeOutException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Receive timed out, please try again.';
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Invalid request.';
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Access denied.';
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'The requested resource was not found.';
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Conflict occurred.';
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'Internal server error, please try again later.';
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() => 'No internet connection, please try again.';
}
