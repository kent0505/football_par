import 'package:flutter/material.dart';

import 'my_button.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xff1C1C1E),
      child: Container(
        height: 200,
        width: 240,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'w900',
              ),
            ),
            const Spacer(),
            MyButton(
              padding: 0,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'OK',
                    style: TextStyle(
                      color: Color(0xffF8FF13),
                      fontSize: 16,
                      fontFamily: 'w700',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
