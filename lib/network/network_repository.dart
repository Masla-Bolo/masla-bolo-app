import 'dart:async';

import 'package:dio/dio.dart';
import 'package:masla_bolo_app/service/network_monitor.dart';

import 'dio/dio_client.dart';
import 'network_response.dart';

class NetworkRepository extends NetworkMonitor implements Exception {
  final DioClient dioClient;
  final NetworkMonitor networkMonitor;
  NetworkRepository(this.dioClient, this.networkMonitor);

  Future<NetworkResponse> request({
    required String method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    // checking initial internet connection!
    if (!await networkMonitor.checkConnection()) {
      throw NetworkResponse(
        message: "No internet connection",
        data: null,
        code: 500,
        success: "false",
      );
    }

    final completer = Completer<NetworkResponse>();
    StreamSubscription? networkSubscription;

    networkSubscription = networkMonitor.onConnectivityChanged.listen(
      (hasConnection) {
        if (!hasConnection && !completer.isCompleted) {
          completer.completeError(
            NetworkResponse(
              message: "Internet connection lost",
              data: null,
              code: 500,
              success: "false",
            ),
          );
        }
      },
    );

    try {
      final response = await dioClient.dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      final result = _handleResponse(response);
      completer.complete(result);
    } on DioException catch (e) {
      if (!completer.isCompleted) {
        completer.completeError(DioClient.handleDioError(e));
      }
    } on NetworkResponse catch (e) {
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
    } catch (e) {
      if (!completer.isCompleted) {
        completer.completeError(
          NetworkResponse(
            message: "An unexpected error occurred",
            data: null,
            code: 500,
            success: "false",
          ),
        );
      }
    } finally {
      await networkSubscription.cancel();
    }

    return completer.future;
  }

  Future<NetworkResponse> get({
    required String url,
    Map<String, dynamic>? extraQuery,
  }) =>
      request(
        method: 'GET',
        url: url,
        queryParameters: extraQuery,
      );

  Future<NetworkResponse> post({
    required String url,
    Map<String, dynamic>? data,
  }) =>
      request(
        method: 'POST',
        url: url,
        data: data,
      );

  Future<NetworkResponse> patch({
    required String url,
    Map<String, dynamic>? data,
  }) =>
      request(
        method: 'PATCH',
        url: url,
        data: data,
      );

  Future<NetworkResponse> put({
    required String url,
    Map<String, dynamic>? data,
  }) =>
      request(
        method: 'PUT',
        url: url,
        data: data,
      );

  Future<NetworkResponse> delete({required String url}) => request(
        method: 'DELETE',
        url: url,
      );

  NetworkResponse _handleResponse(Response response) {
    final body = response.data;
    if (response.statusCode == 200 || response.statusCode == 201) {
      return NetworkResponse(
        code: body["code"] ?? response.statusCode,
        message: body["message"] ?? "",
        success: body["success"] ?? "true",
        data: body["data"],
      );
    }

    throw NetworkResponse(
      code: body["code"] ?? response.statusCode,
      message: body["message"] ?? "Unknown error occurred",
      success: body["success"] ?? "false",
      data: body["data"],
    );
  }

  @override
  void dispose() {
    networkMonitor.dispose();
    super.dispose();
  }
}
