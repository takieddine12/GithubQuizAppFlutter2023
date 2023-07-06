import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/auth_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10),(){
      GoogleSignInAccount? googleUser = Provider.of<AuthManager>(context,listen: false).googleAccount;
       print(googleUser == null ? "User null" : "User is not null");
       if(googleUser != null){
         // Get the authentication details
         Get.offNamed('/home',arguments: [googleUser.email,googleUser.displayName,googleUser.photoUrl]);
       } else {
         Get.offNamed("/login");
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Image.asset("assets/images/splash_bg.png",fit: BoxFit.cover,width: double.maxFinite,),
      ),
    );
  }

}
