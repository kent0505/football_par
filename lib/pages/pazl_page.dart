import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/my_button.dart';
import '../widgets/my_dialog.dart';
import '../widgets/my_svg.dart';
import '../widgets/page_title.dart';

class PazlPage extends StatefulWidget {
  const PazlPage({super.key});

  @override
  State<PazlPage> createState() => _PazlPageState();
}

class _PazlPageState extends State<PazlPage> {
  final puzzleTiles = [...List.generate(15, (index) => index + 2), 0];
  final winningConfig = [0, ...List.generate(15, (index) => index + 2)];
  int emptyTileIndex = 0;
  int currentLevel = 1;
  bool isLevelCompleted = false;
  bool gameStarted = false;

  void shuffleTiles() {
    final random = Random();
    for (var i = puzzleTiles.length - 1; i > 0; i--) {
      final randomIndex = random.nextInt(i + 1);
      final temp = puzzleTiles[i];
      puzzleTiles[i] = puzzleTiles[randomIndex];
      puzzleTiles[randomIndex] = temp;
    }
    emptyTileIndex = puzzleTiles.indexOf(0);
  }

  void moveTile(int tileIndex) {
    final emptyRow = emptyTileIndex ~/ 4;
    final emptyColumn = emptyTileIndex % 4;
    final tileRow = tileIndex ~/ 4;
    final tileColumn = tileIndex % 4;

    if ((emptyRow == tileRow && (emptyColumn - tileColumn).abs() == 1) ||
        (emptyColumn == tileColumn && (emptyRow - tileRow).abs() == 1)) {
      setState(() {
        puzzleTiles[emptyTileIndex] = puzzleTiles[tileIndex];
        puzzleTiles[tileIndex] = 0;
        emptyTileIndex = tileIndex;
        checkForWin();
      });
    }
  }

  void checkForWin() async {
    if (listEquals(puzzleTiles, winningConfig)) {
      if (currentLevel == 20) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const MyDialog(title: 'Well done!');
          },
        ).then((_) => setState(() => gameStarted = false));
      } else {
        setState(() => isLevelCompleted = true);
      }
    } else {
      if (isLevelCompleted) setState(() => isLevelCompleted = false);
    }
  }

  void handleNextLevel() {
    if (gameStarted) {
      if (currentLevel < 20) {
        setState(() {
          currentLevel++;
          shuffleTiles();
        });
      }
    } else {
      setState(() => gameStarted = true);
    }
  }

  @override
  void initState() {
    super.initState();
    shuffleTiles();
  }

  @override
  Widget build(BuildContext context) {
    final boardSize = MediaQuery.of(context).size.width - 80;
    final tileDimension = (boardSize - 14) / 4 + 4;
    return Column(
      children: [
        PageTitle(gameStarted ? 'Level $currentLevel/20' : 'Puzzles'),
        if (gameStarted) ...[
          const Spacer(),
          SizedBox(
            width: boardSize,
            height: boardSize,
            child: Stack(
              children: List.generate(16, (index) {
                final tileValue = puzzleTiles[index];
                final row = index ~/ 4;
                final col = index % 4;
                if (tileValue == 0) return const SizedBox.shrink();
                return Positioned(
                  left: col * tileDimension,
                  top: row * tileDimension,
                  child: MyButton(
                    onPressed: () => moveTile(index),
                    child: Container(
                      width: tileDimension,
                      height: tileDimension,
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        color: const Color(0xffF8FF13),
                        padding: const EdgeInsets.all(3),
                        child: tileValue > 0
                            ? Image.asset(
                                'assets/p$tileValue.png',
                                errorBuilder: (context, error, stackTrace) {
                                  return Container();
                                },
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
          title: gameStarted ? 'Next' : 'Start',
          isActive: gameStarted ? isLevelCompleted : true,
          onPressed: handleNextLevel,
        ),
        const SizedBox(height: 130),
      ],
    );
  }
}
