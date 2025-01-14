import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/game.dart';

class GameApi {
  final _dio = Dio();
  final _options = Options(
    validateStatus: (status) => true,
    receiveTimeout: const Duration(seconds: 5),
    sendTimeout: const Duration(seconds: 5),
  );

  String baseUrl = dotenv.env['URL'] ?? '';

  Future<List<Game>> getGames() async {
    try {
      final response = await _dio.get(
        '$baseUrl/fixtures',
        options: _options,
      );
      List<dynamic> data = response.data['fixtures'];
      List<Game> matches = data.map((json) {
        return Game.fromJson(json);
      }).toList();
      print(response.statusCode);
      return matches;
    } on Object catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<List<Goal>> fetchGoals(int id) async {
    try {
      final response = await _dio.get(
        '$baseUrl/goals/$id',
        options: _options,
      );
      List<dynamic> data = response.data['goals'];
      List<Goal> goals = data.map((json) {
        return Goal.fromJson(json);
      }).toList();
      return goals;
    } on Object catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<List<Stats>> fetchStats(int id) async {
    try {
      final response = await _dio.get(
        '$baseUrl/stats/$id',
        options: _options,
      );
      List<dynamic> data = response.data['stats'];
      List<Stats> stats = data.map((json) {
        return Stats.fromJson(json);
      }).toList();
      return stats;
    } on Object catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<Lineup> fetchLineups(int id) async {
    try {
      final response = await _dio.get(
        '$baseUrl/lineups/$id',
        options: _options,
      );
      return Lineup.fromJson(response.data);
    } on Object catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
