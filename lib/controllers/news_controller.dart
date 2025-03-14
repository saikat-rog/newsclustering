import 'package:get/get.dart';

class NewsController extends GetxController {
  var newsResult = {}.obs; // Observable JSON Object

  void setNews(Map<String, dynamic> newsData) {
    newsResult.value = newsData;
  }

  RxMap getNews() {
    return newsResult;
  }

  void deleteNews() {
    newsResult.clear();
  }
}
