import 'package:flutter/material.dart';

import 'my_button.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    this.isActive = true,
    required this.onPressed,
  });

  final String title;
  final bool isActive;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xffF8FF13) : const Color(0xffA1A1A1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: MyButton(
        onPressed: isActive ? onPressed : null,
        minSize: 34,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'w900',
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
