import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../blocs/detail/detail_bloc.dart';
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
    log(widget.game.id.toString());
    context.read<DetailBloc>().add(GetDetails(fixture: widget.game.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              if (state is DetailsLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                );
              }
              if (state is DetailsLoaded) {
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
                            logo: widget.game.logo1,
                            title: widget.game.title1,
                            home: 'Home',
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                const Spacer(flex: 5),
                                Text(
                                  widget.game.stadium,
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
                                  formatTimestamp(widget.game.date),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'w400',
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${widget.game.goals1}-${widget.game.goals2}',
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
                            logo: widget.game.logo2,
                            title: widget.game.title2,
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
                      Center(
                        child: SizedBox(
                          height: 440,
                          width: 280,
                          child: Stack(
                            children: [
                              const MySvg('assets/lineup.svg'),
                              Column(
                                children: [
                                  const SizedBox(height: 20),
                                  _Players(row: 1, players: state.lineup.team1),
                                  _Players(row: 2, players: state.lineup.team1),
                                  _Players(row: 3, players: state.lineup.team1),
                                  _Players(row: 4, players: state.lineup.team1),
                                  _Players(row: 5, players: state.lineup.team1),
                                  const Spacer(),
                                  _Players(
                                      row: 5,
                                      players: state.lineup.team2,
                                      isWhite: true),
                                  _Players(
                                      row: 4,
                                      players: state.lineup.team2,
                                      isWhite: true),
                                  _Players(
                                      row: 3,
                                      players: state.lineup.team2,
                                      isWhite: true),
                                  _Players(
                                      row: 2,
                                      players: state.lineup.team2,
                                      isWhite: true),
                                  _Players(
                                      row: 1,
                                      players: state.lineup.team2,
                                      isWhite: true),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                    if (currentTab == 'Stats') ...[
                      _Stat(
                        title: 'Shot',
                        data1: state.stats.team1.shots.toString(),
                        data2: state.stats.team2.shots.toString(),
                      ),
                      _Stat(
                        title: 'Shots on target',
                        data1: state.stats.team1.shotsOnGoal.toString(),
                        data2: state.stats.team2.shotsOnGoal.toString(),
                      ),
                      _Stat(
                        title: 'Possession',
                        data1: state.stats.team1.possession.toString(),
                        data2: state.stats.team2.possession.toString(),
                      ),
                      _Stat(
                        title: 'Passes',
                        data1: state.stats.team1.passes.toString(),
                        data2: state.stats.team2.passes.toString(),
                      ),
                      _Stat(
                        title: 'Pass accuracy',
                        data1: state.stats.team1.passesAccuracy.toString(),
                        data2: state.stats.team2.passesAccuracy.toString(),
                      ),
                      _Stat(
                        title: 'Fouls',
                        data1: state.stats.team1.fouls.toString(),
                        data2: state.stats.team2.fouls.toString(),
                      ),
                      _Stat(
                        title: 'Yellow cards',
                        data1: state.stats.team1.yellowCards.toString(),
                        data2: state.stats.team2.yellowCards.toString(),
                      ),
                      _Stat(
                        title: 'Red cards',
                        data1: state.stats.team1.redCards.toString(),
                        data2: state.stats.team2.redCards.toString(),
                      ),
                      _Stat(
                        title: 'Offsides',
                        data1: state.stats.team1.offsides.toString(),
                        data2: state.stats.team2.offsides.toString(),
                      ),
                      _Stat(
                        title: 'Corners',
                        data1: state.stats.team1.corners.toString(),
                        data2: state.stats.team2.corners.toString(),
                      ),
                    ],
                    if (currentTab == 'Goals') ...[
                      ...List.generate(
                        state.goals.length,
                        (index) {
                          if (state.goals[index].type == 'Goal') {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  const SizedBox(width: 28),
                                  const MySvg('assets/goal.svg'),
                                  const SizedBox(width: 10),
                                  Text(
                                    state.goals[index].player,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'w700',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ],
                );
              }

              return Container();
            },
          ),
          Positioned(
            top: statusbar(context),
            left: 10,
            child: MyButton(
              onPressed: () => Navigator.pop(context),
              child: BlocBuilder<DetailBloc, DetailState>(
                builder: (context, state) {
                  return Icon(
                    Icons.arrow_back_ios_rounded,
                    color: state is DetailsLoaded ? Colors.black : Colors.white,
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

class _Players extends StatelessWidget {
  const _Players({
    required this.row,
    required this.players,
    this.isWhite = false,
  });

  final int row;
  final List<Player> players;
  final bool isWhite;

  int getGrid(String grid) {
    try {
      return int.parse(grid.split(':')[0]);
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (Player player in players) ...[
            if (getGrid(player.grid) == row) ...[
              _PlayerCard(player: player, isWhite: isWhite),
            ],
          ],
        ],
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({
    required this.player,
    this.isWhite = false,
  });

  final Player player;
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isWhite ? Colors.white : const Color(0xffF8FF13),
      ),
      child: Center(
        child: Text(
          player.number,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'w500',
          ),
        ),
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
  final String data1;
  final String data2;

  @override
  Widget build(BuildContext context) {
    double d1 = double.tryParse(data1.replaceAll('%', '')) ?? 0;
    double d2 = double.tryParse(data2.replaceAll('%', '')) ?? 0;
    double total = (d1 + d2).clamp(1, double.infinity);
    double percentage1 = d1 / total;
    double percentage2 = d2 / total;
    double maxWidth = (MediaQuery.of(context).size.width - 72) / 2;
    double calculatedWidth1 = (percentage1 * maxWidth).clamp(0, maxWidth);
    double calculatedWidth2 = (percentage2 * maxWidth).clamp(0, maxWidth);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Text(
                data1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'w700',
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'w800',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              Text(
                data2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'w700',
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 7,
                child: Stack(
                  children: [
                    Container(
                      height: 7,
                      width: (MediaQuery.of(context).size.width - 72) / 2,
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
                child: Stack(
                  children: [
                    Container(
                      height: 7,
                      width: (MediaQuery.of(context).size.width - 72) / 2,
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
