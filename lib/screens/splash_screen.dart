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
            Text(
                'Your news clustering App',
                style: Theme.of(context).textTheme.headlineMedium
            ),
            Text(
              'News Intelligence at Your Fingertips!',
              style: Theme.of(context).textTheme.bodyLarge
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(), // Optional loading indicator
          ],

        ),
      ),
    );
  }
}