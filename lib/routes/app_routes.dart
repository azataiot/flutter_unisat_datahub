import 'package:get/get.dart';

import '../pages/home/home_binding.dart';
import '../pages/home/home_view.dart';
import '../pages/selection/selection_binding.dart';
import '../pages/selection/selection_view.dart';

abstract class AppPages {
  static final pages = [
    /// HomePage
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.selection,
      page: () => SelectionPage(),
      binding: SelectionBinding(),
    ),
  ];
}

abstract class AppRoutes {
  // All application routes will be defined inside this class.

  /// language selection
  static const language = "/language";

  /// Home Page
  static const home = "/home";

  /// Selection
  static const selection = "/selection";
}
