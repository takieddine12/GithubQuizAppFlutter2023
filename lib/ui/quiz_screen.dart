import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
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

  final CountdownController _countdownController = CountdownController(autoStart: true);
  final List<int> _correctAnswers = [];
  bool isAnswerCorrect = false;
  var buttonText = "Next";
  var isVisible = false;
  var selectedCategory = "";
  var questionIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategory  = Get.arguments[0];
    BlocProvider.of<BlocMain>(context).add(FetchQuizByCategoryEvent(selectedCategory, questionIndex.toString()));
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
                  return Container();
                }
                else if (state is ERROR){
                  return Container();
                }
                else  if(state is FetchQuizByCategoryState){
                  var quizModel = state.quizModel;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      Center(child: Text("Question $questionIndex",style: getStyle().copyWith(fontSize: 20,color: Colors.white),textAlign: TextAlign.center,)),
                      const SizedBox(height: 20,),
                      Countdown(
                        controller: _countdownController,
                        seconds: 30,
                        build: (_,time){
                          return Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                color: Colors.white
                            ),
                            child: Center(
                              child: Text(time < 10 ? time.toString().substring(0,1) : time.toString().substring(0,2),style: getStyle().copyWith(fontSize: 20,color: Colors.black),),
                            ),
                          );
                        },
                        interval: const Duration(seconds: 1),
                        onFinished: (){
                          questionIndex++;
                          if(questionIndex == 10){
                            buttonText = 'Finish';
                          }
                          BlocProvider.of<BlocMain>(context).add(FetchQuizByCategoryEvent(selectedCategory, questionIndex.toString()));
                        },),
                      Container(
                        width: double.maxFinite,
                        height: 200,
                        margin: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30,right: 30),
                            child: Text(quizModel.question,style: getStyle().copyWith(fontSize: 20,color: Colors.black),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                      customContainer(quizModel.answer1,"1",(){
                        if(quizModel.correctAnswer.toString()  == quizModel.answer1.toString()){
                          setState(() {
                            isVisible = true;
                          });
                        } else {}
                      }),
                      customContainer(quizModel.answer2,"2",(){
                        if(quizModel.correctAnswer.toString() == quizModel.answer2.toString()){
                          setState(() {
                            isVisible = true;
                          });
                        } else {

                        }
                      }),
                      customContainer(quizModel.answer3,"3",(){
                        if(quizModel.correctAnswer.toString()  == quizModel.answer3.toString()){
                          setState(() {
                            isVisible = true;
                          });
                        } else {

                        }
                      }),
                      customContainer(quizModel.answer4,"4",(){
                        if(quizModel.correctAnswer.toString() == quizModel.answer4.toString()){
                          setState(() {
                            isVisible = true;
                          });
                        } else {

                        }
                      }),
                      const SizedBox(height: 15,),
                      Visibility(
                        visible : isVisible,
                        child: GestureDetector(
                          onTap : (){
                            if(buttonText.toString() == 'Finish'){
                              print('List Size ${_correctAnswers.length}');
                              if(_correctAnswers.length == 9){
                                _countdownController.pause();
                                showSuccessDialog();
                              } else {
                                _countdownController.pause();
                                showFailureDialog();
                              }
                            } else {
                              questionIndex++;
                              if(questionIndex == 10){
                                buttonText = 'Finish';
                              }
                              _correctAnswers.add(questionIndex);
                              BlocProvider.of<BlocMain>(context).add(FetchQuizByCategoryEvent(selectedCategory, questionIndex.toString()));
                              setState(() {
                                isVisible = false;
                              });
                            }
                          },
                          child: Container(
                            width: 250,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.indigo
                            ),
                            child:  Center(
                              child: Text(buttonText,style: getStyle().copyWith(fontSize: 15 , color: Colors.white),),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
                else {
                   return Container();
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
        padding: const EdgeInsets.only(left: 30,right: 30,top: 8),
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
  showSuccessDialog() {
    showDialog(
        context: context,
        builder: (_){
          return Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(30),
             ),
            child: Column(
              children: [
                 Container(
                   width: double.maxFinite,
                   height: 250,
                   decoration: const BoxDecoration(
                     color: Colors.green
                   ),
                   child: Center(
                     child: SizedBox(
                       height: 80,
                       width: 80,
                       child: Card(
                         color: Colors.green.shade500,
                         shape: const CircleBorder(side: BorderSide.none),
                         child: const Center(
                           child: Icon(Icons.check, size: 30,color: Colors.white,),
                         ),
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(height: 20,),
                 Center(child: Text('Success',style: getStyle().copyWith(fontSize: 20 , color: Colors.black),)),
                 const SizedBox(height: 10,),
                 Padding(
                   padding: const EdgeInsets.only(left: 30,right: 30),
                   child: Text('Congrats , You have successfully completed the quiz',
                    style: getStyle().copyWith(fontSize: 20 , color: Colors.black54),textAlign: TextAlign.center,),
                 ),
                 const SizedBox(height: 20,),
                 GestureDetector(
                   onTap: (){
                     Get.offNamed('/home');
                   },
                   child: Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: Colors.indigo
                     ),
                     child: Center(
                       child: Text('Done',style: getStyle().copyWith(fontSize: 15),),
                     ),
                   ),
                 )
              ],
            ),
          );
        });
  }
  showFailureDialog() {
    showDialog(
        context: context,
        builder: (_){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 250,
                  decoration: const BoxDecoration(
                      color: Colors.green
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Card(
                        color: Colors.green.shade500,
                        shape: const CircleBorder(side: BorderSide.none),
                        child: const Center(
                          child: Icon(Icons.check, size: 30,color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Center(child: Text('Failure',style: getStyle().copyWith(fontSize: 20 , color: Colors.black),)),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: Text('Sorry , You failed to pass the quiz',
                    style: getStyle().copyWith(fontSize: 20 , color: Colors.black54),textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Get.offNamed('/home');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.indigo
                    ),
                    child: Center(
                      child: Text('Done',style: getStyle().copyWith(fontSize: 15),),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

}
