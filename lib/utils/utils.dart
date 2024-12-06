import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int getTimestamp() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

double statusbar(BuildContext context) =>
    MediaQuery.of(context).viewPadding.top;

String formatTimestamp(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('dd MMM, yyyy').format(dateTime);
}

String getYesterdayDate() {
  final yesterday = DateTime.now().subtract(const Duration(days: 1));
  return "${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";
}
