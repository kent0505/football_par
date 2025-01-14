import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../blocs/game/game_bloc.dart';
import '../models/game.dart';
import '../utils/utils.dart';
import '../widgets/loading.dart';
import '../widgets/my_button.dart';
import '../widgets/page_title.dart';
import 'game_detail_page.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        if (state is GamesLoading) const Loading();

        if (state is GamesLoaded) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            children: [
              const PageTitle('Matches'),
              const SizedBox(height: 50),
              ...List.generate(
                state.games.length,
                (index) {
                  return _Game(
                    game: state.games[index],
                    games: state.games,
                  );
                },
              ),
              const SizedBox(height: 130),
            ],
          );
        }

        return Container();
      },
    );
  }
}

class _Game extends StatelessWidget {
  const _Game({
    required this.game,
    required this.games,
  });

  final Game game;
  final List<Game> games;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 122,
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: const Color(0xffF8FF13),
        borderRadius: BorderRadius.circular(30),
      ),
      child: MyButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return GameDetailPage(
                  game: game,
                  games: games,
                );
              },
            ),
          );
        },
        child: Row(
          children: [
            const SizedBox(width: 8),
            _Team(
              logo: game.logo1,
              title: game.title1,
              home: 'Home',
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    game.stadium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'w800',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    formatDate(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'w400',
                    ),
                  ),
                  Text(
                    game.score,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 39,
                      fontFamily: 'w900',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            _Team(
              logo: game.logo2,
              title: game.title2,
              home: 'Away',
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class _Team extends StatelessWidget {
  const _Team({
    required this.logo,
    required this.title,
    required this.home,
  });

  final String logo;
  final String title;
  final String home;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          const Spacer(),
          CachedNetworkImage(
            imageUrl: logo,
            height: 55,
            width: 55,
            errorWidget: (context, url, error) {
              return Container();
            },
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'w600',
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            home,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'w300',
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
