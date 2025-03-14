import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/news_controller.dart';
import '../../controllers/news_history_controller.dart';

class HistoryDetailsScreen extends StatefulWidget {
  @override
  State<HistoryDetailsScreen> createState() => _HistoryDetailsScreenState();
}

class _HistoryDetailsScreenState extends State<HistoryDetailsScreen> {
  final newsController = Get.find<NewsController>();
  final newsHistoryController = Get.find<NewsHistoryController>();

  int index = 0; // Provide a default value

  @override
  void initState() {
    super.initState();
    index = Get.arguments?['index'] ?? 0; // Retrieve index from arguments
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Get.back(),
        ),
        title: Text('Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => newsHistoryController.getNewsHistory().isEmpty
                  ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Search your news.', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
                  : _buildDetails()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.analytics_outlined),
          title: Obx(() => Text(newsHistoryController.newsHistory[index]['category'] ?? 'No Category')),
        ),
        Text('Summary', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Obx(() => Text(newsHistoryController.newsHistory[index]['summary'] ?? 'No Summary')),
        SizedBox(height: 16),

        // Clustering Metrics
        _buildClusteringMetrics('K-Means'),
        _buildClusteringMetrics('AGNES'),
        _buildClusteringMetrics('Spectral Clustering'),
        _buildClusteringMetrics('GMM Clustering'),

        SizedBox(height: 50),
      ],
    );
  }

  Widget _buildClusteringMetrics(String method) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(method, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Obx(() => Text(
            'Silhouette Score: ${newsHistoryController.newsHistory[index]['clustering_metrics']?[method]?['Silhouette Score']?.toString() ?? 'NULL'}')),
        Obx(() => Text(
            'DB Index: ${newsHistoryController.newsHistory[index]['clustering_metrics']?[method]?['DB Index']?.toString() ?? 'NULL'}')),
        Obx(() => Text(
            'CH Index: ${newsHistoryController.newsHistory[index]['clustering_metrics']?[method]?['CH Index']?.toString() ?? 'NULL'}')),
        SizedBox(height: 16),
      ],
    );
  }
}
