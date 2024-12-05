import 'package:flutter/material.dart';

import '../widgets/page_title.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PageTitle('Matches'),
      ],
    );
  }
}
