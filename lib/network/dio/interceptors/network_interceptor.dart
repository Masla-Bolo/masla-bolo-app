import 'package:dio/dio.dart';

import '../../../data/local_storage/local_storage_repository.dart';
import '../../../helpers/strings.dart';
import '../../network_response.dart';

class NetworkInterceptor extends Interceptor {
  final LocalStorageRepository localStorageRepository;
  NetworkInterceptor(this.localStorageRepository);

  String _tokenValue = "";

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
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
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionError) {
      throw NetworkResponse(message: "Check your internet connection");
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    localStorageRepository.getValue(tokenKey).then(
          (result) => result.fold(
            (error) {},
            (token) {
              options.headers['Authorization'] = 'Bearer $token';
            },
          ),
        );
    return handler.next(options);
  }
}
