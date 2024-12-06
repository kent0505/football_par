import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../blocs/game/game_bloc.dart';
import '../models/game.dart';
import '../utils/utils.dart';
import '../widgets/my_button.dart';
import '../widgets/my_svg.dart';

class GameDetailPage extends StatefulWidget {
  const GameDetailPage({
    super.key,
    required this.game,
    required this.games,
  });

  final Game game;
  final List<Game> games;

  @override
  State<GameDetailPage> createState() => _GameDetailPageState();
}

class _GameDetailPageState extends State<GameDetailPage> {
  late Game game;
  String currentTab = 'Stats';

  void onTab(String value) {
    if (currentTab == value) return;
    setState(() {
      currentTab = value;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<GameBloc>().add(GetStats(
          id: widget.game.id,
          games: widget.games,
        ));
    for (Game g in widget.games) {
      if (g.id == widget.game.id) game = g;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              if (state is GamesLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }

              if (state is GamesLoaded) {
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 204,
                      decoration: const BoxDecoration(
                        color: Color(0xffF8FF13),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(46),
                        ),
                      ),
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
                              children: [
                                const Spacer(flex: 5),
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
                                const Spacer(),
                                Text(
                                  formatTimestamp(game.date),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'w400',
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${game.goals1}-${game.goals2}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 39,
                                    fontFamily: 'w900',
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const Spacer(),
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
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _Tab(
                          title: 'Lineups',
                          current: currentTab,
                          onPressed: onTab,
                        ),
                        const SizedBox(width: 40),
                        _Tab(
                          title: 'Stats',
                          current: currentTab,
                          onPressed: onTab,
                        ),
                        const SizedBox(width: 40),
                        _Tab(
                          title: 'Goals',
                          current: currentTab,
                          onPressed: onTab,
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    if (currentTab == 'Lineups') ...[
                      const SizedBox(height: 16),
                      const MySvg('assets/lineup.svg'),
                    ],
                    if (currentTab == 'Stats') ...[
                      _Stat(
                        title: 'Shot',
                        data1: state.stats!.team1.shots.toString(),
                        data2: state.stats!.team2.shots.toString(),
                      ),
                      _Stat(
                        title: 'Shots on target',
                        data1: state.stats!.team1.shotsOnGoal.toString(),
                        data2: state.stats!.team2.shotsOnGoal.toString(),
                      ),
                      _Stat(
                        title: 'Possession',
                        data1: state.stats!.team1.possession.toString(),
                        data2: state.stats!.team2.possession.toString(),
                      ),
                      _Stat(
                        title: 'Passes',
                        data1: state.stats!.team1.passes.toString(),
                        data2: state.stats!.team2.passes.toString(),
                      ),
                      _Stat(
                        title: 'Pass accuracy',
                        data1: state.stats!.team1.passesAccuracy.toString(),
                        data2: state.stats!.team2.passesAccuracy.toString(),
                      ),
                      _Stat(
                        title: 'Fouls',
                        data1: state.stats!.team1.fouls.toString(),
                        data2: state.stats!.team2.fouls.toString(),
                      ),
                      _Stat(
                        title: 'Yellow cards',
                        data1: state.stats!.team1.yellowCards.toString(),
                        data2: state.stats!.team2.yellowCards.toString(),
                      ),
                      _Stat(
                        title: 'Red cards',
                        data1: state.stats!.team1.redCards.toString(),
                        data2: state.stats!.team2.redCards.toString(),
                      ),
                      _Stat(
                        title: 'Offsides',
                        data1: state.stats!.team1.offsides.toString(),
                        data2: state.stats!.team2.offsides.toString(),
                      ),
                      _Stat(
                        title: 'Corners',
                        data1: state.stats!.team1.corners.toString(),
                        data2: state.stats!.team2.corners.toString(),
                      ),
                    ],
                    if (currentTab == 'Goals') ...[],
                  ],
                );
              }

              return Container();
            },
          ),
          Positioned(
            top: 10 + statusbar(context),
            left: 10,
            child: MyButton(
              onPressed: () => Navigator.pop(context),
              child: BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Icon(
                    Icons.arrow_back_ios_rounded,
                    color: state is GamesLoaded ? Colors.black : Colors.white,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.title,
    required this.current,
    required this.onPressed,
  });

  final String title;
  final String current;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: () {
        onPressed(title);
      },
      minSize: 30,
      child: Container(
        height: 30,
        width: 84,
        decoration: BoxDecoration(
          color: title == current
              ? const Color(0xffF8FF13)
              : const Color(0xffA1A1A1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'w600',
              fontStyle: FontStyle.italic,
            ),
          ),
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
          const Spacer(flex: 3),
          CachedNetworkImage(
            imageUrl: logo,
            height: 55,
            width: 55,
          ),
          const SizedBox(height: 6),
          Text(
            title,
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
          const Spacer(),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.title,
    required this.data1,
    required this.data2,
  });

  final String title;
  final String? data1;
  final String? data2;

  @override
  Widget build(BuildContext context) {
    double d1 = double.tryParse(data1?.replaceAll('%', '') ?? '') ?? 0;
    double d2 = double.tryParse(data2?.replaceAll('%', '') ?? '') ?? 0;
    double total = (d1 + d2).clamp(1, double.infinity);
    double percentage1 = d1 / total;
    double percentage2 = d2 / total;
    double maxWidth = 160;
    double calculatedWidth1 = (percentage1 * maxWidth).clamp(0, maxWidth);
    double calculatedWidth2 = (percentage2 * maxWidth).clamp(0, maxWidth);

    return Padding(
      padding: const EdgeInsets.only(
        left: 36,
        right: 36,
        bottom: 12,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                data1 ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'w700',
                ),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'w800',
                  fontStyle: FontStyle.italic,
                ),
              ),
              const Spacer(),
              Text(
                data2 ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'w700',
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 7,
                width: 160,
                child: Stack(
                  children: [
                    Container(
                      height: 7,
                      width: 160,
                      decoration: BoxDecoration(
                        color: const Color(0xff525252),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    Container(
                      height: 7,
                      width: calculatedWidth1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 7,
                width: 160,
                child: Stack(
                  children: [
                    Container(
                      height: 7,
                      width: 160,
                      decoration: BoxDecoration(
                        color: const Color(0xff525252),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    Container(
                      height: 7,
                      width: calculatedWidth2,
                      decoration: BoxDecoration(
                        color: const Color(0xffF8FF13),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
