import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../global/configs.dart' as global_config;
import '../helpers/logging.dart';
import 'locales/en_us.dart';
import 'locales/kk_kz.dart';
import 'locales/ru_ru.dart';

/*
https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPInternational/LanguageandLocaleIDs/LanguageandLocaleIDs.html
https://www.ibabbleon.com/iOS-Language-Codes-ISO-639.html
*/

final storage = GetStorage();

class I18N extends Translations {
  static const fallbackLocale = Locale('en', 'US');

  static Locale? get locale => getISO639locale();

  static Locale getISO639locale({String? localString}) {
    String storageLocal;
    if (localString != null) {
      storageLocal = localString;
    } else {
      storageLocal = storage.read(global_config.Storage.language) ?? "EN";
    }

    if (storageLocal == "EN") {
      return const Locale("en", "US");
    } else if (storageLocal == "KK") {
      return const Locale("kk", "KZ");
    } else if (storageLocal == "RU") {
      return const Locale("ru", "RU");
    } else {
      return const Locale("en", "US");
    }
  }

  static void setLocale() {
    Locale localeNew = getISO639locale();
    Get.updateLocale(localeNew);
    logger.i("[Azt] Language changed to $locale");
  }

  static void forceSetLocale(String localeString) {
    Locale localeNew = getISO639locale(localString: localeString);
    Get.updateLocale(localeNew);
    logger.i("[Azt] Language force changed to $locale");
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'kk_KZ': kkKZ,
        'ru_RU': ruRU,
      };
}
