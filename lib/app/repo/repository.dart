import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_tech_assignment/app/models/answer_model.dart';
import 'package:go_tech_assignment/app/models/question_model.dart';
import 'package:go_tech_assignment/services/db_service.dart';
import 'package:go_tech_assignment/utils/app_logger.dart';

class Repository extends ChangeNotifier{
  List<QuestionModel> _questions = [];
  final List<AnswersModel> _answers = [];

  Repository.e();

  List<QuestionModel> get questions => _questions;
  List<AnswersModel> get answers => _answers;


  clearForm(){
    _questions.clear();
  }

  Future<List<QuestionModel>> getAllQuestions() async{
    try{
      _questions = await DBService.getAllQuestions();
    }catch(e){
      AppLogger.error("getAllQuestions - $e");
    }
    notifyListeners();
    return _questions;
  }
}