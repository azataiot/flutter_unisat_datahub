import '../../data/enums/selected.dart';
import '../../data/models/collection.dart';
import '../../data/models/record.dart';

class HomeState {
  bool? isLoading;
  bool? isConnecting;
  bool? isError;
  bool? isSuccess;
  String? errorMsg;
  List<Record>? records;
  List<Collection>? collections;
  String? lastUpdated;
  String? currentSource;
  EnumCurrentSelected? currentSelected;

  HomeState() {
    ///Initialize variables
    ///
    isLoading = true;
    isConnecting = false;
    isError = false;
    isSuccess = false;
    errorMsg = "";
    records = [];
    collections = [];
    lastUpdated = DateTime.now().toString();
    currentSelected = EnumCurrentSelected.temperature;
  }
}
