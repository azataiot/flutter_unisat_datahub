import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unisat_data/data/models/collection.dart';
import 'package:unisat_data/data/models/record.dart';
import 'package:unisat_data/data/repositories/repositories.dart';
import 'package:unisat_data/global/configs.dart' as app_config;
import '../../helpers/logging.dart';

class ApiService extends GetxService {
  ApiService({required this.repository});

  late Timer timer;
  final IEntityRepository repository;
  final storage = GetStorage();

  Future<ApiService> init() async {
    logger.i('$runtimeType delays 1 sec');
    logger.i('Initializing ApiService');
    return this;
  }

  @override
  Future<void> onInit() async {
    logger.i('ApiService ready!');
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      logger.i('ApiService update data! $t');
      updateData();
    });
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    logger.i('ApiService close!');
    timer.cancel();
    super.onClose();
  }

  Future<void> updateData() async {
    logger.i('update called!');
    dynamic records = await repository.getRecords("");
    if (records != null) {
      List<Record> recordsList = List.from(records);
      await storage.write(app_config.Storage.records, records);
    } else {
      logger.w("[Azt::ApiService] records is null!");
    }
  }

  Future getCollections() async {
    logger.i('get collections called!');
    dynamic collections = await repository.getCollections();
    if (collections != null) {
      List<Collection> collectionsList = List.from(collections);
      return collectionsList;
    }
    {
      logger.w("[Azt::ApiService] collections is null");
    }
  }
}
