// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gainup/core/utils/app_assets.dart';
// import 'package:gainup/src/screens/splash/ctrl_splash.dart';
// import 'package:get/get.dart';
//
// class SplashScreen extends StatelessWidget {
//   SplashScreen({super.key});
//
//   final SplashController c = Get.put(SplashController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF121123),
//               Color(0xFF000000),
//             ],
//           ),
//         ),
//         child: Stack(
//           children: [
//             AnimatedCircleWidget(c),
//             Center(
//               child: Image.asset(
//                 height: 100.h,
//                 width: 100.h,
//                 AppAssets.logo,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class AnimatedCircleWidget extends StatelessWidget {
//   final SplashController c;
//
//   const AnimatedCircleWidget(this.c, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SplashController>(builder: (logic) {
//       return RotationTransition(
//         turns: Tween(begin: 0.0, end: 1.0).animate(c.animationController),
//         child: Center(
//           child: Image.asset(
//             AppAssets.animatedCircle,
//             height: 200.h,
//             width: 200.h,
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:gainup/core/utils/app_assets.dart';
import 'package:gainup/src/screens/splash/ctrl_splash.dart';
import 'package:get/get.dart';

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
      duration: Duration(seconds: 1), // Adjust the duration as needed
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
          child: Image.asset(
            height: _animation.value,
            width: _animation.value,
            AppAssets.logo,
          ),
        ),
      ),
    );
  }
}

// class AnimatedCircleWidget extends StatelessWidget {
//   final SplashController c;
//
//   const AnimatedCircleWidget(this.c, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SplashController>(builder: (logic) {
//       return RotationTransition(
//         turns: Tween(begin: 0.0, end: 1.0).animate(c.animationController),
//         child: Center(
//           child: Image.asset(
//             AppAssets.animatedCircle,
//             height: 200.h,
//             width: 200.h,
//           ),
//         ),
//       );
//     });
//   }
// }
