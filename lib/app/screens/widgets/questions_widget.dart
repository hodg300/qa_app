import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_tech_assignment/app/screens/widgets/custom_elevated_button.dart';
import 'package:go_tech_assignment/app/screens/widgets/question_container.dart';
import 'package:go_tech_assignment/utils/app_logger.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/keys.dart';
import '../../../utils/utils.dart';
import '../../models/question_model.dart';
import '../../repo/repository.dart';

class QuestionsWidget extends StatefulWidget {
  const QuestionsWidget({super.key});

  @override
  State<QuestionsWidget> createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends State<QuestionsWidget> {
  /// When the user selected answer, they save in this list
  late List<dynamic> answers = [];

  /// Group value to language question
  String? _languageSelection;

  final programmingTextFieldController = TextEditingController();

  /// Group value to assignment question
  String? _assignmentSelection;
  GlobalKey<FormState> otherFormKey = GlobalKey<FormState>();
  final assignmentTextFieldController = TextEditingController();

  createOtherTextField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: otherFormKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SizedBox(
            height: 25,
            child: TextFormField(
              controller: assignmentTextFieldController,
              validator: MultiValidator([RequiredValidator(errorText: "")]),
              onTap: () {
                setState(() {
                  _assignmentSelection = "Other:";
                });
              },
              onSaved: (value) {},
              onChanged: (value) {},
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  errorStyle: TextStyle(height: 0),
                  labelStyle: TextStyle(fontSize: questionTitleFontSize)),
            ),
          ),
        ),
      ),
    );
  }

  createRegularTextField() {
    return SizedBox(
        width: Utils.screenWidthSize(context) * 0.85,
        child: TextField(
          controller: programmingTextFieldController,
          decoration: const InputDecoration(
              // border: Borde,
              hintText: yourAnswerText,
              labelStyle: TextStyle(fontSize: questionTitleFontSize)),
        ));
  }

  createRadioButtons(
      Key listViewKey, QuestionModel questionModel, String? groupValue) {
    return Theme(
      data: Theme.of(context).copyWith(unselectedWidgetColor: grey112),
      child: ListView.builder(
          key: listViewKey,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: questionModel.answers!.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  width: Utils.screenWidthSize(context) * 0.93,
                  child: ListTile(
                    key: Key(questionModel.answers![index]),
                    leading: Radio<String>(
                      value: questionModel.answers![index],
                      activeColor: purpleColor,
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      groupValue: questionModel.id == 1
                          ? _languageSelection
                          : _assignmentSelection,
                      onChanged: (value) {
                        AppLogger.log(
                            "value : $value,  questionModel.id ==== ${questionModel.id}");

                        setState(() {
                          if (questionModel.id == 1) {
                            _languageSelection = value;
                          } else {
                            _assignmentSelection = value;
                            otherFormKey.currentState!.reset();
                          }
                        });
                      },
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Utils.screenWidthSize(context) * 0),
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: 0, vertical: -4),
                    horizontalTitleGap: 0,
                    title: Row(
                      children: [
                        Text(questionModel.answers![index],
                            style: const TextStyle(
                                color: blackColor77,
                                fontWeight: FontWeight.normal,
                                fontSize: questionTitleFontSize)),
                        if (questionModel.answers![index] == "Other:" &&
                            index == questionModel.answers!.length - 1)
                          createOtherTextField()
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  createQuestionsWidget() {
    List<QuestionContainer> qcList = [];
    for (QuestionModel qm in context.watch<Repository>().questions) {
      if (qm.questionType == "text") {
        qcList.add(QuestionContainer(
          question: qm.question,
          isRequired: qm.isRequired,
          child: createRegularTextField(),
        ));
      } else if (qm.questionType == "multiple_choice") {
        qcList.add(QuestionContainer(
          question: qm.question,
          isRequired: qm.isRequired,
          child: createRadioButtons(
              const Key(Keys.radioBtnsLanguageKey), qm, _languageSelection),
        ));
      } else if (qm.questionType == "multiple_and_other") {
        qcList.add(QuestionContainer(
          question: qm.question,
          isRequired: qm.isRequired,
          child: createRadioButtons(
              const Key(Keys.radioBtnsAssignmentKey), qm, _assignmentSelection),
        ));
      }
    }
    return qcList;
  }

  isValidate() {
    if (_languageSelection != null && _assignmentSelection != null) {
      return true;
    }
    return false;
  }

  resetForm() {
    setState(() {
      assignmentTextFieldController.clear();
      programmingTextFieldController.clear();
      _languageSelection = null;
      _assignmentSelection = null;
    });
  }

  resetAnswers() {
    setState(() {
      answers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: createQuestionsWidget(),
            ),
            if (context.watch<Repository>().questions.isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: CustomElevatedButton(
                  key: const Key(Keys.submitBtnKey),
                  color: purpleColor,
                  onPressed: () async {
                    try {
                      if (isValidate()) {
                        var repository =
                            Provider.of<Repository>(context, listen: false);
                        answers.add({
                          "id": 1,
                          "question": repository.questions[0].question,
                          "answer": _languageSelection
                        });
                        answers.add({
                          "id": 2,
                          "question": repository.questions[1].question,
                          "answer":
                              programmingTextFieldController.text.toString()
                        });
                        if (_assignmentSelection == "Other:") {
                          if (otherFormKey.currentState!.validate()) {
                            answers.add({
                              "id": 3,
                              "question": repository.questions[2].question,
                              "answer":
                                  assignmentTextFieldController.text.toString()
                            });
                          } else {
                            resetAnswers();
                          }
                        } else {
                          answers.add({
                            "id": 3,
                            "question": repository.questions[2].question,
                            "answer": _assignmentSelection
                          });
                        }

                        var res = await context
                            .read<Repository>()
                            .saveAnswers(answers);
                        if (!res) {
                          resetAnswers();
                        } else {
                          resetForm();
                        }
                      }
                    } catch (e) {
                      AppLogger.error(e);
                    }
                  },
                  child: const Text(
                    submitText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
          ]),
    );
  }
}
