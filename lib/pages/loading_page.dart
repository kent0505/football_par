import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/game/game_bloc.dart';
import 'home_page.dart';
import 'onboard_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<GameBloc, GameState>(
        listener: (context, state) {
          if (state is DataLoaded) {
            context.read<GameBloc>().add(GetGames());

            Future.delayed(
              const Duration(seconds: 2),
              () {
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return state.onboard
                            ? const OnboardPage()
                            : const HomePage();
                      },
                    ),
                    (route) => false,
                  );
                }
              },
            );
          }
        },
        child: const Center(
          child: CupertinoActivityIndicator(
            color: Color(0xffF8FF13),
            radius: 14,
          ),
        ),
      ),
    );
  }
}
