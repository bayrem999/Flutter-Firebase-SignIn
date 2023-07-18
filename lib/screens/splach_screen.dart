import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in/screens/Home/home_screen.dart';
import 'package:sign_in/screens/Wrapper.dart';

/*
class splach extends StatefulWidget {
  const splach({super.key});

  @override
  State<splach> createState() => _splachState();
}

class _splachState extends State<splach> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 5) ,  () {

      Navigator.of(context).pushReplacement(

          MaterialPageRoute(builder: (_splachState) => const wrapper(), ) ,);


    } );
  }

  @override
  void dispose() {
   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Container( width:double.infinity,
decoration: BoxDecoration(
  gradient: LinearGradient(colors: [Colors.blueAccent , Colors.white],
  begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  ),
) ,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children:const [

            Icon(Icons.account_circle_rounded,size: 250 , color: Colors.white,)









          ],

        ),

      ),
    );
  }
}*/

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

