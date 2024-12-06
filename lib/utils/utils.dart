import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int getTimestamp() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

double statusbar(BuildContext context) =>
    MediaQuery.of(context).viewPadding.top;

String formatTimestamp(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('dd MMM, yyyy').format(dateTime);
}
