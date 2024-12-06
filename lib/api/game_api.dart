import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/game.dart';
import '../utils/utils.dart';

class GameApi {
  final dio = Dio();
  final options = Options(
    validateStatus: (status) => true,
    headers: {
      'x-rapidapi-host': 'v3.football.api-sports.io',
      // 'x-rapidapi-key': 'aad567230b15af533a80bf5aa13a14cb',
      'x-rapidapi-key': 'e0fbe3beaaed6d5b1321d8a9cbeaf93a'
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
      print(response.data);
      return Stats.fromJson(response.data);
    } on Object catch (error, stackTrace) {
      print(error);
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
      print(data);
      List<Goal> goals = data.map((json) => Goal.fromJson(json)).toList();
      return goals;
    } on Object catch (error, stackTrace) {
      print(error);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
