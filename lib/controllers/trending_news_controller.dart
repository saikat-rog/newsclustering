import 'package:get/get.dart';

class TrendingNewsController extends GetxController {
  var trendingNewsResult = {}.obs;
  final loading = false.obs;
  var country = 'Select country'.obs;

  void setTrendingNews(Map<String, dynamic> newsData) {
    trendingNewsResult.value = newsData;
  }

  RxMap getTrendingNews() {
    return trendingNewsResult;
  }

  void clearTrendingNews() {
    trendingNewsResult.clear();
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void setCountry(String value) {
    country.value = value;
  }
}
