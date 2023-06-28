import 'dart:convert';

import '../app/models/question_model.dart';
import '../db/db.dart';
import '../utils/api_path.dart';
import '../utils/app_logger.dart';

class DBService{
  static Future<List<QuestionModel>> getAllQuestions() async{
    List<QuestionModel> questions = [];
    try{
      var result = await DB.getData(route: APIPath.questions());
      AppLogger.log("getAllQuestions - $result");
      if(result["msg"] == "success") {
        AppLogger.log("getAllQuestions - ${result["data"].runtimeType.toString()}");
        questions = List.of(result["data"]).map((e) => QuestionModel.fromMap(e)).toList();
      }
      //
      AppLogger.log("After get the data --- ${questions.map((e) => e.id).toList()}");
    }catch(e){
      AppLogger.error("getAllQuestions - $e");
    }

    return questions;
  }
}