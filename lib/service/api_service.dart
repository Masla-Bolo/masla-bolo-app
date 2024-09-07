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
