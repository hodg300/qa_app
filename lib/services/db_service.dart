import '../app/models/question_model.dart';
import '../db/db.dart';
import '../utils/api_path.dart';
import '../utils/app_logger.dart';

class DBService {
  static Future<List<QuestionModel>> getAllQuestions() async {
    List<QuestionModel> questions = [];
    try {
      var result = await DB.getData(route: APIPath.questions());
      AppLogger.log("getAllQuestions - $result");
      if (result["msg"] == "success") {
        AppLogger.log(
            "getAllQuestions - ${result["data"].runtimeType.toString()}");
        questions = List.of(result["data"])
            .map((e) => QuestionModel.fromMap(e))
            .toList();
      }
      //
      AppLogger.log(
          "After get the data --- ${questions.map((e) => e.id).toList()}");
    } catch (e) {
      AppLogger.error("getAllQuestions - $e");
    }

    return questions;
  }

  static Future<Map<String, dynamic>> saveAllAnswers(
      List<dynamic> answers) async {
    Map<String, dynamic> response = {};
    try {
      for (var answer in answers) {
        try {
          if ((await getAnswer(answer["id"]) != null)) {
            await deleteAnswer(answer["id"]);
            AppLogger.log(
                "delete answer - ${answer["id"]} has been successful");
          }
          response = await DB.postData(route: APIPath.answers(), data: answer);
        } catch (e) {
          AppLogger.error(e);
          return response;
        }
      }
    } catch (e) {
      AppLogger.error("saveAllAnswers - $e");
    }

    return response;
  }

  static Future<Map<String, dynamic>> deleteAnswer(int answer) async {
    Map<String, dynamic> response = {};
    try {
      try {
        response = await DB.deleteData(
            route: APIPath.answers(), id: answer.toString());
      } catch (e) {
        AppLogger.error(e);
        return response;
      }
    } catch (e) {
      AppLogger.error("saveAllAnswers - $e");
    }

    return response;
  }

  static Future<Map<String, dynamic>?> getAnswer(int id) async {
    Map<String, dynamic> response = {};
    try {
      response = await DB.getData(route: APIPath.answers(), id: id.toString());
    } catch (e) {
      AppLogger.error("saveAllAnswers - $e");
    }
    if (response["msg"] == "failure") {
      return null;
    }
    return response["data"];
  }
}
