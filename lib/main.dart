import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home-screen/homescreen.dart';
import 'splash/splash-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Habit Tracker',
        theme: ThemeData(
          fontFamily: GoogleFonts.hachiMaruPop().fontFamily,
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashScreen(),
        routes: {
          '/home': (context) => HomeScreen(),
        },
      
    );
  }
}
