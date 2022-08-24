import 'package:unisat_data/data/providers/base_provider.dart';

import 'package:get/get.dart';

import '../../helpers/logging.dart';

abstract class IEntityProvider {
  // calls to the api endpoint, get the response and return the response

  Future getObjects(String path, {int? limit = 100});
}

class EntityProvider extends BaseProvider implements IEntityProvider {
  Future<void> init() async {
    // correction
    logger.d('$runtimeType delays 1 sec');
    await 1.delay();
    logger.d('$runtimeType ready!');
  }

  // provider is in the API level and do not care about what returned from the
  // api, it just calls the corresponding api endpoint and returns always a response object.

  @override
  Future getObjects(String path, {int? limit = 200}) async {
    logger.i(
        "[Azt::Provider] getObjects called (EntityProvider) with path $path");
    var response = await get("$path?_limit=$limit");
    return response;
  }
}
