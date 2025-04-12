import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:newsclustering/controllers/news_controller.dart';

import '../controllers/news_history_controller.dart';
import '../controllers/trending_news_controller.dart';

class NewsApi {
  Future<void> fetchNews(String url) async {
    final newsController = Get.put(NewsController());
    final newsHistoryController = Get.put(NewsHistoryController());
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

  Future <Map<String, dynamic>> sendReview(Map<String, dynamic> feedbackData) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        '${dotenv.env["API_URI"]}/feedback/feedback_training',
        data: feedbackData,
      );
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return {"error": e.toString()};
    }
  }

  Future <void> fetchTrendingNews(String countryData) async {
    final trendingNewsController = Get.put(TrendingNewsController());
    Dio dio = Dio();

    try {
      Response response = await dio.post(
        '${dotenv.env["API_URI"]}/news/getnewsbycountry',
        data: {
          "country": countryData
        },
      );
      trendingNewsController.setTrendingNews(response.data);
      if (kDebugMode) {
        print(response.data);
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
