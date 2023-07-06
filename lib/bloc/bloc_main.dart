

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/bloc_events.dart';
import 'package:quiz_app/bloc/bloc_state.dart';
import 'package:quiz_app/models/quiz_model.dart';

import '../service/auth_service.dart';

 class BlocMain extends Bloc<BlocEvents,BlocState> {
  late final AuthService _authService;
  BlocMain(this._authService) : super(INITIAL()){
    on<FetchQuizByCategoryEvent>(_fetchQuiz);
  }


  _fetchQuiz(FetchQuizByCategoryEvent event , Emitter<BlocState> emit) async {
    try {
      emit(LOADING());
      DataSnapshot snapshot = await _authService.getQuiz(event.category,event.quizIndex);
      if(snapshot.exists){
        var question = snapshot.child("Question").value.toString();
        var answer1 = snapshot.child("Answer1").value.toString();
        var answer2 = snapshot.child("Answer2").value.toString();
        var answer3 = snapshot.child("Answer3").value.toString();
        var answer4 = snapshot.child("Answer4").value.toString();
        var correctAnswer = snapshot.child("output").value.toString();

        QuizModel quizModel = QuizModel(question, answer1, answer2, answer3, answer4,correctAnswer);
        emit(FetchQuizByCategoryState(quizModel));
      } else {
        emit(LOADING());
      }
    } catch(e){
      emit(ERROR(e.toString()));
    }
  }

}