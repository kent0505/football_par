import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bottom/bottom_bloc.dart';
import 'my_button.dart';
import 'my_svg.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 73,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xffF8FF13),
          borderRadius: BorderRadius.circular(73),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 15,
              offset: Offset(0, -10),
            ),
          ],
        ),
        child: BlocBuilder<BottomBloc, BottomState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Button(
                  id: 1,
                  title: 'Home',
                  isActive: state is BottomInitial,
                ),
                _Button(
                  id: 2,
                  title: 'News',
                  isActive: state is BottomNews,
                ),
                _Button(
                  id: 3,
                  title: 'Quiz',
                  isActive: state is BottomQuiz,
                ),
                _Button(
                  id: 4,
                  title: 'Puzzle',
                  isActive: state is BottomPuzzle,
                ),
                _Button(
                  id: 5,
                  title: 'Settings',
                  isActive: state is BottomSettings,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.id,
    required this.title,
    required this.isActive,
  });

  final int id;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      onPressed: isActive
          ? null
          : () => context.read<BottomBloc>().add(ChangeBottom(id: id)),
      padding: 0,
      child: SizedBox(
        width: 64,
        height: 73,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              top: isActive ? 15 : 21,
              left: 0,
              right: 0,
              child: MySvg('assets/b$id.svg'),
            ),
            const SizedBox(height: 7),
            if (isActive)
              Positioned(
                bottom: 14,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'w400',
                    ),
                  ),
                ),
              ),
            if (isActive)
              const Positioned(
                bottom: -1,
                child: MySvg('assets/b.svg'),
              ),
          ],
        ),
      ),
    );
  }
}
