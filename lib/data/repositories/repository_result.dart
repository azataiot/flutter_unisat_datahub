enum ResultStatus {
  success,
  failed,
}

class Result<T> {
  bool? ok;
  String? statusText;
  T? result;

  Result({
    this.ok,
    this.statusText,
    this.result,
  });

  Result.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    statusText = json['statusText'];
    if (json['result'] != null) {
      result = json['result'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ok'] = ok;
    data['statusText'] = statusText;
    data['result'] = result;
    return data;
  }
}
