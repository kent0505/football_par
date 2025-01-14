import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int getTimestamp() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

double statusbar(BuildContext context) {
  return MediaQuery.of(context).viewPadding.top;
}

String formatTimestamp(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return DateFormat('dd MMM, yyyy').format(dateTime);
}

String formatDate() {
  DateTime now = DateTime.now();
  DateTime updatedTime = now.subtract(const Duration(days: 1, hours: 12));
  String formattedDate = DateFormat("dd MMM, yyyy").format(updatedTime);
  return formattedDate;
}

String getFixtureDate() {
  final yesterday = DateTime.now().subtract(const Duration(days: 2));
  return "${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";
}

double getTop(String grid) {
  return double.parse(grid.split('x')[1]) / 1.4 + 30;
}

double getLeft(String grid) {
  return double.parse(grid.split('x')[0]) / 1.46;
}
