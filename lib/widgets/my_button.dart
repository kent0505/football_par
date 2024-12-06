import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.onPressed,
    this.padding = 0,
    this.minSize = kMinInteractiveDimensionCupertino,
    required this.child,
  });

  final void Function()? onPressed;
  final double padding;
  final double minSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'w400',
            color: Colors.black,
          ),
          dateTimePickerTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'w400',
          ),
        ),
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.all(padding),
        minSize: minSize,
        child: child,
      ),
    );
  }
}