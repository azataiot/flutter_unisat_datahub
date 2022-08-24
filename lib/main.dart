import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unisat_data/data/providers/providers.dart';

import 'app.dart';
import 'data/repositories/entity_repository.dart';
import 'helpers/logging.dart';

Future<void> initServices() async {
  logger.i("Starting Services...");

  // this has to run first
  // load .env
  try {
    await dotenv.load(
      fileName: ".env",
    );
    log.d("[Azt] loaded environment variables from .env");
  } catch (e) {
    log.e("[Azt] failed to load environment variables");
  }
  // ok
  await GetStorage.init();
  logger.i("Get Storage initialized ...");
  Get.lazyPut<IEntityProvider>(() => EntityProvider());
  Get.lazyPut<IEntityRepository>(() => EntityRepository(provider: Get.find()));
  // await Get.putAsync(() => ApiService(repository: Get.find()).init());
}

Future<void> main() async {
  log.d("[Azt] running main");

  /// Create database tables if we need them.
  // _createDBTables();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(
    createApp(),
  );
}
