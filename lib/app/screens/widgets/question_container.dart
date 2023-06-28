import 'package:flutter/cupertino.dart';

import '../../../utils/colors.dart';

class QuestionContainer extends StatelessWidget {
  final String question;
  final String questionType;
  final Widget? child; // text field widget
  const QuestionContainer({super.key, required this.question, required this.questionType, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: greyColor112WithOpacity30,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 0),
              )
            ]
        ),
        child: Column(
          children: [
            Text(
              question,
              style: const TextStyle(
                  color: blackColor77,
                  fontWeight: FontWeight.normal,
                  fontSize: 17),
            ),
            child ?? Container()
          ],
        ),
      ),
    );
  }
}
