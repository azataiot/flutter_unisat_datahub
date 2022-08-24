import 'package:unisat_data/data/models/models.dart';
import 'package:unisat_data/data/models/record.dart';
import 'package:unisat_data/data/providers/providers.dart';
import 'package:get/get.dart';
import '../../helpers/logging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unisat_data/global/configs.dart' as app_config;

import '../models/collection.dart';

abstract class IEntityRepository {
  // repository can return null if anything wrong from the server or if we have blank fields

  Future getRecords(String currentSource);

  Future getCollections();
}

class EntityRepository implements IEntityRepository {
  EntityRepository({required this.provider});

  final storage = GetStorage();
  final IEntityProvider provider;

  @override
  Future getCollections() async {
    logger.d("[Azt::EntityRepository] getCollections called");
    Response response =
        await provider.getObjects("buckets/default/collections");
    if (response.hasError) {
      logger
          .w("[Azt Repository] getCollections() error: ${response.statusText}");
      return null;
    } else {
      CollectionResponse collectionResponse =
          CollectionResponse.fromJson(await response.body);
      var collections = collectionResponse.data!;
      return collections;
    }
  }

  @override
  Future getRecords(String currentSource) async {
    String path = "buckets/default/collections/$currentSource/records";
    Response response = await provider.getObjects(path);
    if (response.hasError) {
      logger.w("getRecords() error: ${response.statusText}");
      return null;
    } else {
      var responseBody = await response.body;
      RecordResponse recordResponse = RecordResponse.fromJson(responseBody);
      var records = recordResponse.data!;
      return records;
    }
  }
}
