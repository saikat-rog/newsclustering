import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsclustering/screens/home/widgets/BuildGraphSectionWidget.dart';

import '../../../controllers/news_controller.dart';
import 'BuildMetricsSectionWidget.dart';

class BuildResultsWidget extends StatefulWidget{
  const BuildResultsWidget({super.key});

  @override
  State<BuildResultsWidget> createState() => _BuildResultsWidgetState();
}

class _BuildResultsWidgetState extends State<BuildResultsWidget> {

  final newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.analytics_outlined),
          title: Obx(() => Text(newsController.newsResult['category'] ?? 'No Category')),
        ),
        const Text('Summary', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Obx(() => Text(newsController.newsResult['summary'] ?? 'No Summary')),
        const SizedBox(height: 16),
        Obx(() {
          String sentiment = newsController.newsResult['sentiment'] ?? 'No Sentiment';
          Color color;

          switch (sentiment.toUpperCase()) {
            case 'SENTIMENT: NEGATIVE':
              color = Colors.red;
              break;
            case 'SENTIMENT: POSITIVE':
              color = Colors.green;
              break;
            case 'SENTIMENT: NEUTRAL':
              color = Colors.yellow;
              break;
            default:
              color = Colors.grey;
          }

          return Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(sentiment),
            ],
          );
        }),

        const SizedBox(height: 16),
        const Text('Clustering Metrics', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        BuildMetricsSectionWidget(algorithm: 'K-Means'),
        BuildMetricsSectionWidget(algorithm: 'AGNES'),
        BuildMetricsSectionWidget(algorithm: 'Spectral Clustering'),
        BuildMetricsSectionWidget(algorithm: 'GMM Clustering'),
        const SizedBox(height: 50),
        Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Theme.of(context).primaryColor,),

            child: Center(
              child: Text("Performance Graph", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).secondaryHeaderColor),)
            ),
          ),
        ),
        SizedBox(height: 20,),
        BuildGraphSectionWidget(),
        SizedBox(height: 20,),
        buildLegend(),
        SizedBox(height: 50,),
      ],
    );
  }

  /// Legend Widget
  Widget buildLegend() {
    List<Color> colors = [Colors.blue, Colors.red, Colors.yellow];
    List<String> metrics = ["Silhouette Score", "DB Index", "CH Index"];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(metrics.length, (index) {
            return Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colors[index],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  metrics[index],
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 10),
              ],
            );
          }),
        ),
        SizedBox(height: 10,),
        Text("No. of clusters is: 24")
      ],
    );
  }
}