import 'package:flutter/material.dart';

import '../models/question.dart';
import '../widgets/button.dart';
import '../widgets/my_button.dart';
import '../widgets/my_dialog.dart';
import '../widgets/page_title.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int question = 0;
  int correct = 0;
  Answer selected = Answer(title: '', isCorrect: false);

  void onAnswer(Answer answer) {
    setState(() {
      selected = answer;
    });
  }

  void onNext() async {
    if (selected.isCorrect) correct++;
    if (question == 19) {
      await showDialog(
        context: context,
        builder: (context) {
          return MyDialog(title: 'Correct answers $correct');
        },
      ).then((value) {
        shuffle();
        setState(() {});
      });
    } else {
      setState(() {
        question++;
        selected = Answer(title: '', isCorrect: false);
      });
    }
  }

  void shuffle() {
    question = 0;
    correct = 0;
    selected = Answer(title: '', isCorrect: false);
    questions.shuffle();
    for (Question question in questions) {
      question.answers.shuffle();
    }
  }

  @override
  void initState() {
    super.initState();
    shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTitle('Question ${question + 1}/20'),
        const SizedBox(height: 25),
        const Text(
          'Select an answer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'w700',
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                questions[question].title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'w700',
                ),
              ),
            ),
          ),
        ),
        _Answer(
          answer: questions[question].answers[0],
          selected: selected,
          onPressed: onAnswer,
        ),
        _Answer(
          answer: questions[question].answers[1],
          selected: selected,
          onPressed: onAnswer,
        ),
        _Answer(
          answer: questions[question].answers[2],
          selected: selected,
          onPressed: onAnswer,
        ),
        _Answer(
          answer: questions[question].answers[3],
          selected: selected,
          onPressed: onAnswer,
        ),
        const Spacer(),
        Button(
          title: 'Next',
          isActive: selected.title.isNotEmpty,
          onPressed: onNext,
        ),
        const SizedBox(height: 130),
      ],
    );
  }
}

class _Answer extends StatelessWidget {
  const _Answer({
    required this.answer,
    required this.selected,
    required this.onPressed,
  });

  final Answer answer;
  final Answer selected;
  final void Function(Answer) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(
        bottom: 25,
        left: 30,
        right: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 3,
          color: const Color(0xffF8FF13),
        ),
      ),
      child: MyButton(
        onPressed: () {
          onPressed(answer);
        },
        child: Stack(
          children: [
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: answer == selected ? const Color(0xffF8FF13) : null,
                    borderRadius: BorderRadius.circular(2),
                    border: answer == selected
                        ? null
                        : Border.all(
                            width: 3,
                            color: const Color(0xffF8FF13),
                          ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  answer.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'w700',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
