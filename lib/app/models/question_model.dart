import 'package:go_tech_assignment/utils/app_logger.dart';

class QuestionModel {
  late int id;
  late String questionType;
  late String question;
  late bool isRequired;
  List<String>? answers;

  QuestionModel(
      {required this.id,
      required this.questionType,
      required this.question,
      required this.isRequired,
      this.answers});

  factory QuestionModel.fromMap(Map<String, dynamic> data) {
    final int id = data["id"];
    final String questionType = data["question_type"];
    final String question = data["question"];
    final bool isRequired = data["is_required"] ?? false;
    AppLogger.log("before answers: ${data["answers"]}");
    final List<String> answers = data["answers"] != null
        ? List.of(data["answers"]).map((e) => e.toString()).toList()
        : [];

    return QuestionModel(
        id: id,
        questionType: questionType,
        question: question,
        isRequired: isRequired,
        answers: answers);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionType': questionType,
      'question': question,
      'isRequired': isRequired,
      'answers': answers
    };
  }
}
