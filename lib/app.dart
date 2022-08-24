import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:unisat_data/routes/app_routes.dart';
import 'package:unisat_data/themes/app_themes.dart';

import 'global/configs.dart' as global_config;
import 'helpers/logging.dart';
import 'i18n/i18n.dart';

final log = logger;

Widget createApp() {
  log.d("[Azt] Widget createApp()");
  final storage = GetStorage();
  String savedTheme = storage.read(global_config.Storage.theme) ?? "light";
  log.d("[Azt] String savedTheme = '$savedTheme'");
  String themeMode = storage.read(global_config.Storage.themMode) ?? "system";
  log.d("[Azt] String theme = '$themeMode'");
  Get.changeTheme(savedTheme == "light" ? lightTheme : darkTheme);
  return GetMaterialApp(
    defaultTransition: Transition.native,
    enableLog: true,
    logWriterCallback: logWriter,
    title: "UniSat DataHub".tr,
    translations: I18N(),
    locale: I18N.locale,
    fallbackLocale: I18N.fallbackLocale,
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: getThemeMode(themeMode),
    debugShowCheckedModeBanner: false,
    initialRoute: (storage.read(global_config.Storage.firstRun) ?? true)
        ? AppRoutes.selection
        : AppRoutes.home,
    getPages: AppPages.pages,
  );
}

ThemeMode getThemeMode(String themeMode) {
  if (themeMode == "light") {
    return ThemeMode.light;
  } else if (themeMode == "dark") {
    return ThemeMode.dark;
  }
  return ThemeMode.system;
}

// log writer for GetX
void logWriter(String text, {bool isError = false}) {
  log.d("[GetX] $text");
}
