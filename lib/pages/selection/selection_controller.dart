import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/models/collection.dart';
import '../../data/repositories/entity_repository.dart';

import 'package:unisat_data/global/configs.dart' as app_config;
import '../../helpers/logging.dart';
import '../../routes/app_routes.dart';
import 'selection_state.dart';

class SelectionController extends GetxController {
  final SelectionState state = SelectionState();
  IEntityRepository repository = Get.find();
  final storage = GetStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
    // check internet connectivity.
    bool connectivity = await checkConnectivity();
    state.connectivity = connectivity;
    update();
    // state.errorMsg = "[Azt::SelectionController] onInit called";
    logger.d("[Azt::SelectionController] onInit called");
    logger.d("[Azt::SelectionController] getting collections");
    var collections = await getCollections();
    // state.errorMsg = "collections? $collections";
    state.isLoading = false;
    state.isConnecting = true;
    update();
    logger.d("[Azt::SelectionController] onInit collections $collections");
    if (collections != null) {
      state.collections = collections;
      state.isConnecting = false;
      logger.d(
          "[Azt::SelectionController] onInit collections length on state ${state.collections!.length}");
      update();
    } else {
      logger.w("Getting records failed!");
      state.isConnecting = false;
      state.isError = true;
      update();
    }
  }

  handleSelectSource(String source) async {
    logger.d("[Azt::HomeController] onInit handleSelectSource $source");
    await storage.write(app_config.Storage.currentSource, source);
    await storage.write(app_config.Storage.firstRun, false);
    update();
    Get.offAllNamed(AppRoutes.home);
  }

  getCollections() async {
    logger.i('get collections called!');
    dynamic collections = await repository.getCollections();
    if (collections != null) {
      state.errorMsg = "Collection is not null";
      update();
      List<Collection> collectionsList = List.from(collections);
      return collectionsList;
    } else {
      logger.w("[Azt::ApiService] collections is null");
      return null;
    }
  }

  reTry() async {
    bool connectivity = await checkConnectivity();
    if (connectivity) {
      state.isError = false;
      update();
      var collections = await getCollections();
      state.isLoading = false;
      state.isConnecting = true;
      update();
      if (collections != null) {
        state.collections = collections;
        state.isConnecting = false;
        logger.d(
            "[Azt::SelectionController] onInit collections length on state ${state.collections!.length}");
        update();
      } else {
        logger.w("Getting records failed!");
        state.isConnecting = false;
        state.isError = true;
        update();
      }
    }
  }

  Future<bool> checkConnectivity() async {
    bool status = false;
    try {
      final result = await InternetAddress.lookup("data-api.unisat.kz");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = true;
      }
    } on SocketException catch (_) {
      logger.w("InternetAddress.lookup failed, App is offline");
      status = false;
    }

    return status;
  }
}
