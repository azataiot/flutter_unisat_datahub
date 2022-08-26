import '../../data/models/collection.dart';

class SelectionState {
  List<Collection>? collections;
  bool? isLoading;
  bool? isConnecting;
  bool? isError;
  String? errorMsg;
  bool? connectivity;

  SelectionState() {
    ///Initialize variables
    collections = [];
    isLoading = true;
    isConnecting = false;
    isError = false;
    errorMsg = "";
    connectivity = false;
  }
}
