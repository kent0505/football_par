import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../widgets/button.dart';
import '../widgets/my_button.dart';
import '../widgets/my_dialog.dart';
import '../widgets/my_svg.dart';
import '../widgets/page_title.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  final tiles = [...List.generate(15, (index) => index + 2), 0];
  final winningTiles = [0, ...List.generate(15, (index) => index + 2)];
  int emptyIndex = 0;
  int level = 1;
  bool isActive = false;
  bool started = false;

  void shuffle() {
    final rand = Random();
    for (var i = tiles.length - 1; i > 0; i--) {
      final j = rand.nextInt(i + 1);
      final temp = tiles[i];
      tiles[i] = tiles[j];
      tiles[j] = temp;
    }
    emptyIndex = tiles.indexOf(0);
  }

  void moveTile(int index) {
    final emptyRow = emptyIndex ~/ 4;
    final emptyCol = emptyIndex % 4;
    final targetRow = index ~/ 4;
    final targetCol = index % 4;

    if ((emptyRow == targetRow && (emptyCol - targetCol).abs() == 1) ||
        (emptyCol == targetCol && (emptyRow - targetRow).abs() == 1)) {
      setState(() {
        tiles[emptyIndex] = tiles[index];
        tiles[index] = 0;
        emptyIndex = index;
        checkWin();
      });
    }
  }

  void checkWin() async {
    // logger(winningTiles);
    // logger(tiles);
    if (listEquals(tiles, winningTiles)) {
      if (level == 20) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const MyDialog(title: 'Well done!');
          },
        ).then((value) {
          setState(() {
            started = false;
          });
        });
      } else {
        setState(() {
          isActive = true;
        });
      }
    } else {
      if (isActive) {
        setState(() {
          logger('SET STATE');
          isActive = false;
        });
      }
    }
  }

  void onNext() {
    if (started) {
      if (level == 20) {
      } else {
        setState(() {
          level++;
          shuffle();
        });
      }
    } else {
      setState(() {
        started = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final containerSize = MediaQuery.of(context).size.width - 80;
    final tileSize = (containerSize - 14) / 4 + 4;

    return Column(
      children: [
        PageTitle(started ? 'Level $level/20' : 'Puzzles'),
        if (started) ...[
          const Spacer(),
          SizedBox(
            width: containerSize,
            height: containerSize,
            child: Stack(
              children: List.generate(16, (index) {
                final tile = tiles[index];
                final row = index ~/ 4;
                final col = index % 4;

                if (tile == 0) return const SizedBox.shrink();

                return Positioned(
                  left: col * tileSize,
                  top: row * tileSize,
                  child: MyButton(
                    onPressed: () => moveTile(index),
                    child: Container(
                      width: tileSize,
                      height: tileSize,
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        color: const Color(0xffF8FF13),
                        padding: const EdgeInsets.all(3),
                        child: tile > 0
                            ? Stack(
                                children: [
                                  Image.asset(
                                    'assets/p$tile.png',
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container();
                                    },
                                  ),
                                  Center(
                                    child: Text(
                                      tile.toString(),
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 24,
                                        fontFamily: 'w900',
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const Spacer(),
        ] else ...[
          const Spacer(),
          const MySvg('assets/puzzle1.svg'),
          const Spacer(),
          const Text(
            'Test your attentiveness in an exciting puzzles game.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontFamily: 'w700',
            ),
          ),
          const Spacer(),
          const MySvg('assets/puzzle2.svg'),
          const Spacer(),
        ],
        Button(
          title: started ? 'Next' : 'Start',
          isActive: started ? isActive : true,
          onPressed: onNext,
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}
