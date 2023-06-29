import 'package:flutter/material.dart';
import 'package:go_tech_assignment/utils/utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class QuestionContainer extends StatelessWidget {
  final String question;
  final bool isRequired;
  final Widget? child; // text field widget
  const QuestionContainer(
      {super.key,
      required this.question,
      this.child,
      required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Container(
        width: Utils.screenWidthSize(context),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: greyColor112WithOpacity30,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 0),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SizedBox(
                  width: Utils.screenWidthSize(context) * 0.85,
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: questionTitleFontSize,
                          fontWeight: FontWeight.normal,
                          // fontFamily: FONT_FAMILY,
                          color: blackColor77),
                      children: [
                        TextSpan(text: question),
                        if (isRequired)
                          const TextSpan(
                              text: ' *',
                              style: TextStyle(
                                  fontSize: questionTitleFontSize,
                                  fontWeight: FontWeight.normal,
                                  // fontFamily: FONT_FAMILY,
                                  color: Colors.red)),
                      ],
                    ),
                  ),
                ),
              ),
              child ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}
