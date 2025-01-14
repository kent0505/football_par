import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../blocs/detail/detail_bloc.dart';
import '../models/game.dart';
import '../utils/utils.dart';
import '../widgets/loading.dart';
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
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          return Stack(
            children: [
              ListView(
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
                                formatDate(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'w400',
                                ),
                              ),
                              const Spacer(),
                              Text(
                                widget.game.score,
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
                  if (currentTab == 'Lineups' && state is DetailsLoaded) ...[
                    const SizedBox(height: 16),
                    Center(
                      child: SizedBox(
                        height: 440,
                        width: 280,
                        child: Stack(
                          children: [
                            const MySvg('assets/lineup.svg'),
                            SizedBox(
                              height: 220,
                              child: Stack(
                                children: [
                                  ...List.generate(
                                    state.lineup.players1.length,
                                    (index) {
                                      return _PlayerCard(
                                        player: state.lineup.players1[index],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                height: 220,
                                child: Stack(
                                  children: [
                                    ...List.generate(
                                      state.lineup.players2.length,
                                      (index) {
                                        return _PlayerCard(
                                          player: state.lineup.players2[index],
                                          isWhite: true,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  if (currentTab == 'Stats' && state is DetailsLoaded)
                    ...List.generate(
                      state.stats.length,
                      (index) {
                        return _Stat(
                          title: state.stats[index].title,
                          data1: state.stats[index].team1,
                          data2: state.stats[index].team2,
                        );
                      },
                    ),
                  if (currentTab == 'Goals' && state is DetailsLoaded) ...[
                    ...List.generate(
                      state.goals.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              const SizedBox(width: 28),
                              const MySvg('assets/goal.svg'),
                              const SizedBox(width: 10),
                              Text(
                                '${state.goals[index].player} (${state.goals[index].time})',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'w700',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ],
              ),
              if (state is DetailsLoading) const Loading(),
              Positioned(
                top: statusbar(context),
                left: 10,
                child: MyButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        },
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
    return Positioned(
      top: isWhite ? getTop(player.position) : null,
      left: getLeft(player.position),
      bottom: isWhite ? null : getTop(player.position),
      child: Container(
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
