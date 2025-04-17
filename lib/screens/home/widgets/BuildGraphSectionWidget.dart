import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsclustering/controllers/news_controller.dart';

class BuildGraphSectionWidget extends StatelessWidget {
  BuildGraphSectionWidget({super.key});

  final newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
      child: SizedBox(
        height: 300,
        child: BarChart(
          BarChartData(
            maxY: 10,
            barGroups: _generateBarGroups(),
            titlesData: FlTitlesData(
              topTitles: AxisTitles( // Disable top titles
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles( // Disable right side titles
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.isFinite ? value.toStringAsFixed(1) : '',
                      style: const TextStyle(fontSize: 10),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    List<String> algorithms = ["KMM", "AGNES", "SC", "GMM"];

                    if (value.toInt() >= 0 && value.toInt() < algorithms.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text(
                          algorithms[value.toInt()],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  reservedSize: 25,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,  // Ensures the border is displayed
              border: const Border(
                bottom: BorderSide(color: Colors.black, width: 2),   // Y-axis
              ),
            ),
            gridData: FlGridData(show: false),
            extraLinesData: ExtraLinesData(
              horizontalLines: List.generate(10, (index) => HorizontalLine(
                y: index.toDouble(),  // Creates a line at every integer value
                color: Colors.grey.withOpacity(0.5),
                strokeWidth: 1,
              )),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    List<Color> colors = [Colors.blue, Colors.red, Colors.yellow];
    List<String> metrics = ["Silhouette Score", "DB Index", "CH Index"];

    var clusteringData = newsController.newsResult["clustering_metrics"] as Map<String, dynamic>;

    return List.generate(clusteringData.length, (index) {
      String algorithm = clusteringData.keys.elementAt(index);
      return BarChartGroupData(
        x: index,
        barRods: List.generate(metrics.length, (metricIndex) {
          double? value = clusteringData[algorithm]?[metrics[metricIndex]];
          return BarChartRodData(
            toY: (value?.isFinite == true) ? value! : 0.0,
            color: colors[metricIndex],
            width: 18,
            borderRadius: BorderRadius.circular(3), // Makes bars rectangular
          );
        }),
      );
    });
  }
}
