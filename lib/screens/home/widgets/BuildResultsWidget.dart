import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        const Text('Clustering Metrics', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        BuildMetricsSectionWidget(algorithm: 'K-Means'),
        BuildMetricsSectionWidget(algorithm: 'AGNES'),
        BuildMetricsSectionWidget(algorithm: 'Spectral Clustering'),
        BuildMetricsSectionWidget(algorithm: 'GMM Clustering'),
        const SizedBox(height: 50),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.bar_chart),
            label: const Text('View Performance Graph'),
          ),
        ),
      ],
    );
  }
}