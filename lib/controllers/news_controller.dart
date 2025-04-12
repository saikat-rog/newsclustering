import 'package:get/get.dart';

class NewsController extends GetxController {
  var newsResult = {}.obs; // Observable JSON Object
  var loading = false.obs; // Observable boolean

  void setNews(Map<String, dynamic> newsData) {
    newsResult.value = newsData;
  }

  RxMap getNews() {
    return newsResult;
  }

  void deleteNews() {
    newsResult.clear();
  }

  void setLoading(bool value) {
    loading.value = value;
  }
}
