class Record {
  double? pm10;
  double? pm25;
  double? humidity;
  double? pressure;
  int? timestamp;
  double? temperature;
  String? id;
  int? lastModified;

  Record(
      {this.pm10,
      this.pm25,
      this.humidity,
      this.pressure,
      this.timestamp,
      this.temperature,
      this.id,
      this.lastModified});

  Record.fromJson(Map<String, dynamic> json) {
    pm10 = json['pm10'];
    pm25 = json['pm25'];
    humidity = json['humidity'];
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
    data['humidity'] = humidity;
    data['pressure'] = pressure;
    data['timestamp'] = timestamp;
    data['temperature'] = temperature;
    data['id'] = id;
    data['last_modified'] = lastModified;
    return data;
  }
}

class RecordResponse {
  List<Record>? data;

  RecordResponse({this.data});

  RecordResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Record>[];
      json['data'].forEach((v) {
        data!.add(Record.fromJson(v));
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

class RecordData {
  double? pm10;
  double? pm25;
  double? humidity;
  double? pressure;
  DateTime? datetime;
  double? temperature;
  String? id;
  int? lastModified;

  RecordData(
      {this.pm10,
      this.pm25,
      this.humidity,
      this.pressure,
      this.datetime,
      this.temperature,
      this.id,
      this.lastModified});

  RecordData.fromRecord(Record record) {
    pm10 = record.pm10;
    pm25 = record.pm25;
    humidity = record.humidity;
    pressure = record.pressure;
    temperature = record.temperature;
    id = record.id;
    lastModified = record.lastModified;
    if (record.timestamp != null) {
      datetime = DateTime.fromMillisecondsSinceEpoch(record.timestamp! * 1000);
    }
  }
}
