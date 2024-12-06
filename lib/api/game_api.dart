import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/game.dart';
import '../utils/utils.dart';

class GameApi {
  final dio = Dio();
  final options = Options(
    validateStatus: (status) => true,
    headers: {
      'x-rapidapi-host': dotenv.env['HOST'] ?? '',
      'x-rapidapi-key': dotenv.env['KEY'] ?? '',
    },
  );

  Future<List<Game>> getGames() async {
    try {
      final response = await dio.get(
        'https://v3.football.api-sports.io/fixtures?date=${getYesterdayDate()}',
        options: options,
      );
      List data = response.data['response'];
      List<Game> matches = data.map((json) => Game.fromJson(json)).toList();

      if (matches.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('lastLoadDay', DateTime.now().day);
        await prefs.setString('jsonData', jsonEncode(response.data));
      }

      print(data);

      return matches;
    } on Object catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<List<Game>> getJson(String json) async {
    try {
      final jsonData = jsonDecode(json);
      List data = jsonData['response'];
      List<Game> matches = data.map((json) => Game.fromJson(json)).toList();
      return matches;
    } on Object catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<Stats> fetchStats(int id) async {
    try {
      final response = await dio.get(
        'https://v3.football.api-sports.io/fixtures/statistics?fixture=$id',
        options: options,
      );
      return Stats.fromJson(response.data);
    } on Object catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<List<Goal>> fetchGoals(int id) async {
    try {
      final response = await dio.get(
        'https://v3.football.api-sports.io/fixtures/events?fixture=$id',
        options: options,
      );
      List data = response.data['response'];
      List<Goal> goals = data.map((json) => Goal.fromJson(json)).toList();
      return goals;
    } on Object catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
