import 'package:flutter/material.dart';

import '../widgets/my_button.dart';
import '../widgets/my_svg.dart';
import '../widgets/page_title.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PageTitle('Settings'),
        Spacer(),
        _Button(id: 1, title: 'Share with friends'),
        _Button(id: 2, title: 'Terms of use'),
        _Button(id: 3, title: 'Privacy Policy'),
        Spacer(flex: 2),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.id,
    required this.title,
  });

  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      margin: const EdgeInsets.only(
        bottom: 14,
        left: 30,
        right: 30,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF8FF13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: MyButton(
        onPressed: () {
          if (id == 1) {
          } else if (id == 2) {
          } else if (id == 3) {}
        },
        minSize: 34,
        child: Stack(
          children: [
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: MySvg('assets/s$id.svg'),
            ),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'w800',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
