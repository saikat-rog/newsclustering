import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:newsclustering/controllers/news_controller.dart';
import 'package:newsclustering/controllers/news_history_controller.dart';

import 'app_routes.dart';
import 'app_theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  Get.lazyPut(()=>NewsController());
  Get.lazyPut(()=> NewsHistoryController());
  Get.lazyPut(()=> NewsHistoryController());

  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News Clustering',
      theme: AppTheme.lightTheme(context),
      initialRoute: '/splash',
      getPages: AppRoutes.routes,
    );
  }
}