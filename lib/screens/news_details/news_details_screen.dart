import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newsclustering/controllers/news_controller.dart';
import 'package:newsclustering/screens/home/widgets/BuildGraphSectionWidget.dart';
import 'package:newsclustering/screens/home/widgets/BuildResultsWidget.dart';
import 'package:newsclustering/services/api_services.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({super.key});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool _isInfoButtonClicked = false;
  final NewsApi newsApi = NewsApi();
  final newsController = Get.put(NewsController());
  bool isLoading = false;

  void toggleInfoButton() =>
      setState(() => _isInfoButtonClicked = !_isInfoButtonClicked);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset('assets/logo.svg'),
            const SizedBox(width: 8),
            const Text('NewsClustering'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: toggleInfoButton,
          ),
        ],
      ),

      // News Details
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isInfoButtonClicked)
              const Text(
                'NewsCluster helps you analyze news articles by generating summaries, identifying categories, and evaluating clustering performance. Simply enter a news URL to get started.',
                style: TextStyle(fontSize: 16),
              ),

            const SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Analysis Results',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => Get.toNamed('/history'),
                  child: Icon(Icons.history,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),

            Obx(() => newsController.loading.value
                ? Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  )
                : const BuildResultsWidget()),
            // Add a graph that would show the data where the x axis will be number of cluster and y axis will be the score.
          ],
        ),
      ),
    );
  }
}
