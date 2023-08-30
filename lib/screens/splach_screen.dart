import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in/screens/Home/home_screen.dart';
import 'package:sign_in/screens/Wrapper.dart';


class splach extends StatelessWidget {
  const splach({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Lottie.asset("assets/animations/access.json"),

        splashIconSize: 300,
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: const Duration(seconds: 2),
        nextScreen: const wrapper());
  }
}

