import 'package:get/get.dart';
import '../../data/providers/entity_provider.dart';

import '../../data/repositories/entity_repository.dart';
import 'selection_controller.dart';

class SelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IEntityProvider>(() => EntityProvider());
    Get.lazyPut<IEntityRepository>(
        () => EntityRepository(provider: Get.find()));
    Get.lazyPut(() => SelectionController());
  }
}
