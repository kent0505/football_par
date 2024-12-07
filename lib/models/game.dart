import '../utils/utils.dart';

class Game {
  const Game({
    required this.id,
    required this.league,
    required this.title1,
    required this.title2,
    required this.logo1,
    required this.logo2,
    required this.goals1,
    required this.goals2,
    required this.stadium,
    required this.date,
  });

  final int id;
  final String league;
  final String title1;
  final String title2;
  final String logo1;
  final String logo2;
  final int goals1;
  final int goals2;
  final String stadium;
  final int date;

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['fixture']['id'],
      league: json['league']['name'],
      title1: json['teams']['home']['name'],
      title2: json['teams']['away']['name'],
      logo1: json['teams']['home']['logo'],
      logo2: json['teams']['away']['logo'],
      goals1: json['goals']['home'] ?? 0,
      goals2: json['goals']['away'] ?? 0,
      stadium: json['fixture']['venue']['name'] ?? 'null',
      date: json['fixture']['timestamp'] ?? getTimestamp(),
    );
  }
}

class Stats {
  Stats({
    required this.team1,
    required this.team2,
  });

  final Team team1;
  final Team team2;

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      team1: Team.fromJson(json['response'][0]['statistics']),
      team2: Team.fromJson(json['response'][1]['statistics']),
    );
  }
}

class Team {
  Team({
    this.shots = '',
    this.shotsOnGoal = '',
    this.possession = '',
    this.passes = '',
    this.passesAccuracy = '',
    this.fouls = '',
    this.yellowCards = '',
    this.redCards = '',
    this.offsides = '',
    this.corners = '',
  });

  final String shots;
  final String shotsOnGoal;
  final String possession;
  final String passes;
  final String passesAccuracy;
  final String fouls;
  final String yellowCards;
  final String redCards;
  final String offsides;
  final String corners;

  factory Team.fromJson(List<dynamic> statistics) {
    return Team(
      shots: statistics[2]['value'].toString(),
      shotsOnGoal: statistics[0]['value'].toString(),
      possession: statistics[9]['value'].toString(),
      passes: statistics[13]['value'].toString(),
      passesAccuracy: statistics[15]['value'].toString(),
      fouls: statistics[6]['value'].toString(),
      yellowCards: statistics[10]['value'].toString(),
      redCards: statistics[11]['value'].toString(),
      offsides: statistics[8]['value'].toString(),
      corners: statistics[7]['value'].toString(),
    );
  }
}

class Goal {
  Goal({
    required this.player,
    required this.type,
    required this.time,
  });

  final String player;
  final String type;
  final int time;

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      player: json['player']['name'],
      type: json['type'],
      time: json['time']['elapsed'],
    );
  }
}

class Lineup {
  Lineup({required this.team1, required this.team2});

  final List<Player> team1;
  final List<Player> team2;
}

class Player {
  Player({
    required this.name,
    required this.number,
    required this.grid,
  });

  final String name;
  final String number;
  final String grid;

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['player']['name'].toString(),
      number: json['player']['number'].toString(),
      grid: json['player']['grid'].toString(),
    );
  }
}

final statsDefault = Stats(
  team1: Team(),
  team2: Team(),
);
