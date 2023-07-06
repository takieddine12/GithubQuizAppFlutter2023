import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/auth_manager.dart';
import 'package:quiz_app/bloc/bloc_main.dart';
import 'package:quiz_app/service/auth_service.dart';
import 'package:quiz_app/ui/category_screen.dart';
import 'package:quiz_app/ui/home_screen.dart';
import 'package:quiz_app/ui/login_screen.dart';
import 'package:quiz_app/ui/quiz_screen.dart';
import 'package:quiz_app/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (_) => BlocMain(AuthService()),
    child: Provider<AuthManager>(
      create: (_) => AuthManager(GoogleSignIn(scopes: ['email','profile'])),
      child: GetMaterialApp(
        home: const MyApp(),
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: "/category", page: () => const CategoryScreen()),
          GetPage(name: "/home", page: () => const HomeScreen()),
          GetPage(name: "/quiz", page: () => const QuizScreen()),
          GetPage(name: "/login", page: () => const LoginScreen())
        ],
      ),
    ),
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
