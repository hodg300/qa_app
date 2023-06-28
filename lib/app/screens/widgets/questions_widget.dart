import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_tech_assignment/app/screens/widgets/custom_elevated_button.dart';
import 'package:go_tech_assignment/app/screens/widgets/question_container.dart';
import 'package:go_tech_assignment/utils/app_logger.dart';
import 'package:provider/provider.dart';

import '../../models/question_model.dart';
import '../../repo/repository.dart';

class QuestionsWidget extends StatefulWidget {
  const QuestionsWidget({super.key});

  @override
  State<QuestionsWidget> createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  // add here a form key and create 3 container of QuestionContainer with this form key and it is validate this form before click submit
  createQuestionsWidget(){
    List<QuestionContainer> qcList = [];
    AppLogger.log("context.watch<Repository>().questions: ${context.watch<Repository>().questions}");
    for(QuestionModel qm in context.watch<Repository>().questions){
      if(qm.questionType == "text"){
        qcList.add(QuestionContainer(question: qm.question, questionType: qm.questionType, child: const TextField(),));
      }
    }
    return qcList;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: createQuestionsWidget(),
          ),

          CustomElevatedButton(key: const Key("1234"), child: const Text("submit"))
        ]
    );
  }
}
