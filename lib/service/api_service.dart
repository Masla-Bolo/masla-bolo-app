import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:masla_bolo_app/domain/failures/network_failure.dart';
import 'package:masla_bolo_app/domain/repositories/local_storage_repository.dart';

import '../helpers/strings.dart';

class ApiService {
  final LocalStorageRepository localStorageRepository;
  ApiService(this.localStorageRepository) {
    _initializeApiService();
  }
  static const baseUrl = 'http://192.168.1.104:5000';
  String _tokenValue = '';
  bool listenerInitialized = false;
  Map<int, Future Function()> apiQueue = {};

  late Dio dio;
  void _initializeApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        final body = response.data;
        if (body != null) {
          if (body['token'] != null) {
            _tokenValue = body['token'];
            localStorageRepository.setValue(tokenKey, _tokenValue);
          }
        }
        return handler.next(response);
      },
      onRequest: (options, handler) {
        if (_tokenValue.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $_tokenValue';
        }
        return handler.next(options);
      },
    ));
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

  Either<NetworkFailure, Map<String, dynamic>> checkError(Response response) {
    final body = response.data;
    if ((response.statusCode == 200 || response.statusCode == 201) ||
        body['success'] == true) {
      return right(body);
    } else {
      return left(
        NetworkFailure(
          error:
              'Request ended with status code: ${response.statusCode}, with a Network error!',
        ),
      );
    }
  }
}
