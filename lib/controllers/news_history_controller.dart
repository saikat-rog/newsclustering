import 'package:get/get.dart';

class NewsHistoryController extends GetxController {
  var newsHistory = <Map<String, dynamic>>[].obs; // List of news JSON objects

  // Add news to history
  void addNewsToHistory(Map<String, dynamic> newsData) {
    newsHistory.add(newsData); // Append new entry to history
  }

  // Get the stored news history
  List<Map<String, dynamic>> getNewsHistory() {
    return newsHistory;
  }

  // Clear the news history
  void clearNewsHistory() {
    newsHistory.clear();
  }

  // @override
  // void onClose() {
  //   clearNewsHistory(); // ✅ Clears history when the controller is disposed
  //   super.onClose();
  // }
}
