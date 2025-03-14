import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class NewsHistoryController extends GetxController {
  var newsHistory = <Map<String, dynamic>>[].obs;
  final storage = GetStorage();
  final String storageKey = "newsHistory";

  @override
  void onInit() {
    super.onInit();
    loadNewsHistory();
  }

  // Load news history from storage
  void loadNewsHistory() {
    String? storedData = storage.read(storageKey);
    if (storedData != null) {
      List<dynamic> jsonData = jsonDecode(storedData);
      newsHistory.value = jsonData.cast<Map<String, dynamic>>();
    }
  }

  // Add news to history and store in shared preferences
  void addNewsToHistory(Map<String, dynamic> newsData) {
    newsHistory.add(newsData);
    _saveToStorage();
  }

  // Get stored news history
  List<Map<String, dynamic>> getNewsHistory() {
    return newsHistory;
  }

  // Clear news history
  void clearNewsHistory() {
    newsHistory.clear();
    storage.remove(storageKey);
  }

  // Save to shared preferences
  void _saveToStorage() {
    storage.write(storageKey, jsonEncode(newsHistory));
  }
}
