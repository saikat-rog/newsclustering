import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:newsclustering/controllers/news_controller.dart';
import 'package:newsclustering/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _isInfoButtonClicked = false;
  NewsApi newsApi = NewsApi();
  TextEditingController urlController = TextEditingController();
  final newsController = Get.put(NewsController());
  bool isLoading = false;

  void alterInfoButtonClicked() {
    setState(() {
      _isInfoButtonClicked = !_isInfoButtonClicked; // Updating the state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
            ), // NewsCluster logo icon
            const SizedBox(width: 8),
            const Text('NewsClustering'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              // Add info button functionality here
              alterInfoButtonClicked();
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info
            _isInfoButtonClicked
                ? Container(
                    child: Text(
                      'NewsCluster helps you analyze news articles by generating summaries, identifying categories, and evaluating clustering performance. Simply enter a news URL to get started.',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : Container(),
            SizedBox(height: 16),

            // Enter news URL
            Text('Enter News URL',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'https://news.example.com/article',
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  // Add classify news functionality here
                  setState(() {
                    isLoading = true;
                  });
                  await newsApi.fetchNews(urlController.text);
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Text('Classify News'),
              ),
            ),
            SizedBox(height: 16),

            // Result heading and History
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Analysis Results',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                    width: 8), // Adds spacing between text and icon
                GestureDetector(
                    onTap: () {
                      Get.toNamed('/history');
                    },
                    child: Icon(Icons.history,
                        color: Theme.of(context)
                            .primaryColor)), // History icon
              ],
            ),

            // Result
            Obx(() => isLoading ? Container(height: 200, child: Center(child: CircularProgressIndicator( color: Theme.of(context).primaryColor,))) : newsController.getNews().isEmpty
                ? Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Search your news.',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      ListTile(
                          leading: Icon(Icons.analytics_outlined),
                          title: Obx(() => Text(
                              newsController.newsResult['category'] ??
                                  'No Category'))),
                      Text('Summary',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Obx(() => Text(newsController.newsResult['summary'] ??
                          'No Category')),
                      SizedBox(height: 16),
                      Text('Clustering Metrics',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),

                      // K-Means
                      Text('K-Means',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                              'Silhouette Score: ${newsController.newsResult['clustering_metrics']?['K-Means']?['Silhouette Score']?.toString() ?? 'NULL'}')),
                          Obx(() => Text(
                              'DB Index: ${newsController.newsResult['clustering_metrics']?['K-Means']?['DB Index']?.toString() ?? 'NULL'}')),
                          Obx(() => Text(
                              'CH Index: ${newsController.newsResult['clustering_metrics']?['K-Means']?['CH Index']?.toString() ?? 'NULL'}')),
                        ],
                      ),
                      SizedBox(height: 16),

                      // AGNES
                      Text('K-Means',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                              'Silhouette Score: ${newsController.newsResult['clustering_metrics']?['AGNES']?['Silhouette Score']?.toString() ?? 'NULL'}')),
                          Obx(() => Text(
                              'DB Index: ${newsController.newsResult['clustering_metrics']?['AGNES']?['DB Index']?.toString() ?? 'NULL'}')),
                          Obx(() => Text(
                              'CH Index: ${newsController.newsResult['clustering_metrics']?['AGNES']?['CH Index']?.toString() ?? 'NULL'}')),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Spectral Clustering
                      Text('Spectral Clustering',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                              'Silhouette Score: ${newsController.newsResult['clustering_metrics']?['Spectral Clustering']?['Silhouette Score']?.toString() ?? 'NULL'}')),
                          Obx(() => Text(
                              'DB Index: ${newsController.newsResult['clustering_metrics']?['Spectral Clustering']?['DB Index']?.toString() ?? 'NULL'}')),
                          Obx(() => Text(
                              'CH Index: ${newsController.newsResult['clustering_metrics']?['Spectral Clustering']?['CH Index']?.toString() ?? 'NULL'}')),
                        ],
                      ),
                      SizedBox(height: 16),

                      // GMM Clustering
                      Text('GMM Clustering',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                              'Silhouette Score: ${newsController.newsResult['clustering_metrics']?['GMM Clustering']?['Silhouette Score']?.toString() ?? 'NULL'}')),
                          Obx(() => Text(
                              'DB Index: ${newsController.newsResult['clustering_metrics']?['GMM Clustering']?['DB Index']?.toString() ?? 'NULL'}')),
                          Obx(() => Text(
                              'CH Index: ${newsController.newsResult['clustering_metrics']?['GMM Clustering']?['CH Index']?.toString() ?? 'NULL'}')),
                        ],
                      ),
                      SizedBox(height: 50),

                      // View Graph Button
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.bar_chart),
                              SizedBox(width: 8),
                              Text('View Performance Graph'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
