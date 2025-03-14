import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart'; // If using GetX for navigation
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    // Simulate a delay (e.g., fetching data, loading assets)
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Responsive Image
            SvgPicture.asset(
              'assets/logo.svg',
              width: MediaQuery.of(context).size.width * 0.3, // 40% of screen width
            ),
            SizedBox(height: 20),
            // Responsive Text
            Text(
              'Your News Clustering App',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06, // 6% of screen width
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(), // Optional loading indicator
          ],

        ),
      ),
    );
  }
}