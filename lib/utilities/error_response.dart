class ErrorResponse {
  String? data;
  String? error;
  int? statusCode;

  ErrorResponse({this.data, this.error, this.statusCode});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'];
    error = json['error'];
  }

  @override
  String toString() {
    return 'statusCode: $statusCode, '
        '\ndata: $data, '
        '\nerror: $error';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['data'] = this.data;
    data['error'] = error;
    return data;
  }
}