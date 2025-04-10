import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:newsclustering/screens/home/widgets/BuildGraphSectionWidget.dart';
import 'package:newsclustering/services/api_services.dart';

import '../../../controllers/news_controller.dart';
import 'BuildMetricsSectionWidget.dart';

class BuildResultsWidget extends StatefulWidget{
  const BuildResultsWidget({super.key});

  @override
  State<BuildResultsWidget> createState() => _BuildResultsWidgetState();
}

class _BuildResultsWidgetState extends State<BuildResultsWidget> {

  final newsController = Get.find<NewsController>();
  final newsApi = NewsApi();

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
        ElevatedButton(
          onPressed: () async {
            bool? allLiked = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Did you like all the clustering results?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text("Yes, All"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text("No"),
                  ),
                ],
              ),
            );

            if (allLiked == true) {
              final res = await newsApi.sendReview({
                "all": true,
                "preferred": ""
              });
              Fluttertoast.showToast(
                msg: res["message"] ?? "Feedback submitted!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            } else if (allLiked == false) {
              String? preferred = await showDialog<String>(
                context: context,
                builder: (context) => SimpleDialog(
                  title: Text("Which one did you prefer?"),
                  children: [
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context, 'K-Means'),
                      child: Text('K-Means'),
                    ),
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context, 'AGNES'),
                      child: Text('AGNES'),
                    ),
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context, 'Spectral Clustering'),
                      child: Text('Spectral Clustering'),
                    ),
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context, 'GMM Clustering'),
                      child: Text('GMM Clustering'),
                    ),
                  ],
                ),
              );

              final res = await newsApi.sendReview({
                "all": false,
                "preferred": preferred
              });
              Fluttertoast.showToast(
                msg: res["message"] ?? "Feedback submitted!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black87,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          },
          child: Text("Review the Result"),
        ),

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