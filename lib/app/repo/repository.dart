import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_tech_assignment/app/models/question_model.dart';
import 'package:go_tech_assignment/services/db_service.dart';
import 'package:go_tech_assignment/utils/app_logger.dart';

class Repository extends ChangeNotifier {
  List<QuestionModel> _questions = [];

  Repository.e();

  List<QuestionModel> get questions => _questions;

  Future<List<QuestionModel>> getAllQuestions() async {
    try {
      _questions = await DBService.getAllQuestions();
    } catch (e) {
      AppLogger.error("getAllQuestions - $e");
    }
    notifyListeners();
    return _questions;
  }

  Future<bool> saveAnswers(List<dynamic> answers) async {
    Map<String, dynamic> result = {};
    try {
      result = await DBService.saveAllAnswers(answers);
    } catch (e) {
      AppLogger.error("saveAnswer - $e");
      return false;
    }
    if (result["msg"] == "success") {
      return true;
    }
    return false;
  }
}
