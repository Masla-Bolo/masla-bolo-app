import 'dio/dio_client.dart';
import 'network_response.dart';

class NetworkRepository implements Exception {
  final DioClient dioClient;
  NetworkRepository(this.dioClient);

  Future<NetworkResponse> get({
    required String url,
    Map<String, dynamic>? extraQuery,
  }) async {
    final response = await dioClient.dio.get(url, queryParameters: {
      ...?extraQuery,
    });
    final result = dioClient.checkError(response);
    return result;
  }

  Future<NetworkResponse> put({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    final response = await dioClient.dio.put(url, data: data);
    final result = dioClient.checkError(response);
    return result;
  }

  Future<NetworkResponse> post({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    final response = await dioClient.dio.post(url, data: data);
    final result = dioClient.checkError(response);
    return result;
  }

  Future<NetworkResponse> delete({
    required String url,
  }) async {
    final response = await dioClient.dio.delete(url);
    final result = dioClient.checkError(response);
    return result;
  }
}
