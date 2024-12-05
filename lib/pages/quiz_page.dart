import 'package:flutter/material.dart';

import '../widgets/page_title.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PageTitle('Level 1/20'),
      ],
    );
  }
}
