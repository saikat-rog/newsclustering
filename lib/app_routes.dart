import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:newsclustering/screens/history/history_details.dart';
import 'package:newsclustering/screens/history/history_screen.dart';
import 'package:newsclustering/screens/home/home_screen.dart';
import 'package:newsclustering/screens/news_details/news_details_screen.dart';
import 'package:newsclustering/screens/splash_screen.dart';
import 'package:newsclustering/screens/trending_news/trending_news_screen.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: '/',
      page: () => HomeScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: '/history',
      page: () => HistoryScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: '/history_details',
      page: () => HistoryDetailsScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: '/trending_news',
      page: () => TrendingNewsScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: '/news_details',
      page: () => const NewsDetailsScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}