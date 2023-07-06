
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseDatabase _firebaseDatabase  = FirebaseDatabase.instance;

  // TODO : GET QUIZ BY CATEGORY
  Future<DataSnapshot> getQuiz(String category , String quizIndex) async {
    return await _firebaseDatabase.ref().child("Quiz").child(category).child(quizIndex).get();
  }

}