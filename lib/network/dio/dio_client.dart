import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../network_response.dart';

class DioClient {
  final List<Interceptor> interceptors;
  DioClient({
    required this.interceptors,
  }) {
    _initializeApiService();
  }
  static const baseUrl = 'http://192.168.1.106:8000/api';

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
    ),
  );

  void _initializeApiService() {
    dio.interceptors.addAll([
      ...interceptors,
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
  }

  NetworkResponse checkError(Response response) {
    final body = response.data;
    if (response.statusCode == 200 || response.statusCode == 201) {
      return NetworkResponse(
        code: body["code"] ?? 200,
        message: body["message"] ?? "",
        success: body["success"] ?? "",
        data: body["data"],
      );
    } else {
      throw NetworkResponse(
        code: body["code"] ?? 200,
        message: body["message"] ?? "Unknown error occurred",
        success: body["success"] ?? "false",
        data: body["data"],
      );
    }
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
