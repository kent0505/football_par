import 'package:flutter/material.dart';

import '../widgets/page_title.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PageTitle('News'),
      ],
    );
  }
}
