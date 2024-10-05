// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:masla_bolo_app/network/network_response.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helpers/strings.dart';

class ApiService {
  final LocalStorageRepository localStorageRepository;
  ApiService(this.localStorageRepository) {
    _initializeApiService();
  }
  static const baseUrl = 'http://192.168.1.106:8000/api';
  String _tokenValue = '';

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      contentType: 'application/json',
    ),
  );
  void _initializeApiService() {
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onResponse: (response, handler) {
          var body = response.data;
          if (body != null) {
            if (body["data"] != null) {
              if (body["data"]['token'] != null) {
                _tokenValue = body['data']['token'];
                localStorageRepository.setValue(tokenKey, _tokenValue);
              }
            }
          }
          return handler.next(response);
        },
        onRequest: (options, handler) {
          localStorageRepository.getValue(tokenKey).then(
                (result) => result.fold(
                  (error) {},
                  (token) {
                    options.headers['Authorization'] = 'Bearer $token';
                  },
                ),
              );
          return handler.next(options);
        },
        onError: (error, handler) {
          if (error.type == DioExceptionType.connectionError) {
            throw NetworkResponse(message: "Check your internet connection");
          }
          return handler.next(error);
        },
      ),
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
    try {
      final body = response.data;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          code: body["code"] ?? "",
          message: body["message"] ?? "",
          success: body["success"] ?? "",
          data: body["data"],
        );
      } else {
        throw NetworkResponse(
          code: body["code"] ?? "",
          message: body["message"] ?? "Unknown error occurred",
          success: body["success"] ?? "false",
        );
      }
    } on DioException catch (dioError) {
      print("DIO ERROR: $dioError");
      throw NetworkResponse(
        message: 'Check your network connectivity!',
      );
    }
  }
}
