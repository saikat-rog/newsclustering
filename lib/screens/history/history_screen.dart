import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/news_history_controller.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsHistoryController = Get.put(NewsHistoryController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Search History', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              newsHistoryController.clearNewsHistory();
            },
            child: Text('Clear All', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Obx(() {
        if (newsHistoryController.newsHistory.isEmpty) {
          return Center(child: Text("No search history available"));
        }
        return ListView.builder(
          itemCount: newsHistoryController.newsHistory.length,
          itemBuilder: (context, index) {
            final historyItem = newsHistoryController.newsHistory[index];
            return GestureDetector(
              onTap: (){
                Get.toNamed('/history_details', arguments: {'index': index});
              },
              child: ListTile(
                title: Text(historyItem['category'] ?? '', style: TextStyle(color: Colors.black)),
                subtitle: Text(historyItem['summary'] ?? '', style: TextStyle(color: Colors.grey[600]), overflow: TextOverflow.ellipsis,),
              ),
            );
          },
        );
      }),
    );
  }
}