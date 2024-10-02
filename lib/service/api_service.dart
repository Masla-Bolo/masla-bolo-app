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
  String tokenValue = '';
  bool listenerInitialized = false;
  Map<int, Future Function()> apiQueue = {};

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
              body["data"]["token"];
              if (body["data"]['token'] != null) {
                tokenValue = body['data']['token'];
                localStorageRepository.setValue(tokenKey, tokenValue);
              }
            }
          }
          return handler.next(response);
        },
        onRequest: (options, handler) {
          if (tokenValue.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $tokenValue';
          }
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

  Future<void> executeAll() async {
    while (apiQueue.isNotEmpty) {
      final key = apiQueue.keys.first;
      final apiCall = apiQueue[key]!;
      try {
        await apiCall.call();
        apiQueue.remove(key);
      } catch (e) {
        apiQueue.remove(key);
        await Future.delayed(const Duration(seconds: 1));
        executeAll();
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  void initializeListener() {
    listenerInitialized = true;
    Future.delayed(const Duration(minutes: 1), () {
      executeAll().then((_) => listenerInitialized = false);
    });
  }

  void addToQueue(int key, Future Function() value) {
    apiQueue.addAll({key: value});
    if (!listenerInitialized) {
      initializeListener();
    }
  }

  void removeFromQueue(int removeKey) {
    apiQueue.removeWhere((key, value) => key == removeKey);
  }

  NetworkResponse checkError(Response response) {
    final body = response.data;
    try {
      if ((response.statusCode == 200 || response.statusCode == 201)) {
        return NetworkResponse(data: body["data"]);
      } else {
        throw NetworkResponse(message: "${response.data["message"]}");
      }
    } on DioException catch (dioError) {
      print("DIO ERROR: $dioError");
      throw NetworkResponse(
        message: 'Check your network Connectivity!',
      );
    }
  }
}
