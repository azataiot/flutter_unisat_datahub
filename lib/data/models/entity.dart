class Entity {
  List<Data>? data;

  Entity({this.data});

  Entity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  double? pm10;
  double? pm25;
  double? humidity;
  double? pressure;
  int? timestamp;
  double? temperature;
  String? id;
  int? lastModified;

  Data(
      {this.pm10,
      this.pm25,
      this.humidity,
      this.pressure,
      this.timestamp,
      this.temperature,
      this.id,
      this.lastModified});

  Data.fromJson(Map<String, dynamic> json) {
    pm10 = json['pm10'];
    pm25 = json['pm25'];
    humidity = json['humidity.svg'];
    pressure = json['pressure'];
    timestamp = json['timestamp'];
    temperature = json['temperature'];
    id = json['id'];
    lastModified = json['last_modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pm10'] = pm10;
    data['pm25'] = pm25;
    data['humidity.svg'] = humidity;
    data['pressure'] = pressure;
    data['timestamp'] = timestamp;
    data['temperature'] = temperature;
    data['id'] = id;
    data['last_modified'] = lastModified;
    return data;
  }
}
