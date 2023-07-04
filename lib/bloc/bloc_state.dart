

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/quiz_model.dart';

abstract class BlocState {}
class INITIAL extends BlocState {}
class LOADING extends BlocState {}
class ERROR extends BlocState {
  String error;
  ERROR(this.error);
}
class FetchQuizByCategoryState extends BlocState {
  QuizModel quizModel;
  FetchQuizByCategoryState(this.quizModel);
}