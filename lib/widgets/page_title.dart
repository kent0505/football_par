import 'package:flutter/material.dart';

import '../utils/utils.dart';

class PageTitle extends StatelessWidget {
  const PageTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16 + statusbar(context)),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xffF8FF13),
            fontSize: 39,
            fontFamily: 'w900',
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
