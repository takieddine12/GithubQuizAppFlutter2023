

abstract class BlocEvents {}
class FetchQuizByCategoryEvent extends BlocEvents {
  String category;
  String quizIndex;
  FetchQuizByCategoryEvent(this.category,this.quizIndex);
}