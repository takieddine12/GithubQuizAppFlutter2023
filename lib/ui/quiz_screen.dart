import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Get.arguments[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child :  Text("QUIZ SCREE?")
      ),
    );
  }
}
