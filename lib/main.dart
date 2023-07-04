import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/ui/category_screen.dart';
import 'package:quiz_app/ui/home_screen.dart';
import 'package:quiz_app/ui/login_screen.dart';
import 'package:quiz_app/ui/quiz_screen.dart';
import 'package:quiz_app/ui/splash_screen.dart';

void main() {
  runApp(GetMaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(name: "/category", page: () => const CategoryScreen()),
      GetPage(name: "/home", page: () => const HomeScreen()),
      GetPage(name: "/quiz", page: () => const QuizScreen()),
      GetPage(name: "/login", page: () => const LoginScreen())
    ],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
