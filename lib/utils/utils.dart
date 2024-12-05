import 'dart:developer' as developer;

import 'package:flutter/material.dart';

int getTimestamp() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

double statusbar(BuildContext context) =>
    MediaQuery.of(context).viewPadding.top;

void logger(Object message) => developer.log(message.toString());
