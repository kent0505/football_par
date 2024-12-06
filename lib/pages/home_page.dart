import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bottom/bottom_bloc.dart';
import '../widgets/bottom.dart';
import 'games_page.dart';
import 'novost_page.dart';
import 'pazl_page.dart';
import 'quiz_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<BottomBloc, BottomState>(
            builder: (context, state) {
              if (state is BottomNews) return const NovostPage();

              if (state is BottomQuiz) return const QuizPage();

              if (state is BottomPuzzle) return const PazlPage();

              if (state is BottomSettings) return const SettingsPage();

              return const GamesPage();
            },
          ),
          const Bottom(),
        ],
      ),
    );
  }
}
