import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import '../../helpers/logging.dart';

class BaseProvider extends GetConnect {
  final serverApiBaseUrl = dotenv.get('SERVER_API_BASE_URL',
      fallback: const String.fromEnvironment("SERVER_API_BASE_URL"));
  final token =
      dotenv.get('TOKEN', fallback: const String.fromEnvironment("TOKEN"));

  @override
  void onInit() {
    httpClient.baseUrl = serverApiBaseUrl;
    logger.i("[BaseProvider] baseUrl: $serverApiBaseUrl");

    /// request interception
    httpClient.addRequestModifier<void>((request) {
      request.headers["Authorization"] = "Basic $token";
      return request;
    });

    /// response interception
    httpClient.addResponseModifier((request, response) {
      return response;
    });
  }
}
