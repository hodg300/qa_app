import 'package:flutter/material.dart';
import 'package:go_tech_assignment/utils/utils.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';

class CustomHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomHeaderWidget(
      {super.key,
      this.title = "GoTech\nQuestionnaire",
      this.subtitle = "Show me what you got!"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 10,
              width: Utils.screenWidthSize(context),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: purpleColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: blackColor77,
                          fontWeight: FontWeight.w500,
                          fontSize: headerTitleFontSize),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                          color: blackColor77,
                          fontWeight: FontWeight.normal,
                          fontSize: headerSubtitleFontSize),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      requiredText,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.normal,
                          fontSize: headerSubtitleFontSize),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
