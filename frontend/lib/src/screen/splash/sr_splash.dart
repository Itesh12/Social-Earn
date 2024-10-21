import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:socialearn/src/screen/splash/ctrl_splash.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final SplashController c = Get.put(SplashController());

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust the duration as needed
    )..repeat();
    _animation = Tween<double>(
      begin: 70.0, // Initial size
      end: 100.0, // Final size
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Adjust the curve as needed
      ),
    );

    // Start the animation
    _controller.repeat(reverse: true);

    // Listen for animation changes and rebuild the UI
    _animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF121123),
              Color(0xFF000000),
            ],
          ),
        ),
        child: Center(
          child: FlutterLogo(
            size: _animation.value,
            // height: _animation.value,
            // width: _animation.value,
            // AppAssets.logo,
          ),
        ),
      ),
    );
  }
}
