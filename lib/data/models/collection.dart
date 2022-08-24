class Collection {
  String? id;
  int? lastModified;

  Collection({this.id, this.lastModified});

  Collection.fromJson(Map<String, dynamic> json) {
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

class CollectionResponse {
  List<Collection>? data;

  CollectionResponse({this.data});

  CollectionResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Collection>[];
      json['data'].forEach((v) {
        data!.add(Collection.fromJson(v));
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
