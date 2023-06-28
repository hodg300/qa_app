class AnswersModel {
  late String id;
  late String question;
  late String answer;

  AnswersModel(
      {required this.id, required this.question, required this.answer});

  factory AnswersModel.fromMap(Map<String, dynamic> data) {
    final String id = data["id"];
    final String questionType = data["questionType"];
    final String question = data["question"];
    final String answer = data["answer"];

    return AnswersModel(id: id, question: question, answer: answer);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'question': question, 'answer': answer};
  }
}
