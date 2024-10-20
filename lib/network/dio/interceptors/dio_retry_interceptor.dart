import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';

typedef RetryEvaluator = FutureOr<bool> Function(DioException error);

// retry_options.dart
class RetryOptions {
  final int retries;
  final Duration retryInterval;
  final RetryEvaluator retryEvaluator;

  const RetryOptions({
    this.retries = 3,
    this.retryInterval = const Duration(seconds: 1),
    RetryEvaluator? retryEvaluator,
  }) : retryEvaluator = retryEvaluator ?? defaultRetryEvaluator;

  static Future<bool> defaultRetryEvaluator(DioException error) async {
    return error.type != DioExceptionType.cancel;
  }
}

// retry_interceptor.dart
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final RetryOptions options;

  RetryInterceptor({
    required this.dio,
    RetryOptions? options,
  }) : options = options ?? const RetryOptions();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    var retriesRemaining = options.retries;

    while (retriesRemaining > 0) {
      if (!await options.retryEvaluator(err)) {
        break;
      }

      retriesRemaining--;

      try {
        log('🔄 Retrying request (${options.retries - retriesRemaining}/${options.retries})');

        if (options.retryInterval.inMilliseconds > 0) {
          await Future.delayed(options.retryInterval);
        }

        final response = await dio.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
        );

        return handler.resolve(response);
      } on DioException catch (e) {
        err = e;
        if (retriesRemaining == 0) {
          break;
        }
      }
    }

    return super.onError(err, handler);
  }
}
