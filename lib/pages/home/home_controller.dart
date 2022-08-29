import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:unisat_data/data/enums/selected.dart';
import 'package:unisat_data/data/repositories/repositories.dart';
import '../../data/models/collection.dart';
import '../../helpers/logging.dart';
import '../../routes/app_routes.dart';
import 'home_state.dart';
import 'package:unisat_data/global/configs.dart' as app_config;

enum VarType {
  temperature,
  humidity,
  pressure,
  pm10,
  pm25,
}

class HomeController extends GetxController {
  final HomeState state = HomeState();
  final storage = GetStorage();
  IEntityRepository repository = Get.find();

  late Timer timer;

  @override
  void onInit() async {
    logger.d("[Azt::HomeController] onInit called");
    super.onInit();
    state.isLoading = true;

    // first time data update
    await updateRecords();
    await getCollections();
    //
    Future.delayed(const Duration(seconds: 1), () {
      state.isLoading = false;
      state.isConnecting = true;
      update();
      updateRecords();
    });

    // setup the timer
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      logger.i('ApiService update data! $t');
      updateRecords();
    });
  }

  getCurrentSources() async {
    String currentSource = storage.read(app_config.Storage.currentSource) ?? "";
    if (currentSource.isEmpty) {
      logger.w("[Azt::HomeController]  no data providers found from the store");
      return null;
    } else {
      return currentSource;
    }
  }

  updateRecords() async {
    logger.i('Home Controller update records called!');
    String currentSource = await getCurrentSources();
    dynamic records = await repository.getRecords(currentSource);
    if (records != null) {
      // we got records and that is not null
      state.records = records;
      state.currentSource = currentSource;
      state.lastUpdated = DateFormat.yMd().add_jms().format(
          DateTime.fromMillisecondsSinceEpoch(
              state.records![0].timestamp! * 1000));
      state.isConnecting = false;
      update();
    } else {
      logger.w("Getting records failed!");
      state.isConnecting = false;
      state.isError = true;
      update();
    }
  }

  @override
  Future<void> onClose() async {
    logger.i('HomeController close!');
    timer.cancel();
    super.onClose();
  }

  double getVarMin({required VarType varType}) {
    List<double> allVars = [];
    state.records?.forEach((record) {
      switch (varType) {
        case VarType.temperature:
          allVars.add(record.temperature ?? 0.0);
          break;
        case VarType.humidity:
          allVars.add(record.humidity ?? 0.0);
          break;
        case VarType.pressure:
          allVars.add(record.pressure ?? 0.0);
          break;
        case VarType.pm10:
          allVars.add(record.pm10 ?? 0.0);
          break;
        case VarType.pm25:
          allVars.add(record.pm25 ?? 0.0);
          break;
      }
    });
    return allVars.reduce(min);
  }

  double getVarMax({required VarType varType}) {
    List<double> allVars = [];
    state.records?.forEach((record) {
      switch (varType) {
        case VarType.temperature:
          allVars.add(record.temperature ?? 100.0);
          break;
        case VarType.humidity:
          allVars.add(record.humidity ?? 100.0);
          break;
        case VarType.pressure:
          allVars.add(record.pressure ?? 2000.0);
          break;
        case VarType.pm10:
          allVars.add(record.pm10 ?? 100.0);
          break;
        case VarType.pm25:
          allVars.add(record.pm25 ?? 100.0);
          break;
      }
    });
    return allVars.reduce(max);
  }

  switchChart(EnumCurrentSelected type) {
    switch (type) {
      case EnumCurrentSelected.temperature:
        state.currentSelected = EnumCurrentSelected.temperature;
        update();
        break;
      case EnumCurrentSelected.humidity:
        state.currentSelected = EnumCurrentSelected.humidity;
        update();
        break;
      case EnumCurrentSelected.pressure:
        state.currentSelected = EnumCurrentSelected.pressure;
        update();
        break;
      case EnumCurrentSelected.pm25:
        state.currentSelected = EnumCurrentSelected.pm25;
        update();
        break;
      case EnumCurrentSelected.pm10:
        state.currentSelected = EnumCurrentSelected.pm10;
        update();
        break;
    }
  }

  getCollections() async {
    logger.i('get collections called!');
    dynamic collections = await repository.getCollections();
    if (collections != null) {
      List<Collection> collectionsList = List.from(collections);
      collectionsList.removeWhere((element) => element.id == "null");
      state.collections = collectionsList;
      update();
    } else {
      logger.w("[Azt::ApiService] collections is null");
    }
  }

  handleSelectSource(String source) async {
    logger.d("[Azt::HomeController] onInit handleSelectSource $source");
    await storage.write(app_config.Storage.currentSource, source);
    update();
  }
}
