import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:shopping_list/UI/Onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
    super.initState();
    _navigateotherscreen();
  }

  _navigateotherscreen() async {
    await Future.delayed(Duration(seconds: 6), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Onbording()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child:  Lottie.asset('assets/animation/loading.json'),),
    );
  }
}