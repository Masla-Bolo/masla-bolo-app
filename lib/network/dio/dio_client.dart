import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../network_response.dart';
import 'interceptors/dio_retry_interceptor.dart';

class DioClient {
  final List<Interceptor> interceptors;
  bool _initialized = false;
  bool get initialized => _initialized;
  updateInitialize(bool value) {
    _initialized = value;
    if (!_initialized) {
      dio.close(force: true);
    } else {
      _initializeDioClient();
    }
  }

  DioClient({
    required this.interceptors,
  }) {
    _initializeDioClient();
  }
  static const baseUrl = 'http://192.168.1.106:8000/api';
  static const int maxRetries = 3;
  static const int retryDelay = 1;

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  void _initializeDioClient() {
    dio.interceptors.addAll([
      RetryInterceptor(
        dio: dio,
        options: RetryOptions(
          retries: maxRetries,
          retryInterval: const Duration(seconds: retryDelay),
          retryEvaluator: (error) async {
            if (error.type == DioExceptionType.connectionError ||
                error.type == DioExceptionType.connectionTimeout ||
                (error.response?.statusCode != null &&
                    error.response!.statusCode! >= 500)) {
              return true;
            }
            return false;
          },
        ),
      ),
      ...interceptors,
      if (kDebugMode)
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
          enabled: kDebugMode,
        )
    ]);
    _initialized = true;
  }

  static NetworkResponse handleDioError(DioException error) {
    String message = "";
    dynamic data;
    int code = 200;
    String success = "false";
    if (error.response?.data != null) {
      final responseData = error.response!.data;
      code = responseData["code"] ?? 200;
      message = responseData["message"] ?? "Unknown error occurred";
      data = responseData["data"] ?? "";
      success = responseData["success"] ?? "false";
    } else {
      switch (error.type) {
        case DioExceptionType.cancel:
          message = "Request to API server was cancelled";
          break;
        case DioExceptionType.connectionError:
          message = "Failed connection to API server";
        case DioExceptionType.connectionTimeout:
          message = "Connection timed out";
        case DioExceptionType.unknown:
          message = "Connection timeout with API server";
          break;
        case DioExceptionType.receiveTimeout:
          message = "Receive timeout in connection with API server";
          break;
        case DioExceptionType.badResponse:
          message =
              "Received invalid status code: ${error.response?.statusCode}";
          break;
        case DioExceptionType.sendTimeout:
          message = "Send timeout in connection with API server";
          break;
        case DioExceptionType.badCertificate:
          message = "Incorrect certificate";
          break;
      }
    }
    return NetworkResponse(
      code: code,
      message: message,
      data: data,
      success: success,
    );
  }
}
