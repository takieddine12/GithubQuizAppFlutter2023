import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/auth_manager.dart';
import 'package:quiz_app/styles.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/images/login_bg.png",fit: BoxFit.cover,filterQuality: FilterQuality.high,
            height: double.maxFinite,width: double.maxFinite,),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Wrap(
                   children: [
                     Container(
                       width: double.maxFinite,
                       margin: const EdgeInsets.only(left: 30,right: 30,bottom: 30),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(16),
                           color: Colors.white
                       ),
                       child: Column(
                         children: [
                           const SizedBox(height: 30,),
                           Text("Login",textAlign: TextAlign.center,style: getStyle().copyWith(fontSize: 22,color: Colors.black87)),
                           const SizedBox(height: 20,),
                           Text("Login to take quiz challenges",style: getStyle().copyWith(fontSize: 15,color: Colors.grey)),
                           const SizedBox(height: 10,),
                           GestureDetector(
                             onTap: () async {
                                Provider.of<AuthManager>(context , listen: false).signInWithGoogle();
                               ///await context.read<AuthManager>().signInWithGoogle();
                             },
                             child: Container(
                               width: double.maxFinite,
                               height: 60,
                               margin: const EdgeInsets.all(20),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12),
                                   color: Colors.grey.shade200
                               ),
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Image.asset("assets/images/google.png",height: 54,width: 54,),
                                   const SizedBox(width: 10,),
                                   Expanded(
                                     child: Text("Sign in with google",style: getStyle().copyWith(fontSize: 17,color: Colors.black45),),
                                   )
                                 ],
                               ),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){
                               signInWithFacebook();
                             },
                             child: Container(
                               width: double.maxFinite,
                               height: 60,
                               margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12),
                                   color: Colors.grey.shade200
                               ),
                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(left: 10,right: 10),
                                     child: Image.asset("assets/images/face_icon.png",height: 28,width: 28),
                                   ),
                                   const SizedBox(width: 10,),
                                   Expanded(
                                     child: Text("Sign in with Facebook",style: getStyle().copyWith(fontSize: 17,color: Colors.black45),),
                                   )
                                 ],
                               ),
                             ),
                           )
                         ],
                       ),
                     )
                   ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  void signInWithFacebook() {}
}
