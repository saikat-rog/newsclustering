import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:newsclustering/controllers/news_controller.dart';

class BuildMetricsSectionWidget extends StatefulWidget {
  final String algorithm;

  const BuildMetricsSectionWidget({super.key, required this.algorithm});

  @override
  State<BuildMetricsSectionWidget> createState() => _BuildMetricsSectionWidgetState();
}

class _BuildMetricsSectionWidgetState extends State<BuildMetricsSectionWidget> {
  final newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.algorithm, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Obx(() => Text(
          'Silhouette Score: ${newsController.newsResult['clustering_metrics']?[widget.algorithm]?['Silhouette Score']?.toString() ?? 'NULL'}',
        )),
        Obx(() => Text(
          'DB Index: ${newsController.newsResult['clustering_metrics']?[widget.algorithm]?['DB Index']?.toString() ?? 'NULL'}',
        )),
        Obx(() => Text(
          'CH Index: ${newsController.newsResult['clustering_metrics']?[widget.algorithm]?['CH Index']?.toString() ?? 'NULL'}',
        )),
        const SizedBox(height: 16),
      ],
    );
  }
}
