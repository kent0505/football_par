import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:football_par/utils/utils.dart';

import '../widgets/button.dart';
import '../widgets/my_button.dart';
import '../widgets/my_dialog.dart';
import '../widgets/page_title.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  final List<int> _tiles = [...List.generate(15, (index) => index + 2), 0];
  int emptyIndex = 0;
  int level = 1;
  bool isActive = false;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    final rand = Random();
    for (var i = _tiles.length - 1; i > 0; i--) {
      final j = rand.nextInt(i + 1);
      final temp = _tiles[i];
      _tiles[i] = _tiles[j];
      _tiles[j] = temp;
    }
    emptyIndex = _tiles.indexOf(0);
  }

  void _moveTile(int index) {
    final emptyRow = emptyIndex ~/ 4;
    final emptyCol = emptyIndex % 4;
    final targetRow = index ~/ 4;
    final targetCol = index % 4;

    if ((emptyRow == targetRow && (emptyCol - targetCol).abs() == 1) ||
        (emptyCol == targetCol && (emptyRow - targetRow).abs() == 1)) {
      setState(() {
        _tiles[emptyIndex] = _tiles[index];
        _tiles[index] = 0;
        emptyIndex = index;
        _checkWinCondition();
      });
    }
  }

  void _checkWinCondition() async {
    final winningTiles = [0, ...List.generate(15, (index) => index + 2)];
    logger(winningTiles);
    logger(_tiles);
    if (listEquals(_tiles, winningTiles)) {
      if (level == 20) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return MyDialog(
              title: 'You win!',
              onlyClose: true,
              onPressed: () {},
            );
          },
        ).then((value) {
          if (mounted) Navigator.pop(context);
        });
      } else {
        setState(() {
          isActive = true;
        });
      }
    } else {
      setState(() {
        isActive = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final containerSize = MediaQuery.of(context).size.width - 40;
    final tileSize = (containerSize - 14) / 4 + 4;

    return Column(
      children: [
        const PageTitle('Puzzles'),
        const Spacer(),
        Center(
          child: SizedBox(
            width: containerSize,
            height: containerSize,
            child: Stack(
              children: List.generate(16, (index) {
                final tile = _tiles[index];
                final row = index ~/ 4;
                final col = index % 4;

                if (tile == 0) return const SizedBox.shrink();

                return AnimatedPositioned(
                  left: col * tileSize,
                  top: row * tileSize,
                  duration: const Duration(milliseconds: 300),
                  child: MyButton(
                    onPressed: () => _moveTile(index),
                    child: Container(
                      width: tileSize,
                      height: tileSize,
                      padding: const EdgeInsets.all(5),
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
                );
              }),
            ),
          ),
        ),
        const Spacer(),
        Button(
          title: 'Next',
          isActive: isActive,
          onPressed: () {
            setState(() {
              level++;
              _shuffle();
            });
          },
        ),
        const SizedBox(height: 96),
      ],
    );
  }
}
