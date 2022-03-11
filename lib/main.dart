import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app2/constant.dart';
import 'package:page_transition/page_transition.dart';

import 'view/screens/homescreen.dart';

void main() {
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.arvoTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.red,
        backgroundColor: Colors.black,
        appBarTheme:AppBarTheme(backgroundColor: Kblack),

      ),
      home: AnimatedSplashScreen(
          duration: 3000,
          splash:
          Image.asset("assets/images/splash.gif",
          height: double.infinity,
          width: double.infinity,
           // fit: BoxFit.cover,
          //  alignment: Alignment(0,0),
            ),
          splashIconSize: double.infinity,
          nextScreen: HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.bottomToTop,
          backgroundColor:Color(0xff151515) ),
    );
  }
}

