import 'package:masla_bolo_app/network/network_response.dart';
import 'package:masla_bolo_app/service/api_service.dart';

class NetworkRepository {
  final ApiService apiService;
  NetworkRepository(this.apiService);

  Future<NetworkResponse> get({
    required String url,
    Map<String, dynamic>? extraQuery,
  }) async {
    final response = await apiService.dio.get(url, queryParameters: {
      ...?extraQuery,
    });
    final result = apiService.checkError(response);
    return result;
  }

  Future<NetworkResponse> put({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    final response = await apiService.dio.put(url, data: data);
    final result = apiService.checkError(response);
    return result;
  }

  Future<NetworkResponse> post({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    final response = await apiService.dio.post(url, data: data);
    final result = apiService.checkError(response);
    return result;
  }

  Future<NetworkResponse> delete({
    required String url,
  }) async {
    final response = await apiService.dio.delete(url);
    final result = apiService.checkError(response);
    return result;
  }
}
