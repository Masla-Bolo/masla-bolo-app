class NetworkResponse {
  String success;
  String message;
  int code;
  dynamic data;
  NetworkResponse({
    this.code = 200,
    this.data,
    this.message = "",
    this.success = "",
  });
}
