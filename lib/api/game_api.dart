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

// class GameApi {
//   final dio = Dio();

//   Future<List<Game>> getGames() async {
//     try {
//       final response = await dio.get(
//         'https://v3.football.api-sports.io/fixtures',
//         queryParameters: {
//           'date': getFixtureDate(),
//         },
//         options: Options(
//           validateStatus: (status) => true,
//           headers: {
//             'x-rapidapi-host': 'v3.football.api-sports.io',
//             'x-rapidapi-key': 'aad567230b15af533a80bf5aa13a14cb',
//           },
//         ),
//       );
//       log(response.data.toString());
//       List data = response.data['response'];
//       List<Game> matches = data.map((json) => Game.fromJson(json)).toList();

//       if (matches.isNotEmpty) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setInt('lastLoadDay', DateTime.now().day);
//         await prefs.setString('jsonData', jsonEncode(response.data));
//       }

//       return matches;
//     } on Object catch (error, stackTrace) {
//       Error.throwWithStackTrace(error, stackTrace);
//     }
//   }

//   Future<List<Game>> getJson(String json) async {
//     try {
//       final jsonData = jsonDecode(json);
//       List data = jsonData['response'];
//       List<Game> matches = data.map((json) => Game.fromJson(json)).toList();
//       return matches;
//     } on Object catch (error, stackTrace) {
//       Error.throwWithStackTrace(error, stackTrace);
//     }
//   }

//   Future<Stats> fetchStats(int id) async {
//     try {
//       final response = await dio.get(
//         'https://v3.football.api-sports.io/fixtures/statistics',
//         queryParameters: {
//           'fixture': id,
//         },
//         options: Options(
//           validateStatus: (status) => true,
//           headers: {
//             'x-rapidapi-host': 'v3.football.api-sports.io',
//             'x-rapidapi-key': 'e0fbe3beaaed6d5b1321d8a9cbeaf93a'
//           },
//         ),
//       );
//       log(response.data.toString());
//       return Stats.fromJson(response.data);
//     } on Object catch (error, stackTrace) {
//       log(error.toString());
//       Error.throwWithStackTrace(error, stackTrace);
//     }
//   }

//   Future<List<Goal>> fetchGoals(int id) async {
//     try {
//       final response = await dio.get(
//         'https://v3.football.api-sports.io/fixtures/events',
//         queryParameters: {
//           'fixture': id,
//         },
//         options: Options(
//           validateStatus: (status) => true,
//           headers: {
//             'x-rapidapi-host': 'v3.football.api-sports.io',
//             'x-rapidapi-key': '55605a0c9e5741a21d81e6476451a6ed'
//           },
//         ),
//       );
//       log(response.data.toString());
//       List data = response.data['response'];

//       List<Goal> goals = data.map((json) => Goal.fromJson(json)).toList();
//       return goals;
//     } on Object catch (error, stackTrace) {
//       log('ERROR');
//       log(error.toString());
//       Error.throwWithStackTrace(error, stackTrace);
//     }
//   }

//   Future<Lineup> fetchLineups(int id) async {
//     try {
//       final response = await dio.get(
//         'https://v3.football.api-sports.io/fixtures/lineups',
//         queryParameters: {
//           'fixture': id,
//         },
//         options: Options(
//           validateStatus: (status) => true,
//           headers: {
//             'x-rapidapi-host': 'v3.football.api-sports.io',
//             'x-rapidapi-key': '8bc4a52868a891ea05ac8ad4e55b9e5f'
//           },
//         ),
//       );
//       log(response.data.toString());

//       List data1 = response.data['response'][0]['startXI'];
//       List data2 = response.data['response'][1]['startXI'];

//       return Lineup(
//         team1: data1.map((json) => Player.fromJson(json)).toList(),
//         team2: data2.map((json) => Player.fromJson(json)).toList(),
//       );
//     } on Object catch (error, stackTrace) {
//       log(error.toString());
//       Error.throwWithStackTrace(error, stackTrace);
//     }
//   }
// }
