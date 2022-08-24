class DataSource {
  List<DataSourceData>? data;

  DataSource({this.data});

  DataSource.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataSourceData>[];
      json['data'].forEach((v) {
        data!.add(DataSourceData.fromJson(v));
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

class DataSourceData {
  String? id;
  int? lastModified;

  DataSourceData({this.id, this.lastModified});

  DataSourceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastModified = json['last_modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['last_modified'] = lastModified;
    return data;
  }
}
