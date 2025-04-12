import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/news_controller.dart';
import '../../controllers/trending_news_controller.dart';
import '../../services/api_services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class TrendingNewsScreen extends StatelessWidget {
  final trendingNewsController = Get.put(TrendingNewsController());
  final newsController = Get.put(NewsController());
  final newsApi = NewsApi();

  TrendingNewsScreen({super.key});

  final List<String> countryCodes = [
    'Select country',
    'in', // India
    'us', // USA
    'gb', // United Kingdom
    'ca', // Canada
    'au', // Australia
    // Add more countries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trending News")),
      body: SingleChildScrollView(  // Wrap the entire body in a SingleChildScrollView
        child: Column(
          children: [
            // Get country from user
            Obx(() => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add a label for "Select Country"
                  Text(
                    "Select Country",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: 8),  // Add some space between label and dropdown

                  // Dropdown button with improved design
                  Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        value: trendingNewsController.country.value,
                        onChanged: (String? newValue) async {
                          if (newValue != null) {
                            trendingNewsController.setCountry(newValue);
                            // Fetch news based on the selected country
                            trendingNewsController.clearTrendingNews();  // Clear the previous news
                            trendingNewsController.setLoading(true);  // Show loading indicator
                            await newsApi.fetchTrendingNews(newValue);  // Fetch news for the selected country
                            trendingNewsController.setLoading(false);  // Hide loading indicator
                          }
                        },
                        isExpanded: true,  // Makes the dropdown expand to fit the container width
                        items: countryCodes.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase(), style: TextStyle(fontSize: 16)),  // Improved font size
                          );
                        }).toList(),
                        buttonStyleData: ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                        ),
                        iconStyleData: IconStyleData(
                          icon: Icon(Icons.arrow_drop_down, size: 24),
                          iconEnabledColor: Colors.black,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          offset: Offset(0, 8),
                        ),
                        // Remove search functionality by not including dropdownSearchData
                      ),
                    ),
                  ),
                ],
              ),
            )),

            // Shows the news
            Obx(() {
              final newsList = trendingNewsController.trendingNewsResult;
              final articles = newsList['articles'] ?? [];

              if (trendingNewsController.loading.value) {
                return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor));
              } else if (articles.isEmpty) {
                return const Center(child: Text("No News Found"));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                shrinkWrap: true,  // Ensures the ListView uses only the space it needs
                physics: NeverScrollableScrollPhysics(),  // Prevents nested scrolling conflicts
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final item = articles[index];
                  final title = item['title'] ?? 'No Title';
                  final url = item['url'] ?? '#';

                  return ListTile(
                    title: Text(
                      title,
                    ),
                    trailing: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("View"),
                      onPressed: () async {
                        newsController.setLoading(true);
                        Get.toNamed('/news_details');
                        await newsApi.fetchNews(url);
                        newsController.setLoading(false);
                      },
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
