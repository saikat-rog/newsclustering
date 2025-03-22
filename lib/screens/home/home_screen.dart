import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newsclustering/controllers/news_controller.dart';
import 'package:newsclustering/screens/home/widgets/BuildResultsWidget.dart';
import 'package:newsclustering/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInfoButtonClicked = false;
  final NewsApi newsApi = NewsApi();
  final TextEditingController urlController = TextEditingController();
  final newsController = Get.put(NewsController());
  bool isLoading = false;

  void toggleInfoButton() => setState(() => _isInfoButtonClicked = !_isInfoButtonClicked);

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
            const SizedBox(height: 16),
            const Text('Enter News URL', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'https://news.example.com/article',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() => isLoading = true);
                  await newsApi.fetchNews(urlController.text);
                  setState(() => isLoading = false);
                  urlController.clear();
                },
                child: const Text('Cluster News'),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Analysis Results', style: TextStyle(fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => Get.toNamed('/history'),
                  child: Icon(Icons.history, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            Obx(
                  () => isLoading
                  ? Center(
                child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
              )
                  : newsController.getNews().isEmpty
                  ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Search your news.', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              )
                  : const BuildResultsWidget()
            ),
            // Add a graph that would show the data where the x axis will be number of cluster and y axis will be the score.
          ],
        ),
      ),
    );
  }
}
