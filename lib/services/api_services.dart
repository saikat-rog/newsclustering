import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:newsclustering/controllers/news_controller.dart';

import '../controllers/news_history_controller.dart';

class NewsApi {
  //Returns a token for client's id from database based on phone number
  Future<void> fetchNews(String url) async {
    final newsController = Get.find<NewsController>();
    final newsHistoryController = Get.find<NewsHistoryController>();
    Dio dio = Dio();
    var newsUrl = {'url': url};

    try {
      Response response = await dio
          .post('${dotenv.env["API_URI"]}/news/summary', data: newsUrl);

      newsController.setNews(response.data);
      newsHistoryController.addNewsToHistory(response.data);

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
