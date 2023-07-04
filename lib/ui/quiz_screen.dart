import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quiz_app/bloc/bloc_main.dart';
import 'package:quiz_app/bloc/bloc_state.dart';
import 'package:quiz_app/styles.dart';

import '../bloc/bloc_events.dart';
import '../bloc/bloc_events.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var selectedCategory = "";
  var questionIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategory  = Get.arguments[0];
    BlocProvider.of<BlocMain>(context)
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/images/bg.png",fit: BoxFit.cover,filterQuality: FilterQuality.high,
            height: double.maxFinite,width: double.maxFinite,),
            BlocBuilder<BlocMain,BlocState>(
              builder: (context, state){
                if(state is LOADING){
                  return const Center(child: CircularProgressIndicator(color: Colors.indigo,),);
                }
                else if (state is ERROR){
                  return Container();
                }
                else {
                  var quizModel = (state as FetchQuizByCategoryState).quizModel;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      Text("Question : $questionIndex",style: getStyle().copyWith(fontSize: 25,color: Colors.white),),
                      const SizedBox(height: 20,),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.white
                        ),
                        child: Center(
                          child: Text('30',style: getStyle().copyWith(fontSize: 20,color: Colors.black),),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 200,
                        margin: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Center(
                          child: Text(quizModel.question,style: getStyle().copyWith(fontSize: 20,color: Colors.black),),
                        ),
                      ),
                      customContainer(quizModel.answer1,"1",(){

                      }),
                      customContainer(quizModel.answer1,"2",(){

                      }),
                      customContainer(quizModel.answer1,"3",(){

                      }),
                      customContainer(quizModel.answer1,"4",(){

                      }),
                      const SizedBox(height: 15,),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.indigo
                        ),
                        child:  Center(
                          child: Text('Next',style: getStyle().copyWith(fontSize: 15 , color: Colors.white),),
                        ),
                      )
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget customContainer(String answer , String questionNum , Function()? onTap){
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 8),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white
          ),
          child: Row(
            children: [
              const SizedBox(width: 10,),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.blueGrey
                ),
                child: Center(child: Text(questionNum,style: getStyle().copyWith(fontSize: 15),)),
              ),
              const SizedBox(width: 20,),
              Expanded(child: Text(answer,style: getStyle().copyWith(fontSize: 15,color: Colors.black),))
            ],
          ),
        ),
      ),
    );
  }
}
