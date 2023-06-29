import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_tech_assignment/app/screens/widgets/custom_header_widget.dart';
import 'package:go_tech_assignment/app/screens/widgets/questions_widget.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../models/question_model.dart';
import '../repo/repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<QuestionModel>> myFuture;

  @override
  void initState() {
    super.initState();
    // In order to run this futureBuilder only once
    myFuture = context.read<Repository>().getAllQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: purple224,
        body: FutureBuilder<List<QuestionModel>>(
            future: myFuture,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<QuestionModel>> snapshot,
            ) {
              if (kDebugMode) {
                print(snapshot.connectionState);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: const [
                          CustomHeaderWidget(),
                          QuestionsWidget()
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }));
  }
}
