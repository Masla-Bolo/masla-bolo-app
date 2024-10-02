class NetworkResponse {
  String success;
  String message;
  String code;
  dynamic data;
  NetworkResponse({
    this.code = "",
    this.data,
    this.message = "",
    this.success = "",
  });
}
